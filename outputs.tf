# ============================================================
# outputs.tf – Ausgaben nach erfolgreichem Deployment
# ============================================================

output "cloudfront_url" {
  description = "URL der CloudFront-Distribution (Hauptzugriffspunkt)"
  value       = "https://${aws_cloudfront_distribution.main.domain_name}"
}

output "alb_dns_name" {
  description = "DNS-Name des Application Load Balancers"
  value       = aws_lb.main.dns_name
}

output "s3_bucket_name" {
  description = "Name des S3-Buckets fuer statische Inhalte"
  value       = aws_s3_bucket.static.id
}

output "vpc_id" {
  description = "ID der erstellten VPC"
  value       = aws_vpc.main.id
}

output "asg_name" {
  description = "Name der Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}
