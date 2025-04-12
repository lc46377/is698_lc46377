resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.private_subnet_id
  associate_public_ip_address = false
  
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Private Web Server - Apache</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
}
