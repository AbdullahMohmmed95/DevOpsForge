provider "contabo" {
    username = "root"
    password = "7V$C4ib_%:kP"
}

resource "contabo_instance" "app_server" {
    image_id      = "Ubuntu 20.04" 
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
            user        = "root" # Adjust if necessary
            private_key = file("~/.ssh/id_rsa")
            host        = self.public_ip
        }
    }
}

output "instance_ip" {
    value = contabo_instance.app_server.public_ip
}