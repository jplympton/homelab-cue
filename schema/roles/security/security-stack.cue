package security

#RoleSecurityStack: {
	name: "security-stack"

	security_principal?: string | *"security-stack"

	services?: {
		docker_compose?: null
		systemd_units?: []
		...
	}

	app?: {
		security_stack: {
			enabled?:       true
			vault_enabled?: true
			pki_enabled?:   true
			...
		}
		...
	}

	monitoring?: {
		exporters?: []
		...
	}

	vault?: {
		templates?: []
		token_sink?: string
		...
	}

	...
}

#Transform: {
	vm:      _
	context: _
	out:     _
}
