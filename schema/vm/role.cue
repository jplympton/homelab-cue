package vm

#Role: {
    env: _

    name?: string

    extra_disks?: [...(#Disk & { env: env })]
    extra_nics?:  [...(#NIC  & { env: env })]

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