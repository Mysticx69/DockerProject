output "EC2_PrivateIP" {

  value = [aws_instance.EC2.*.private_ip]

}

output "EC2_name" {

  value = [aws_instance.EC2.*.tags]

}

