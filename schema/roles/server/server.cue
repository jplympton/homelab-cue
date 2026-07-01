package server

#RoleServer: {
	name: "server"

	// NEW: pure intent — which SSH principal this role prefers.
	// VMs may override; transforms resolve secrets.
	ssh_principal?: string | *"homelab-admin"

	extra_disks?: []
	// If disks gain new fields later (type, storage, cache mode, etc.)
	// this role will not break.
	...

	vault?: {
		templates?: []
		token_sink?: _
		...
	}

	services?: {
		docker_compose?: []
		systemd_units?: []
		...
	}

	monitoring?: {
		exporters?: []
		...
	}

	app?: {
		...
	}

	...
}

#Transform: {
	vm:      _
	context: _
	out:     _
}
