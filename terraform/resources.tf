provider "aws" {
  access_key = "${var.prod_key}"
  secret_key = "${var.prod_secret}"
  region     = "${var.prod_region}"
}

#Security group
resource "aws_security_group" "sg-bank" {
  name = "sec-bank"
  description = "Security group for Bank application"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["190.157.122.194/32"]
  }
 
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }

}

#EC2 instace for Bank instance
resource "aws_instance" "ec2-bank" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet}"
  security_groups = ["${aws_security_group.sg-bank.id}"]
  key_name = "${var.key}"

  	tags {
	    Name = "bank"
		}  

}

#Route 53 domain 
resource "aws_route53_zone" "main" {
  name = "secasp.co"
}

#Route 53 record for EC2 instance
resource "aws_route53_record" "r53-monkey" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name    = "bank.secasp.co"
  ttl     = "60"
  type    = "A"
  records = ["${aws_instance.ec2-bank.public_ip}"]

}




