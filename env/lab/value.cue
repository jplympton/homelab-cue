package lab

import environment "homelab.local/homelab-cue/schema/environment"

// Export the environment directly at the package root
env: environment.#Environment & {

	env: "lab"

	vm_defaults: {
		node:     "pve0"
		vlan:     20
		sdn_zone: "dev"
		storage:  "local-lvm"
	}

	vault: {
		address: "http://vault.lab.local:8200"
	}

	infisical: {
		address:     "http://infisical.lab.local"
		environment: "lab"
		project:     "homelab"
	}

	platform_overrides: {
		nodes: {
			pve0: {
				bridges: {
					vmbr0: {
						vlan_ids: [20]
					}
				}
			}
		}

		sdn: {
			zones: {
				dev: {
					nodes: ["pve0"]
				}
			}
		}

		storage: {
			"local-lvm": {
				lvm_thin: {
					thinpool: "data-lab"
				}
			}
		}
	}
}
