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

#################################################
# IAM Role
#################################################

resource "aws_iam_role" "ssm_role" {

  name = "ec2-ssm-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

}

#################################################
# SSM Policy
#################################################

resource "aws_iam_role_policy_attachment" "ssm_policy" {

  role = aws_iam_role.ssm_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"

}

#################################################
# Instance Profile
#################################################

resource "aws_iam_instance_profile" "ssm_profile" {

  name = "ec2-ssm-profile"

  role = aws_iam_role.ssm_role.name

}

#################################################
# Security Group
#################################################

resource "aws_security_group" "private_sg" {

  name = "private-sg"

  vpc_id = var.vpc_id

  egress {

    from_port   = 0

    to_port     = 0

    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

}

#################################################
# Ubuntu EC2
#################################################

resource "aws_instance" "ubuntu" {

  ami = data.aws_ami.ubuntu.id

  instance_type = "t3.micro"

  subnet_id = var.subnet_id

  associate_public_ip_address = false

  vpc_security_group_ids = [

    aws_security_group.private_sg.id

  ]

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  tags = {

    Name = "private-ubuntu"

  }

}
