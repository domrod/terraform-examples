output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "hello_flask_ip" {
  value = "${aws_instance.hello.public_ip}"
}
