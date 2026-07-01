package vms

import (
	vm "homelab.local/homelab-cue/schema/vm"
	env "homelab.local/homelab-cue/env/lab"

	server "homelab.local/homelab-cue/schema/roles/server"
	gitlab "homelab.local/homelab-cue/schema/roles/gitlab"
	runner "homelab.local/homelab-cue/schema/roles/gitlab"
	vault "homelab.local/homelab-cue/schema/roles/vault"
)

vm_gitlab: vm.#VM(env) & {
	name:        "vm-gitlab"
	description: "GitLab server"

	roles: [
		server.#RoleServer,
		gitlab.#RoleGitLab,
		runner.#RoleGitLabRunner,
		vault.#RoleVaultClient,
	]

	node: env.vm_defaults.node

	resources: {
		cpu:    8
		memory: 16384
	}

	disks: [
		{
			name: "root"
			size: "80G"
			...
		},
		{
			name: "data"
			size: "200G"
			...
		},
	]

	nics: [
		{
			bridge:   "vmbr0"
			vlan:     env.vm_defaults.vlan
			sdn_zone: env.vm_defaults.sdn_zone
			ip:       "auto"
			...
		},
	]

	os: {
		image:    "tpl-uefi-deb13"
		ssh_user: "jim"

		// intent-only principal (no secrets here), inherited from role, can be overridden.
		ssh_principal: server.ssh_principal
		...
	}

	vault: {
		approle: "auto"
		...
	}

	...
}
