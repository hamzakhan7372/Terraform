output "vpc_id" {
  value = aws_vpc.tf_practice_vpc.id
}
 
output "subnet-pub-1" {
  value = aws_subnet.tf_pub_subnet_1.id
} 

/* output "subnet-pub-2" {
  value = aws_subnet.tf_pub_subnet_2.id
} 

output "subnet-pub-3" {
  value = aws_subnet.tf_pub_subnet_3.id
}  */

output "security-group-1" {
  value = aws_security_group.tf-security-group-1.id
}

