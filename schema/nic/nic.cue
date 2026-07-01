package nic

// #NIC defines the canonical structure for virtual network interfaces.
#NIC: {
	env: _

	name:   string
	model:  "virtio" | "e1000" | "rtl8139"
	bridge: string
	vlan:   int & >=0 & <=4094

	...
}
