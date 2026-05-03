// orchestrator/entrypoint.cue
package orchestrator

import (
    selector     "homelab.local/homelab-cue/env/selector"
    vmSchema     "homelab.local/homelab-cue/schema/vm"
    roleRegistry "homelab.local/homelab-cue/schema/role_registry"
    vms          "homelab.local/homelab-cue/vms"
    xform        "homelab.local/homelab-cue/transform"
)

// Inputs (override via -e vm_name, -e vm_env)
vm_name: *"vm-vault-01" | string
vm_env:  *"lab" | string

// VM intent
vm_def: vms[vm_env][vm_name]

// Environment context (selector bound to vm_env)
context: (selector & { env: vm_env }).result

// VM input: intent + env context
vm_input: vmSchema.#VM & vm_def & {
    env: context
} @tag(vm_input)

// Role expansion (pure intent → role list)
roles_expanded: (roleRegistry.#Expand & {
    input: vm_input.roles
}).output

// Canonical IR: VM + env + roles
vm_ir: vm_input & {
    environment: context
    roles:       roles_expanded
}

// Hand off to transform
pipeline: xform & {
    input: {
        vm_ir:   vm_ir
        context: context
    }
}

// Exposed outputs
ir:        vm_ir
vm:        pipeline.result.vm
proxmox:   pipeline.result.proxmox
cloudinit: pipeline.result.cloudinit