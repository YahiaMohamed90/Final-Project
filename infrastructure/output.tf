output "server_ip" {
  value = aws_instance.server.public_ip
}

output "ECR_url" {
  value = aws_ecr_repository.demo-ecr.repository_url
}
