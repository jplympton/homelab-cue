package vm

import (
    diskSchema  "homelab.local/homelab-cue/schema/disk"
    nicSchema   "homelab.local/homelab-cue/schema/nic"
    roleSchema  "homelab.local/homelab-cue/schema/role"
)

#VM: {
    // injected environment
    env: _

    name?:        =~"^[a-zA-Z0-9._-]+$"
    description?: string

    node?: *env.vm_defaults.node | string

    resources?: {
        cpu?:    int & >0
        memory?: int & >0
        ...
    }

    disks?: [...(diskSchema.#Disk & { env: env })]
    nics?:  [...(nicSchema.#NIC  & { env: env })]

    network?: {
        bridge?:   string
        vlan?:     uint | "auto"
        sdn_zone?: string | "auto"
        ip?:       string | "auto" | "dhcp"
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

    roles?: [...(roleSchema.#Role & { env: env })]

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
        approle?:    string | "auto"
        templates?:  [...string]
        token_sink?: string
        ...
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

    ...
}