

resource "aws_default_vpc" "sprints" {}

resource "aws_iam_role" "role" {
  name               = "ecr-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}



resource "aws_iam_policy" "policy" {
  name = "ecr-access-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}



resource "aws_iam_instance_profile" "ecr-p" {
  name = "ecr-profile"
  role = aws_iam_role.role.name
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



resource "aws_instance" "server" {
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = module.network.public_subnet_id_1
  instance_type               = "t3.xlarge"
  iam_instance_profile        = aws_iam_instance_profile.ecr-p.name
  associate_public_ip_address = true
  security_groups             = [aws_security_group.server.id]
  key_name                    = local.key_name
  

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install python3 -y", "echo Done"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = aws_instance.server.public_ip
    }
  }
  provisioner "local-exec" {
    command = " ANSIBLE_HOST_KEY_CHECKING=False  ansible-playbook  -i ${aws_instance.server.public_ip}, --private-key ${local.private_key_path} jenkins-install.yml"
  }
}

# resource "aws_eip" "demo-eip" {
#   vpc = true
# }


# resource "aws_eip_association" "eip_assoc" {
#   instance_id   = aws_instance.server.id
#   allocation_id = aws_eip.demo-eip.id
# }


# resource "aws_ebs_volume" "example" {
#   availability_zone = "us-west-2b"
#   size              = 20

#   tags = {
#     Name = "HelloWorld"
#   }
# }



# resource "aws_volume_attachment" "ebs_att" {
#   device_name = "/dev/sd1"
#   volume_id   = aws_ebs_volume.example.id
#   instance_id = aws_instance.server.id
# }


