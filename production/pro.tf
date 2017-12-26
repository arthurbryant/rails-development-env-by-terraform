provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"

}

resource "aws_instance" "main" {
  ami           = "ami-56d4ad31"
  instance_type = "t2.micro"
  key_name = "key-pair-production"
  vpc_security_group_ids = ["sg-8cd579f5"]
  subnet_id = "subnet-be5cbae7"
  associate_public_ip_address = true
  disable_api_termination = true

  root_block_device {
    volume_type           = "gp2"
    delete_on_termination = true
  }

  count = "${var.count}"
  tags {
    Name = "${format("goal-${var.env}-%03d", count.index + 1)}",
    Stages = "production",
    Project = "goal",
    Roles = "app,db"
  }

  provisioner "file" {
        source = "../bin"
        destination = "~/"
        connection {
            host = "${self.public_ip}"
            type = "ssh"
            user = "ec2-user"
            private_key = "${file(var.ssh_private_key)}"
        }
  }

  provisioner "file" {
        source = "./conf"
        destination = "~/"
        connection {
            host = "${self.public_ip}"
            type = "ssh"
            user = "ec2-user"
            private_key = "${file(var.ssh_private_key)}"
        }
  }

  provisioner "remote-exec" {
        connection {
            host = "${self.public_ip}"
            type = "ssh"
            user = "ec2-user"
            private_key = "${file(var.ssh_private_key)}"
        }
        inline = [
            "cd; sh ./bin/pre-install.sh",
            "cd; sh ./bin/nginx.sh",
            "cd; sh ./bin/${var.env}.sh",
        ]
  }
}
