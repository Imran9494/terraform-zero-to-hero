output "public_ip" {
    description = "value of the public IP address of the sample instance"
    value = aws_instance.example_instance.public_ip
}