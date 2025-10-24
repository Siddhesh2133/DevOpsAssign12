# Data source for Ubuntu 20.04 AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Generate SSH key pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save private key locally
resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/terraform-key.pem"
  file_permission = "0600"
}

# Save public key locally
resource "local_file" "public_key" {
  content         = tls_private_key.ssh_key.public_key_openssh
  filename        = "${path.module}/terraform-key.pem.pub"
  file_permission = "0644"
}

# AWS Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Security Group
resource "aws_security_group" "devops_sg" {
  name        = "devops-assignment-sg"
  description = "Security group for DevOps assignment"
  vpc_id      = data.aws_vpc.default.id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins
  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  # Django Dev Server
  ingress {
    description = "Django"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # PostgreSQL
  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    self        = true
  }

  # Docker Swarm - Management
  ingress {
    description = "Docker Swarm Management"
    from_port   = 2377
    to_port     = 2377
    protocol    = "tcp"
    self        = true
  }

  # Docker Swarm - Node Communication
  ingress {
    description = "Docker Swarm Communication TCP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "tcp"
    self        = true
  }

  ingress {
    description = "Docker Swarm Communication UDP"
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    self        = true
  }

  # Docker Swarm - Overlay Network
  ingress {
    description = "Docker Overlay Network"
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    self        = true
  }

  # Egress - Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-assignment-sg"
  }
}

# Controller Node (Jenkins/CI)
resource "aws_instance" "controller" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name              = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3 python3-pip
              EOF

  tags = {
    Name = "Controller"
    Role = "controller"
  }
}

# Swarm Manager Node
resource "aws_instance" "swarm_manager" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name              = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3 python3-pip
              EOF

  tags = {
    Name = "Swarm-Manager"
    Role = "manager"
  }
}

# Worker Node A
resource "aws_instance" "worker_a" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name              = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3 python3-pip
              EOF

  tags = {
    Name = "Worker-A"
    Role = "worker"
  }
}

# Worker Node B
resource "aws_instance" "worker_b" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name              = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3 python3-pip
              EOF

  tags = {
    Name = "Worker-B"
    Role = "worker"
  }
}

# Elastic IP for Swarm Manager
resource "aws_eip" "manager_eip" {
  instance = aws_instance.swarm_manager.id
  domain   = "vpc"

  tags = {
    Name = "Manager-EIP"
  }
}

# Elastic IP for Worker A
resource "aws_eip" "worker_a_eip" {
  instance = aws_instance.worker_a.id
  domain   = "vpc"

  tags = {
    Name = "Worker-A-EIP"
  }
}

# Elastic IP for Worker B
resource "aws_eip" "worker_b_eip" {
  instance = aws_instance.worker_b.id
  domain   = "vpc"

  tags = {
    Name = "Worker-B-EIP"
  }
}

# Generate Ansible Inventory
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    controller_ip     = aws_instance.controller.public_ip
    manager_ip       = aws_eip.manager_eip.public_ip
    manager_private_ip = aws_instance.swarm_manager.private_ip
    worker_a_ip      = aws_eip.worker_a_eip.public_ip
    worker_b_ip      = aws_eip.worker_b_eip.public_ip
    ssh_key_path     = "${path.module}/terraform-key.pem"
  })
  filename = "${path.module}/../ansible/inventory/hosts"
}
