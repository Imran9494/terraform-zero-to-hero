resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "DemoVPC"
  }

}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "DemoSubnet1"
  }

}


resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "DemoSubnet2"
  }

}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id


  tags = {
    Name = "DemoIGW"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "DemoRouteTable"
  }
}

resource "aws_route_table_association" "sub1_association" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "sub2_association" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "DemoSecurityGroup"
  }
}


resource "aws_instance" "demo_instance1" {
  ami             = var.ami_id_value # Replace with a valid AMI ID
  instance_type   = var.instance_type_value
  subnet_id       = aws_subnet.sub1.id
  vpc_security_group_ids       = [aws_security_group.my_sg.id]
  user_data_base64       = base64encode(file("userdata.sh"))

  tags = {
    Name = "DemoInstance1"
  }
}

resource "aws_instance" "demo_instance2" {
  ami             = var.ami_id_value # Replace with a valid AMI ID
  instance_type   = var.instance_type_value
  subnet_id       = aws_subnet.sub2.id
  vpc_security_group_ids       = [aws_security_group.my_sg.id]
  user_data_base64= base64encode(file("userdata1.sh"))

  tags = {
    Name = "DemoInstance2"
  }
}

resource "aws_lb" "mylb" {
  name               = "demo-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sg.id]
  subnets            = [aws_subnet.sub1.id, aws_subnet.sub2.id]

  tags = {
    Name = "DemoLoadBalancer"
  }

}

resource "aws_lb_target_group" "myTG" {
  name     = "demo-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }

  tags = {
    Name = "DemoTargetGroup"
  }
}

resource "aws_lb_target_group_attachment" "TGattach1" {
  target_group_arn = aws_lb_target_group.myTG.arn
  target_id        = aws_instance.demo_instance1.id
  port             = 80

}

resource "aws_lb_target_group_attachment" "TGattach2" {
  target_group_arn = aws_lb_target_group.myTG.arn
  target_id        = aws_instance.demo_instance2.id
  port             = 80

}

resource "aws_lb_listener" "myListener" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myTG.arn
  }

  tags = {
    Name = "DemoListener"
  }
}


