# Hello_Flask
This project is a way to run on [AWS](https://aws.amazon.com/) a minimal Python [Flask](http://flask.pocoo.org/docs/0.12/quickstart/) application which displays the classical `"Hello World!"` in a browser. Its architecture is based on a  EC2 instance which is created with [terraform](https://terraform.io).

### Requirements

To run this project, you need:
- a AWS account (you can use a [free tier](https://aws.amazon.com/free/) account)
- [terraform](https://www.terraform.io/downloads.html) installed on your machine

### Process

#### Get the project

```
$ git clone https://github.com/domrod/terraform-examples
$ cd terraform-examples/hello_flask
```

#### Setup your environment (one time) 

Setup the project with your AWS account. To do so use the file the provided template `terraform.tfvars.example`.

```
$ cp terraform.tfvars.example terraform.tfvars
```

and edit `terraform.tfvars` to use your own AWS credentials and your AWS preferred region (I use `eu-west-3` by default which is Paris).

Create a local SSH key pair.

```
$ ssh-keygen -t rsa -b 4096 -C "My Hello Flask key" -f hello_id_rsa
```

#### Init terraform (one time)

The following commant will download the necessary terraform plugins to run the project on AWS.

```
$ terraform init
```

#### Plan terraform to check
To verify that your project has a correct terraform syntax, type the following command each time you modify it.

```
$ terraform plan
```

#### If everything seems good, apply terraform

When you are ready to go, apply your changes to run the project on AWS.

```
$ terraform apply
```