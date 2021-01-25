terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.49.0"
    }
  }
}


resource "yandex_compute_instance" "vm-nginx" {
    name = "terraform-nginx"

    resources {
        cores = 2
        memory = 1
        core_fraction = 5
    }

    boot_disk {
        initialize_params {
            image_id = "fd87nk366cvaff2mblbr"
        }
    }

    network_interface {
        subnet_id = "e9bvb5fjigb8cm692ji4"
        nat       = true
    }

    metadata = {
        ssh-keys = "hw2:${file("~/.ssh/id_rsa_home.pub")}"
    }
}

resource "yandex_compute_instance" "vm-web1" {
    name = "terraform-web1"

    resources {
        cores = 2
        memory = 1
        core_fraction = 5
    }

    boot_disk {
        initialize_params {
            image_id = "fd87nk366cvaff2mblbr"
        }
    }

    network_interface {
        subnet_id = "e9bvb5fjigb8cm692ji4"
        nat       = false
    }

    metadata = {
        ssh-keys = "hw2:${file("~/.ssh/id_rsa_home.pub")}"
    }
}

resource "yandex_compute_instance" "vm-web2" {
    name = "terraform-web2"

    resources {
        cores = 2
        memory = 1
        core_fraction = 5
    }

    boot_disk {
        initialize_params {
            image_id = "fd87nk366cvaff2mblbr"
        }
    }

    network_interface {
        subnet_id = "e9bvb5fjigb8cm692ji4"
        nat       = false
    }

    metadata = {
        ssh-keys = "hw2:${file("~/.ssh/id_rsa_home.pub")}"
    }
}

resource "yandex_compute_instance" "vm-postgres" {
    name = "terraform-postgres"

    resources {
        cores = 2
        memory = 1
        core_fraction = 5
    }

    boot_disk {
        initialize_params {
            image_id = "fd80lqp9cp96q4nfae51"
        }
    }

    network_interface {
        subnet_id = "e9bvb5fjigb8cm692ji4"
        nat       = false
    }

    metadata = {
        ssh-keys = "hw2:${file("~/.ssh/id_rsa_home.pub")}"
    }
}

output "internal_ip_web1" {
    value = yandex_compute_instance.vm-web1.network_interface.ip_address
}

output "external_ip_web1" {
    value = yandex_compute_instance.vm-web1.network_interface.nat_ip_address
}

output "internal_ip_web2" {
    value = yandex_compute_instance.vm-web2.network_interface.ip_address
}

output "external_ip_web2" {
    value = yandex_compute_instance.vm-web2.network_interface.nat_ip_address
}

output "internal_ip_postgres" {
    value = yandex_compute_instance.vm-postgres.network_interface.ip_address
}

output "external_ip_postgres" {
    value = yandex_compute_instance.vm-postgres.network_interface.nat_ip_address
}

output "internal_ip_nginx" {
    value = yandex_compute_instance.vm-nginx.network_interface.ip_address
}

output "external_ip_nginx" {
    value = yandex_compute_instance.vm-nginx.network_interface.nat_ip_address
}