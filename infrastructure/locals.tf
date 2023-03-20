locals {
  vpc_id           = module.network.vpc_id_output
  subnet_id        = module.network.public_subnet_id_1
  ssh_user         = "ubuntu"
  key_name         = "my-key"
  private_key_path = "/home/yahia/.ssh/id_rsa"
  public_key_path  = "/home/yahia/.ssh/id_rsa.pub"
}