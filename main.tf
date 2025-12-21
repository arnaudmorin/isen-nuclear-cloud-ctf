terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.0.0"
    }
  }
}

provider "openstack" {

}

resource "openstack_networking_floatingip_v2" "fip" {
  count = 4
  pool = "Ext-Net"
  tags = ["floating-ip-for-isen-group-${count.index+1}"]
}

output "floating-ips" {
  value = merge(
    { for idx, fip in openstack_networking_floatingip_v2.fip : join(", ", fip.tags) => "${fip.address}" },
  )
  description = "Proxy Servers used to manipulate nuclear assets"
}

output "flag" {
  value = "ISEN-#4-{TFStateAreSecrets}"
  description = "Flag"
}
