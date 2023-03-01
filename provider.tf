provider "xenorchestra" {
  # Must be ws or wss
  url      = var.url                   # "ws://den-xoa-001.amperecomputing.com " 
  username = var.username              # Or set XOA_USER environment variable
  password = var.password              # Or set XOA_PASSWORD environment variable
  
  # This is false by default and
  # will disable ssl verification if true.
  # This is useful if your deployment uses
  # a self signed certificate but should be
  # used sparingly!
  # insecure = <false|true>              # Or set XOA_INSECURE environment variable to any value
  #insecure = false              # Or set XOA_INSECURE environment variable to any value
}