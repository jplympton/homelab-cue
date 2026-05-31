package role

import (
	diskSchema "homelab.local/homelab-cue/schema/disk"
	nicSchema  "homelab.local/homelab-cue/schema/nic"
)

#Role: {
    env: _

    name?: string

    // Roles can request extra infrastructure, using shared base types
    extra_disks?: [...(diskSchema.#Disk & { env: env })]
    extra_nics?:  [...(nicSchema.#NIC  & { env: env })]

    vault?: {
        templates?:  [...string]
        token_sink?: string
        ...
    }

    services?: {
        docker_compose?: [...string]
        systemd_units?:  [...string]
        ...
    }

    monitoring?: {
        exporters?: [...string]
        ...
    }

    app?: {
        ...
    }

    ...
}