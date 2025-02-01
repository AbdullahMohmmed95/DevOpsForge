terraform {
  required_providers {
    contabo = {
      source  = "ContaboOfficial/contabo"
      version = "0.3.1"  # Use the latest stable version
    }
  }
}

provider "contabo" {
  client_id     = "INT-13363627"
  client_secret = "BnImuy7EEPGEw3pcBUC9rnKBi2FeX5k1"
}

resource "contabo_instance" "app_server" {
  image_id      = "ubuntu-20.04"  # Replace with actual image ID
  instance_type = "G-2000"

  tags = {
    Name = "AppServer"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}

output "instance_ip" {
  value = contabo_instance.app_server.public_ip
}