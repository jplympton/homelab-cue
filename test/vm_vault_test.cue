package test

import vault "homelab.local/homelab-cue/schema/roles/vault"

vm_vault_test: {
    name: "vm-test"

    os: {
        ssh_user:      "jim"
        ssh_principal: "jim"
    }

    roles: [
        vault.#RoleVaultClient
    ]
}