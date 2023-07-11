output "vim-ip" {
  value = aws_instance.terraform-vm1.public_ip
}

output "vim2-ip" {
  value = aws_instance.terraform-vm2.public_ip
}

output "vim3-ip" {
  value = aws_instance.terraform-vm3.public_ip
}

output "vm1-id" {
  value = aws_instance.terraform-vm1.id

}