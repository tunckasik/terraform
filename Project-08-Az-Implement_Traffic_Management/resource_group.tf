module "rg1" {
  source  = "./modules/rg"
  rg_name = "az104-06-rg1"
}

module "rg4" {
  source  = "./modules/rg"
  rg_name = "az104-06-rg4"
}

module "rg5" {
  source  = "./modules/rg"
  rg_name = "az104-06-rg5"
}