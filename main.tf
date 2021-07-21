# main.tf
# Configure the DigitalOcean Provider

terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
    # token   = var.do_token # This is the DO API token.
  # Alternatively, this can also be specified using environment variables ordered by precedence:
  #   DIGITALOCEAN_TOKEN, 
  #   DIGITALOCEAN_ACCESS_TOKEN
}


resource "digitalocean_kubernetes_cluster" "kubernetes_cluster" {
  name    = "clo-tf-cass-cluster"
  region  = "lon1"
  version = "1.20.8-do.0"

  tags = ["cassandra-cluster"]

  # This default node pool is mandatory
  node_pool {
    name       = "default-pool"
    size       = "s-2vcpu-4gb" # minimum size, list available options with `doctl compute size list`
    auto_scale = false
    node_count = 4
    tags       = ["node-pool-tag"]
    labels = {
      "cassandra" = "up"
    }
  }

}
