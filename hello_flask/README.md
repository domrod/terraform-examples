# Hello_Flask
This project is a way to run on <a href="https://aws.amazon.com/" target="_blank">AWS</a> a minimal Python <a href="http://flask.pocoo.org/docs/0.12/quickstart/" target="_blank">Flask</a> application which displays the classical `"Hello World!"` in a browser. Its architecture is based on a  EC2 instance which is created with <a href="https://terraform.io" target="_blank">terraform</a>.

### Requirements

To run this project, you need:
- a AWS account (you can use a <a href="https://aws.amazon.com/free/" target="_blank">free tier</a> account)
- <a href="https://www.terraform.io/downloads.html" target="_blank">terraform</a> installed on your machine

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

Create a local SSH key pair (don't enter a passphrase).

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

If everything went well, you should have a final output as the following.
```
...
Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

Outputs:

hello_flask_ip = 35.180.73.52
vpc_id = vpc-02b9336b

```

#### Final check

You can check that everything works with a browser or with `curl`. For instance, with the previous provided IP, we get:

```
$ curl http://35.180.73.52
Hello, World!
```  

To implement a test, you can use `terraform output` with the following script
```
$ ./test.sh
 ☑ Ok
```

#### To delete your project

If you are testing and want to stop the project running on AWS, just type the following command.


```
$ terraform destroy --force
```

### Improvements

This project is based on one simple instance. For a *production* environment, it should be better to use a load balancer (<a href="https://aws.amazon.com/elasticloadbalancing/" target="_blank">ELB</a>) with multiple instances and an autoscaler. 

The Nginx proxy pass and the Flask application could also be run on separate instances or containers.