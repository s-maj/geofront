module "geofront-eu-west-1" {
  source = "./vpc_module"

  region           = "eu-west-1"
  name             = "geofront"
  cidr_block       = "10.0.0.0/21"
  public_cidr_list = [ "10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24" ]
}
