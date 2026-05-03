// transform/transform.cue
package transform

import (
    vmSchema "homelab.local/homelab-cue/schema/vm"
    roleRegistry "homelab.local/homelab-cue/schema/role_registry"

    proxmox   "homelab.local/homelab-cue/provider/proxmox"
    cloudinit "homelab.local/homelab-cue/provider/cloudinit"
)

// Contract from orchestrator
input: {
    vm_ir: vmSchema.#VM & {
        environment: _
        roles: _
    }
    context: _
}

vm_ir:   input.vm_ir
context: input.context

// Per-role transforms (IR → role outputs)
role_effective: {
    for r in vm_ir.roles {
        "\(r.name)": r.#Transform & {
            vm:      vm_ir
            context: context
        }
    }
}

// OS layer (ssh principal → keys)
os_effective: {
    user: vm_ir.os.ssh_user
    ssh_authorized_keys: context.SECRETS.ssh[vm_ir.os.ssh_principal].keys
}

// Effective VM (IR + OS + role outputs)
vm_effective: vm_ir & {
    os: os_effective
    roles: {
        for k, v in role_effective {
            k: v.out
        }
    }
}

// Provider outputs
proxmox_output:   proxmox.#Transform & { vm: vm_effective }.out
cloudinit_output: cloudinit.#Transform & { vm: vm_effective }.out

// Final result
result: {
    vm:        vm_effective
    proxmox:   proxmox_output
    cloudinit: cloudinit_output
}