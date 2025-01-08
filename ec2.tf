#provider "aws" {
#region = var.region
#}

resource "aws_security_group" "demosg" {
vpc_id="${aws_vpc.demovpc.id}"

ingress{
from_port=80
to_port=80
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=3306
to_port=3306
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=22
to_port=22
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

ingress{
from_port=8080
to_port=8080
protocol="tcp"
cidr_blocks=["0.0.0.0/0"]
}

egress{
from_port=0
to_port=0
protocol="-1"
cidr_blocks=["0.0.0.0/0"]
}
tags={
Name="WEB SG"
}
}

resource "aws_instance" "public_subnet-1" {
#vpc_id="${aws_vpc.demovpc.id}"
ami="ami-06744fbd0847bf4f5"
instance_type="t2.micro"
count=1
key_name="balaji"
vpc_security_group_ids = [aws_security_group.demosg.id]
subnet_id             = aws_subnet.public_subnet-1.id
user_data="${file("userdata.sh")}"
tags={
Name="POLL SCM 2"
}
}
