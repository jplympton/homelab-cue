package vms

import (
    vm       "homelab.local/homelab-cue/schema/vm"
    env      "homelab.local/homelab-cue/env/lab"

    server   "homelab.local/homelab-cue/schema/roles/server"
    postgres "homelab.local/homelab-cue/schema/roles/database"
    vault    "homelab.local/homelab-cue/schema/roles/vault"
)

vm_db: vm.#VM(env) & {
    name:        "vm-db"
    description: "PostgreSQL database server"

    roles: [
        server.#RoleServer(env),
        postgres.#RoleDatabasePostgres(env),
        vault.#RoleVaultClient(env),
    ]

    resources: {
        cpu:    4
        memory: 8192
    }

    disks: [
        {
            name: "root"
            size: "40G"
            ...
        }
    ]

    nics: [
        {
            bridge:   "vmbr0"
            vlan:     env.vm_defaults.vlan
            sdn_zone: env.vm_defaults.sdn_zone
            ip:       "auto"
            ...
        }
    ]

    os: {
        image:         "tpl-uefi-deb13"
        ssh_user:      "jim"

        // intent-only principal (no secrets here), inherited from role, can be overridden.
        ssh_principal: server.ssh_principal
        ...
    }

    vault: {
        approle: "auto"
        ...
    }

    node: env.vm_defaults.node

    ...
}