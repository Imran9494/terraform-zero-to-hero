output "load_balancer_dns_name" {
  description = "value of the load balancer DNS name"
  value       = aws_lb.mylb.dns_name
}