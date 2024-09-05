# Route 53 Hosted Zone for the base domain
resource "aws_route53_zone" "prod" {
  name = var.prod_base_domain
}

# ACM Certificate for the base domain
resource "aws_acm_certificate" "prod_backend" {
  domain_name       = var.prod_base_domain
  validation_method = "DNS"
}

# Create DNS validation CNAME record for ACM in Route 53
resource "aws_route53_record" "prod_backend_certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.prod_backend.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = aws_route53_zone.prod.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]

  allow_overwrite = true
}

# Validate ACM certificate once the CNAME record is created
resource "aws_acm_certificate_validation" "prod_backend" {
  certificate_arn         = aws_acm_certificate.prod_backend.arn
  validation_record_fqdns = [for record in aws_route53_record.prod_backend_certificate_validation : record.fqdn]

  depends_on = [aws_route53_record.prod_backend_certificate_validation]
}

# Create an A record in Route 53 that points to the Load Balancer (ALB)
resource "aws_route53_record" "prod_backend_a" {
  zone_id = aws_route53_zone.prod.zone_id
  name    = var.prod_base_domain
  type    = "A"

  alias {
    name                   = aws_lb.prod.dns_name
    zone_id                = aws_lb.prod.zone_id
    evaluate_target_health = true
  }
}

