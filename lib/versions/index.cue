package versions

// -----------------------------------------------------------------------------
// Schema Version (tracks IR evolution)
// -----------------------------------------------------------------------------
schema: {
	version: "v35"
}

// -----------------------------------------------------------------------------
// Docker & Compose
// -----------------------------------------------------------------------------
docker: {
	engine:         "29.1.5"
	compose_schema: "3.9"
}

// -----------------------------------------------------------------------------
// Terraform Providers
// -----------------------------------------------------------------------------
terraform: {
	core: "1.14.3"

	// Provider source names for required_providers blocks
	required_providers: {
		proxmox:   "bpg/proxmox"
		netbox:    "e-breuninger/netbox"
		pfsense:   "elacy/pfsense"
		ansible:   "ansible/ansible"
		vault:     "hashicorp/vault"
		random:    "hashicorp/random"
		local:     "hashicorp/local"
		null:      "hashicorp/null"
		infisical: "infisical/infisical"
		cue:       "poseidon/cue"
	}

	// Provider version pins
	providers: {
		proxmox: {
			source:  terraform.required_providers.proxmox
			version: "0.93.0"
		}
		netbox: {
			source:  terraform.required_providers.netbox
			version: "5.1.0"
		}
		pfsense: {
			source:  terraform.required_providers.pfsense
			version: "0.0.6"
		}
		ansible: {
			source:  terraform.required_providers.ansible
			version: "1.3.0"
		}
		vault: {
			source:  terraform.required_providers.vault
			version: "3.23.0"
		}
		random: {
			source:  terraform.required_providers.random
			version: "5.6.0"
		}
		local: {
			source:  terraform.required_providers.local
			version: "2.6.1"
		}
		null: {
			source:  terraform.required_providers.null
			version: "3.2.4"
		}
		infisical: {
			source:  terraform.required_providers.infisical
			version: "0.15.60"
		}
		cue: {
			source:  terraform.required_providers.cue
			version: "0.4.1"
		}
	}
}

// -----------------------------------------------------------------------------
// Containers
// -----------------------------------------------------------------------------
containers: {
	postgres: {
		image: "postgres"
		tag:   "18.1"
	}
	redis: {
		image: "redis"
		tag:   "8.4"
	}
	vault: {
		image: "hashicorp/vault"
		tag:   "1.21"
	}
	infisical: {
		image: "infisical/infisical"
		tag:   "0.156.3"
	}
}

// -----------------------------------------------------------------------------
// Ansible
// -----------------------------------------------------------------------------
ansible: {
	core: "2.20.1"
	collections: {
		community_general: "12.3.0"
		ansible_posix:     "2.1.0"
	}
}

// -----------------------------------------------------------------------------
// Vault Agent
// -----------------------------------------------------------------------------
vault_agent: {
	version: "1.21"
}

// -----------------------------------------------------------------------------
// Cloud-Init
// -----------------------------------------------------------------------------
cloud_init: {
	version: "25.3"
}

// -----------------------------------------------------------------------------
// NetBox
// -----------------------------------------------------------------------------
netbox: {
	version: "4.5.1"
}

// -----------------------------------------------------------------------------
// CUE
// -----------------------------------------------------------------------------
cue: {
	version: "0.16.1"
}
