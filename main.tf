# Instruct terraform to download the provider on `terraform init`
terraform {
  required_providers {
    xenorchestra = {
      source = "terra-farm/xenorchestra"
      version = "~> 0.9"
    }
  }
  required_version = "1.2.0"
 }

# Content of the terraform files
data "xenorchestra_pool" "pool" {
    name_label = "IT"
}

data "xenorchestra_template" "template" {
  name_label = "01-prod-template-xfce-gnome-kde-cloud-ready" ### define template with cloud_init packages from XOA server
}

data "xenorchestra_network" "network" {
  name_label = "Login"
  pool_id = data.xenorchestra_pool.pool.id
}

variable "num_vms" {
  type        = number
  description = "The number of VMs to create."
  default     = 2                     ### define number of vm to deploy to XOA server
}
resource "xenorchestra_cloud_config" "bar" {
    count    = var.num_vms
    name     = "hcm-login-10${count.index + 1}"
    template = templatefile("cloud_config.tftpl",{
       hostname = "hcm-login-10${count.index + 1}"
  })
}
resource "xenorchestra_vm" "vm" {
    count    = var.num_vms
    memory_max = 4073733632           ### define number of memory for VM to deploy to XOA server
    cpus  = 2                         ### define number of CPU for VM to deploy to XOA server    
    cloud_config = xenorchestra_cloud_config.bar[count.index].template    
    name_label = "hcm-login-10${count.index + 1}"
    name_description = "HCM Login server test "
    template = data.xenorchestra_template.template.id
    network {
        network_id = data.xenorchestra_network.network.id
    }

    disk {
      sr_id = "883ce5c3-117c-c37d-4c73-c4f863098c29"      ### define storage ID for VM to deploy to XOA server
      name_label = "hcm-login-10${count.index + 1}"       ### define disk label for VM to deploy to XOA server
      size = 32212254720                                  ### define storage size VM to deploy to XOA server
    }
    
#    tags = [
#      "Ubuntu",
#      "Bionic",
#    ]

    // Override the default create timeout from 5 mins to 20.
    timeouts {
      create = "20m"
    }
}
