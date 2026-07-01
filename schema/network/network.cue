package network

#Bridge: {
	// Optional because overrides may delete or replace fields
	description?: string
	mtu?:         uint

	// Optional list fields — replaced entirely by overrides
	vlan_ids?: [...uint]
	sdn_zones?: [...string]
	nics?: [...string]

	// Allow additional fields for forward compatibility
	...
}
