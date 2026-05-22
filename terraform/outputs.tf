output "backend_url" {
  description = "Backend API is proxied through the same frontend URL."
  value       = "http://${aws_instance.app.public_ip}/movie"
}

output "frontend_url" {
  description = "Open this URL to see your React website live on AWS."
  value       = "http://${aws_instance.app.public_ip}"
}

output "ssh_command" {
  description = "SSH command if your key file is in the current folder."
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.app.public_ip}"
}
