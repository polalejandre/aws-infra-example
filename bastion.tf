data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # Canonical
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_iam_policy_document" "ssm_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ssm" {
  name               = "bastion_role"
  assume_role_policy = data.aws_iam_policy_document.ssm_assume_role_policy.json
}

resource "aws_iam_instance_profile" "ssm" {
  name = "bastion_role"
  role = aws_iam_role.ssm.name
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "ssm_patch" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
}


resource "aws_instance" "bastion" {
  ami = data.aws_ami.ubuntu.id

  vpc_security_group_ids      = [aws_security_group.bastion.id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true

  iam_instance_profile = aws_iam_instance_profile.ssm.name

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo snap install amazon-ssm-agent --classic
    sudo snap switch --channel=candidate amazon-ssm-agent
    sudo snap start amazon-ssm-agent
    sudo snap services amazon-ssm-agent
    EOF

  tags = {
    Name      = "Bastion"
    Terraform = "True"
  }

  lifecycle {
    ignore_changes = [ami]
  }

  instance_type = var.bastion_instance_type
}

resource "aws_security_group" "bastion" {
  name   = "bastion"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
