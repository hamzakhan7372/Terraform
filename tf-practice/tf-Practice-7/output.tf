output "publicip" {
    value = aws_instance.sample_instance.public_ip
}

output "privateip" {
  value = aws_instance.sample_instance.private_ip

}