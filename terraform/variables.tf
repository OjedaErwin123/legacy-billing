variable "aws_region" {
  default = "us-east-1"
}

variable "app_port" {
  default = 3000
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  default = "ami-0c02fb55956c7d316"
}

variable "iam_instance_profile" {
  default = "LabInstanceProfile"
}

variable "my_public_ip" {
  description = "Tu IP publica /32 para el evento imprevisto"
  default     = "190.104.20.154/32"
}
