package transform

import (
    vmSchema     "homelab.local/homelab-cue/schema/vm"
    roleRegistry "homelab.local/homelab-cue/schema/role_registry"
    selector     "homelab.local/homelab-cue/env/selector"

    proxmox   "homelab.local/homelab-cue/provider/proxmox"
    cloudinit "homelab.local/homelab-cue/provider/cloudinit"
)

context: selector.result

vm_input: vmSchema.#VM & { env: context } @tag(vm_input)

// *** FIXED: parentheses ensure .output applies to the unified struct ***
roles_expanded: (roleRegistry.#Expand & {
    input: vm_input.roles
}).output

vm_ir: vm_input & {
    environment: context
    roles:       roles_expanded
}

role_effective: {
    for r in vm_ir.roles {
        "\(r.name)": r.#Transform & {
            vm:      vm_ir
            context: context
        }
    }
}

os_effective: {
    user: vm_ir.os.ssh_user
    ssh_authorized_keys: context.SECRETS.ssh[vm_ir.os.ssh_principal].keys
}

vm_effective: vm_ir & {
    os: os_effective
    roles: {
        for k, v in role_effective {
            k: v.out
        }
    }
}

proxmox_output:   proxmox.#Transform & { vm: vm_effective }.out
cloudinit_output: cloudinit.#Transform & { vm: vm_effective }.out

result: {
    vm:        vm_effective
    proxmox:   proxmox_output
    cloudinit: cloudinit_output
}