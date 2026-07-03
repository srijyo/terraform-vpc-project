data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {

    name = "name"

    values = [

      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

    ]

  }

}

resource "aws_security_group" "private_sg" {

  name = "private-sg"

  vpc_id = var.vpc_id

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [

      "0.0.0.0/0"

    ]

  }

}

resource "aws_instance" "ubuntu" {

  ami = data.aws_ami.ubuntu.id

  instance_type = "t2.micro"

  subnet_id = var.subnet_id

  associate_public_ip_address = false

  vpc_security_group_ids = [

    aws_security_group.private_sg.id

  ]

  tags = {

    Name = "private-ubuntu"

  }

}





