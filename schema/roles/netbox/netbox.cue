package netbox

#Role: {
	name: "netbox"

	// ----------------------------------------------------
	// Storage
	// ----------------------------------------------------
	// NetBox needs only application storage (media/static).
	// Database and Redis are external on vm-db.
	extra_disks: [
		{
			name:    "media"
			size:    "10Gi"
			type:    "scsi"
			storage: *env.vm_defaults.storage
		},
	]

	// ----------------------------------------------------
	// Networking
	// ----------------------------------------------------
	// NetBox must reach vm-db for Postgres + Redis.
	// No extra NICs unless overlays add them.
	extra_nics: []

	network: {
		requires: [
			"vm-db.postgres",
			"vm-db.redis",
		]
	}

	// ----------------------------------------------------
	// Vault Integration
	// ----------------------------------------------------
	// Vault templates provide:
	// - Django SECRET_KEY
	// - Postgres credentials
	// - Redis credentials
	// - Superuser bootstrap
	vault: {
		templates: [
			"netbox.env",
			"netbox.superuser",
			"postgres.netbox",
			"redis.netbox",
		]
		token_sink: "netbox"
	}

	// ----------------------------------------------------
	// Services
	// ----------------------------------------------------
	// NetBox runs as a Docker Compose application.
	// No local Postgres or Redis services.
	services: {
		docker_compose: [
			"netbox/docker-compose.yml",
		]

		systemd_units: [
			"netbox.service",
			"netbox-worker.service",
			"netbox-scheduler.service",
		]
	}

	// ----------------------------------------------------
	// Monitoring
	// ----------------------------------------------------
	monitoring: {
		exporters: [
			"node_exporter",
			"netbox_exporter",
		]
	}

	// ----------------------------------------------------
	// Application Block
	// ----------------------------------------------------
	app: {
		type: "netbox"

		config: {
			superuser: {
				username: "admin"
				email:    "admin@example.com"
			}

			// Filled by Vault templates
			secrets: {
				django_secret_key: string
				postgres: {
					host:     string
					port:     int
					user:     string
					password: string
					database: string
				}
				redis: {
					host:     string
					port:     int
					password: string
				}
				superuser_password: string
			}

			plugins: [...string]
		}
	}
}
