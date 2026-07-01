package vault

#RoleVaultClient: {
	name: "vault-client"

	// NEW: pure intent — which Vault principal this VM uses.
	// This is a lookup key into SECRETS.vault[...] in the transform layer.
	vault_principal?: string | *"vault-client"

	vault?: {...}

	services?: {
		docker_compose?: null
		systemd_units?: []
		...
	}

	monitoring?: {
		exporters?: []
		...
	}

	app?: {
		vault_client: {
			enabled: true
			...
		}
		...
	}

	...
}

#Transform: {
	vm:      _
	context: _

	out: {
		principal: vm.roles.vault.vault_principal
		role_id:   context.SECRETS.vault[principal].role_id
		secret_id: context.SECRETS.vault[principal].secret_id
		token?:    context.SECRETS.vault[principal].token

		templates:  vm.roles.vault.vault.templates
		token_sink: vm.roles.vault.vault.token_sink
	}
}
