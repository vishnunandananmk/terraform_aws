output "prod_lb_domain" {
  value = aws_lb.prod.dns_name
}

output "route53_nameservers" {
  description = "The nameservers provided by Route 53 for the domain"
  value       = aws_route53_zone.prod.name_servers
}
