package vm

import (
	diskSchema "homelab.local/homelab-cue/schema/disk"
	nicSchema "homelab.local/homelab-cue/schema/nic"
	roleSchema "homelab.local/homelab-cue/schema/role"
)

#VM: {
	// injected environment
	env: _

	name:         =~"^[a-z0-9-]{1,63}$"
	description?: string

	node?: *env.vm_defaults.node | string

	resources: {
		cpu:    int & >0
		memory: int & >=512
		...
	}

	disks: [diskSchema.#Disk & {env: env}, ...(diskSchema.#Disk & {env: env})]
	nics: [nicSchema.#NIC & {env: env}, ...(nicSchema.#NIC & {env: env})]

	network: {
		bridge?:  string
		vlan?:    uint | "auto"
		sdn_zone: *"auto" | "trusted" | "dmz" | "infra"
		ip?:      string | "auto" | "dhcp"
		...
	}

	os?: {
		image?:    string
		ssh_user?: string

		ssh_principal?: string | *ssh_user
		ssh_authorized_keys?: [...string]

		cloud_init?: {
			user_data?:    string
			network_data?: string
			write_files?: [...{
				path?:        string
				permissions?: string
				content?:     string
				...
			}]
			...
		}
		...
	}

	roles?: [...(roleSchema.#Role & {env: env})]

	services?: {
		docker_compose?: {
			path?:    string
			content?: string
			...
		}

		systemd_units?: [...{
			name?:    string
			content?: string
			...
		}]
		...
	}

	vault?: {
		approle: *"auto" | string
		templates?: [...string]
		token_sink?: string
		...

		// Cross-field constraint: templates require a non-empty approle
		if templates != _|_ if len(templates) > 0 {
			approle: !=""
		}
	}

	bootstrap?: {
		scripts?: [...string]
		...
	}

	talos?: {
		machine_config?: string
		role?:           "controlplane" | "worker"
		cluster?:        string
		...
	}

	platform?: {
		endpoint?: string
		insecure?: bool

		node?:     string
		storage?:  string
		bridge?:   string
		vlan?:     uint
		sdn_zone?: string
		...
	}

	// Cross-field constraint: docker-compose usage implies systemd integration
	if services.docker_compose != _|_ {
		services: systemd_units: [_, ...] // Ensure at least one unit (likely the compose service)
	}

	...
}
