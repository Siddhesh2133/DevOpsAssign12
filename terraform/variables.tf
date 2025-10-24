variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "student_roll_no" {
  description = "Student roll number for tagging"
  type        = string
  default     = "ITA764"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "my_ip" {
  description = "Your IP address for SSH access (CIDR format)"
  type        = string
  default     = "0.0.0.0/0"  # Change this to your IP for security
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "devops-assignment-key"
}
