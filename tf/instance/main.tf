data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210223"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "user_data" {
  template = file("${path.module}/../../user_data_template.sh")
  vars = {
    listen_port = var.listen_port
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.nano"
  subnet_id              = var.public_subnet_id
  user_data              = data.template_file.user_data.rendered
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [ aws_security_group.ec2-sg.id ]

  tags = {
    Name        = "${var.sysname}-ec2"
    Environment = var.environment
  }
}

# see https://stackoverflow.com/questions/46763287/i-want-to-identify-the-public-ip-of-the-terraform-execution-environment-and-add
data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "ec2-sg" {
  name        = "${var.sysname}-sg"
  description = "Allow inbound/outbound from the VPC"
  vpc_id      = var.vpc_id
  # depends_on  = [ aws_vpc.vpc ]

  ingress {
    from_port   = var.listen_port
    to_port     = var.listen_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = "true"
  }

  tags = {
    Name        = "${var.sysname}-sg"
    Environment = var.environment
  }
}