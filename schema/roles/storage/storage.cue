package storage

#RoleStorage: {
	name: "storage"

	storage_principal?: string | *"storage"

	extra_disks?: []
	...

	app?: {
		storage: {
			backend?: "ceph" | "nfs" | "s3" | string

			ceph?: {
				cluster_name?: "ceph"
				mon_hosts?: [...string]
				...
			}

			nfs?: {
				exports?: [...string]
				...
			}

			s3?: {
				endpoint?: string
				bucket?:   string
				...
			}
		}
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

	...
}
