resource "aws_key_pair" "mykey" {
  key_name   = "${var.key_name}"
  public_key = "${file("${var.key_name}.pub")}"
}

data "template_file" "cloudconfig" {
  template = "${file("cloud-config.tpl")}"
}

data "template_cloudinit_config" "hello_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.cloudconfig.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${file("script.sh")}"
  }
}

resource "aws_instance" "hello" {
  instance_type = "${var.instance_size}"
  user_data     = "${data.template_cloudinit_config.hello_config.rendered}"
  ami           = "${data.aws_ami.ubuntu.id}"

  # The name of our SSH keypair
  key_name = "${aws_key_pair.mykey.key_name}"

  # Our Security group to allow HTTP and SSH access
  vpc_security_group_ids = ["${aws_security_group.hello_sg.id}"]
  subnet_id              = "${aws_subnet.main_subnet.id}"

  associate_public_ip_address = true

  tags = {
    Name = "hello_flask"
  }
}
