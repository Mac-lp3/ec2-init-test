data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20210223"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "user_data" {
  template = "${file("${path.module}/../../user_data_template.sh")}"
  vars = {
    listen_port = var.listen_port
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.nano"
  subnet_id     = var.public_subnet_id
  user_data     = data.template_file.user_data.rendered

  tags = {
    Name        = "${var.sysname}-ec2"
    Environment = var.environment
  }
}