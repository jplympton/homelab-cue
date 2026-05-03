package vms

import (
    vm       "homelab.local/homelab-cue/schema/vm"
    env      "homelab.local/homelab-cue/env/lab"

    server   "homelab.local/homelab-cue/schema/roles/server"
    devtools "homelab.local/homelab-cue/schema/roles/devtools"
    vault    "homelab.local/homelab-cue/schema/roles/vault"
)

vm_dev_lab: vm.#VM(env) & {
    name:        "vm-dev-lab"
    description: "Development and lab tools VM"

    roles: [
        server.#RoleServer,
        devtools.#RoleDevTools,
        vault.#RoleVaultClient,
    ]

    node: env.vm_defaults.node

    resources: {
        cpu:    4
        memory: 8192
    }

    disks: [
        {
            name:   "root"
            size:   "40G"
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

    ...
}