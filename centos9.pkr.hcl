packer {
  required_plugins {
    vmware = {
      source  = "github.com/hashicorp/vmware"
      version = "~> 1"
    }
  }
}

variable "version" {
  type    = string
  default = ""
}

source "vmware-iso" "centos" {
  boot_command     = ["<wait><up><wait><tab> inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg<enter><wait>"]
  boot_wait        = "20s"
  cpus             = 2
  disk_size        = 20480
  guest_os_type    = "centos-64"
  headless         = true
  http_directory   = "http"
  iso_checksum     = "sha256:2da010d21c9047a4c8b90ab6f98ca08fd43ef41f1373beb329362e474c5cf150"
  iso_urls         = ["https://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-20231204.0-x86_64-boot.iso"]
  memory           = 2048
  shutdown_command = "echo '12345678'|sudo -S shutdown now"
  ssh_password     = "12345678"
  ssh_port         = 22
  ssh_username     = "user"
  ssh_wait_timeout = "10000s"
  vm_name          = "packer-centos-9-64"
}

build {
  sources = ["source.vmware-iso.centos"]

}
