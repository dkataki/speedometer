provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

resource "aws_instance" "web" {
  #ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (Region-specific)
  ami           = "ami-00a256cd2df0bd906" # Amazon Linux 2 AMI (Region-specific)
  
instance_type = "t2.micro"

  tags = {
    Name = "SpeedTestEC2"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y python3",
      "sudo yum install -y git",
      "git clone https://github.com/dkataki/spd.git",
      "cd spd && python3 app.py"
    ]

    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = file("~/.ssh/dk-tf-ec2.pem")
      host     = self.public_ip
    }
  }
}