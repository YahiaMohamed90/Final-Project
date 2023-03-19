resource "aws_ecr_repository" "demo-ecr" {
  name                 = "myecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  provisioner "local-exec" {
    command = "echo ${self.repository_url} >> /home/yahia/url.txt"
  }


}





