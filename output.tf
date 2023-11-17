output "vm_public_ip" {
  value = aws_instance.web.public_ip
}
output "s3_bucket_domain" {
  value = aws_s3_bucket.bucket.bucket_domain_name
}
