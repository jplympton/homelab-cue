package gitlab

#RoleGitLabRegistry: {
	name: "gitlab-registry"

	registry_principal?: string | *"gitlab-registry"

	app?: {
		registry: {
			enabled?:     true
			port?:        5000
			storage_dir?: "/var/lib/registry"
			...
		}
		...
	}

	services?: {
		docker_compose?: null
		systemd_units?: []
		...
	}

	...
}

#Transform: {
	vm:      _
	context: _
	out:     _
}
