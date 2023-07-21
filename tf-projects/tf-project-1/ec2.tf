resource "aws_key_pair" "tf-sample-key" {
  key_name   = "tf-sample-key"
  public_key = file("~/.ssh/tf-sample-key.pub")
  tags = {
    "key" = "tf-sample-key"
  }

}

resource "aws_instance" "tf-instance" {
  ami                    = var.ec2-ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.tf-sample-key.key_name
  subnet_id              = aws_subnet.tf_pub_subnet_1.id
  vpc_security_group_ids = [aws_security_group.tf-security-group-1.id]



  tags = {
    "Name" = "tf-ec2-instance"
  }

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

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/bash_ansible.sh",
      "chmod +x /home/ubuntu/bash_docker.sh",
      "sudo /home/ubuntu/bash_ansible.sh",
      "sudo /home/ubuntu/bash_docker.sh",
      "ansible-playbook /home/ubuntu/playbook-docker.yaml"
    ]
  }

  connection {
    user        = var.user
    private_key = file("~/.ssh/tf-sample-key")
    host        = self.public_ip
  }

}