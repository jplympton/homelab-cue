package platform

import (
	nodeSchema "homelab.local/homelab-cue/schema/node"
	sdnSchema "homelab.local/homelab-cue/schema/sdn"
	storageSchema "homelab.local/homelab-cue/schema/storage"
	vlanSchema "homelab.local/homelab-cue/schema/vlan"
)

// Canonical description of a Proxmox cluster platform
#Platform: {
	// Proxmox API endpoint and TLS behavior
	endpoint?: string
	insecure?: bool | *false

	// Authentication token or credentials (injected by secrets/env layer)
	auth?: string

	// VLAN definitions keyed by VLAN ID
	vlans?: [id=uint]: vlanSchema.#VLAN

	// Node definitions keyed by node name (e.g. "pve0", "pve1")
	nodes?: [name=string]: nodeSchema.#Node

	// SDN configuration (zones, overlays, etc.)
	sdn?: sdnSchema.#SDN

	// Storage backends keyed by storage ID (e.g. "local-lvm", "ceph-vms")
	storage?: [name=string]: storageSchema.#Storage

	// Forward‑compatible extension point
}
