package vms

import (
    vm      "homelab.local/homelab-cue/schema/vm"
    env     "homelab.local/homelab-cue/env/lab"

    server  "homelab.local/homelab-cue/schema/roles/server"
    netbox  "homelab.local/homelab-cue/schema/roles/netbox"
    vault   "homelab.local/homelab-cue/schema/roles/vault"
)

vm_netbox: vm.#VM(env) & {
    name:        "vm-netbox"
    description: "NetBox IPAM/DCIM server"

    roles: [
        server.#RoleServer,
        netbox.#RoleNetbox,
        vault.#RoleVaultClient,
    ]

    node: env.vm_defaults.node

    resources: {
        cpu:    4
        memory: 8192
    }

    disks: [
        {
            name: "root"
            size: "40G"
            ...
        },
        {
            name: "data"
            size: "50G"
            ...
        },
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
        image:               "tpl-uefi-deb13"
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