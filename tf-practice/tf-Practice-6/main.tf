resource "aws_key_pair" "samplekey" {
    key_name = "samplekey"
    public_key = file("samplekey.pub")

}

resource "aws_instance" "Sample_instance" {
    ami = var.amis[var.region]
    instance_type = "t2.micro"
    availability_zone = var.az-1
    key_name = aws_key_pair.samplekey.key_name
    vpc_security_group_ids = [ "sg-0d75a788eb003beba" ]
    tags = {
      "name" = "sample_instance-lastone-1"
    }


    provisioner "file" {
        source = "web.sh"
        destination = "/tmp/web.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod u+x /tmp/web.sh",
            "sudo /tmp/web.sh"
        ]
    }

    connection {
        user = var.user
        private_key = file("samplekey")
        host = self.public_ip
    }

}