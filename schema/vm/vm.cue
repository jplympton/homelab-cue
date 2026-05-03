package vm

#VM: {
    // injected environment
    env: _

    name?:        =~"^[a-zA-Z0-9._-]+$"
    name:         string & =~"^[a-z0-9-]{1,63}$"
    description?: string

    node?: *env.vm_defaults.node | string
    node: string | *env.vm_defaults.node

    resources?: {
        cpu?:    int & >0
        memory?: int & >0
    resources: {
        cpu:    int & >0
        memory: int & >=512 // In MB
        ...
    }

    disks?: [...(#Disk & { env: env })]
    nics?:  [...(#NIC  & { env: env })]
    // All VMs must have at least one disk and NIC. 
    // Roles can add more through unification in the orchestrator.
    disks: [...(#Disk & { "env": env })] & [_, ...#Disk]
    nics:  [...(#NIC  & { "env": env })] & [_, ...#NIC]

    network?: {
        bridge?:   string
        vlan?:     uint | "auto"
        sdn_zone?: string | "auto"
        ip?:       string | "auto" | "dhcp"
    network: {
        ip:       "dhcp" | string // Logic for CIDR validation added in orchestrator
        sdn_zone: string | *env.vm_defaults.sdn_zone
        ...
    }

    os?: {
        image?:    string
        ssh_user?: string
    os: {
        image:               string
        ssh_user:            string | *"ubuntu"
        ssh_authorized_keys: [...string] & [_, ...string]

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

    roles?: [...(#Role & { env: env })]
    // All VMs have the "server" role by default.
    roles: [...string] | *["server"]

    services?: {
        docker_compose?: {
            path?:    string
            content?: string
            ...
        docker_compose?: [...string]
        systemd_units?:  [...string]
        
        // Constraint: if docker_compose is present, suggest systemd integration
        if docker_compose != _|_ {
            systemd_units: ["docker-compose.service"]
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
    vault: {
        approle:   string | *"auto"
        templates: [...string]
        // Constraint: If templates exist, approle must not be empty
        if len(templates) > 0 {
            approle: !=""
        }
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