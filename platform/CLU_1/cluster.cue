package CLU_1

import (
	platformSchema "homelab.local/homelab-cue/schema/platform"
)

// Concrete platform instance for cluster "CLU-1"
data: platformSchema.#Platform & {
	endpoint: "https://pve1:8006/api2/json"
	insecure: false

	// auth is intentionally left as a plain string; secrets layer will inject
	auth: string

	vlans: {
		[10]: {
			id:          10
			name:        "mgmt"
			description: "Proxmox management, Ceph management, admin-only services"
			zone:        "core"
			tagged:      false
		}
		[20]: {
			id:          20
			name:        "lan"
			description: "General LAN, production workloads, internal services"
			zone:        "core"
			tagged:      false
		}
		[30]: {
			id:          30
			name:        "dmz"
			description: "Reverse proxies, ingress, WAN-adjacent services"
			zone:        "dmz"
			tagged:      true
		}
		[40]: {
			id:          40
			name:        "storage"
			description: "Storage backend or isolated IoT network"
			zone:        "core"
			tagged:      true
		}
		[50]: {
			id:          50
			name:        "ceph"
			description: "Ceph replication, heartbeat, cluster traffic"
			zone:        "core"
			tagged:      true
		}
	}

	nodes: {
		pve0: {
			nics: {
				eno1: {
					name: "eno1"
					mac:  "aa:bb:cc:dd:ee:01"
					mtu:  1500
				}
			}

			bridges: {
				vmbr0: {
					description: "Primary LAN bridge"
					mtu:         1500
					vlan_ids: [10, 20, 30, 40, 50]
					sdn_zones: ["core"]
					nics: ["eno1"]
				}
			}

			iscsi: {
				via_bridge: "vmbr0"
				vlan:       20
				multipath_targets: []
			}

			ceph_interfaces: ["eno1"]
			migration_interface: null
		}

		pve1: {
			nics: {
				eno1: {
					name: "eno1"
					mac:  "aa:bb:cc:dd:ee:02"
					mtu:  1500
				}
			}

			bridges: {
				vmbr0: {
					description: "Primary LAN bridge"
					mtu:         1500
					vlan_ids: [10, 20, 30, 40, 50]
					sdn_zones: ["core"]
					nics: ["eno1"]
				}
			}

			iscsi: {
				via_bridge: "vmbr0"
				vlan:       20
				multipath_targets: []
			}

			ceph_interfaces: ["eno1"]
			migration_interface: null
		}
	}

	sdn: {
		zones: {
			core: {
				description: "Core zone"
				backend:     "simple"
				bridge:      "vmbr0"
				nodes: ["pve0", "pve1"]
			}

			dev: {
				description: "Development zone"
				backend:     "simple"
				bridge:      "vmbr0"
				nodes: ["pve0"]
			}

			k8s: {
				description: "Kubernetes zone"
				backend:     "simple"
				bridge:      "vmbr0"
				nodes: ["pve1"]
			}
		}

		vxlan_overlays: {}
	}

	storage: {
		"local-lvm": {
			type: "lvm-thin"
			content: ["images", "rootdir"]
			nodes: ["pve0", "pve1"]

			lvm_thin: {
				thinpool: "data"
				vg:       "pve"
			}
		}

		"ceph-vms": {}
	}
}
