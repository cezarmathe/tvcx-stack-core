# consul-bootstrap - backend

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
