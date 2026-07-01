package sdn

#SDN: {
	// Optional because overrides may delete or replace entire SDN sections
	zones?: {[string]: #SDNZone}
	vxlan_overlays?: {[string]: #VXLANOverlay}

	...
}

#SDNZone: {
	// All fields optional — overrides may delete or replace them
	description?: string
	backend?:     string
	bridge?:      string

	// Optional list type
	nodes?: [...string]

	...
}

#VXLANOverlay: {
	// All fields optional — overrides may delete or replace them
	vni?:         uint
	zone?:        string
	bridge?:      string
	description?: string

	...
}
