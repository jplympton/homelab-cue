package database

#RoleDatabasePostgres: {
	name: "database-postgres"

	// NEW: pure intent — which principal this role uses for DB credentials.
	// This does NOT contain secrets. It is only a lookup key.
	db_principal?: string | *"postgres"

	extra_disks?: [
		{
			name: "pgdata"
			size: "100G"
			// type, storage, etc. will be filled in by VM schema defaults
			...
		},
	]

	vault?: {
		templates?: []
		token_sink?: string
		...
	}

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
		postgres: {
			port?:     5432
			data_dir?: "/var/lib/postgresql/data"
			...
		}
		...
	}

	...
}

#Transform: {
	vm:      _
	context: _
	out:     _
}
