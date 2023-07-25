####### Keypair
resource "aws_key_pair" "tf-sample-key" {
  key_name   = "tf-sample-key"
  public_key = file("~/.ssh/tf-sample-key.pub")
  tags = {
    "key" = "tf-sample-key"
  } 
}


####### EC2
resource "aws_instance" "tf-instance" {
  ami                    = var.ec2-ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tf-sample-key.key_name
  subnet_id              = var.subnet-pub-1
  vpc_security_group_ids = [var.security-group-1]



  tags = {
    "Name" = "tf-ec2-instance"
  } 

  #copying files using provisioner
  provisioner "file" {
    source      = "bash_ansible.sh"
    destination = "/home/ubuntu/bash_ansible.sh"
  }
  provisioner "file" {
    source      = "bash_docker.sh"
    destination = "/home/ubuntu/bash_docker.sh"
  }
  provisioner "file" {
    source      = "playbook-docker.yaml"
    destination = "/home/ubuntu/playbook-docker.yaml"
  }

  #executing files using provisioner
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/bash_ansible.sh",
      "chmod +x /home/ubuntu/bash_docker.sh",
      "sudo /home/ubuntu/bash_ansible.sh",
      "sudo /home/ubuntu/bash_docker.sh",
      "ansible-playbook /home/ubuntu/playbook-docker.yaml"
    ]
  }

  #establishing connection
  connection {
    user        = var.user
    private_key = file("~/.ssh/tf-sample-key")
    host        = self.public_ip
  }

} 