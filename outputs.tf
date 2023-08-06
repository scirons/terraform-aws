output "server_public_ip" {
  description = "IPv4 Address"
  value = aws_instance.instance.public_ip
}

output "server_ipv6_public_ip" {
  description = "IPv6 Address"
  value = aws_instance.instance.ipv6_addresses
}

output "instance-id" {
  description = "The EC2 instance ID"
  value       = aws_instance.instance.id
}
