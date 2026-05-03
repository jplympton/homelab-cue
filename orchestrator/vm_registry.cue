package orchestrator

import (
    vmsLab  "homelab.local/homelab-cue/vms/lab"
    vmsProd "homelab.local/homelab-cue/vms/prod"
    vmsDev  "homelab.local/homelab-cue/vms/dev"
)

#VMRef: {
    name: string
    env:  string
}

// Registry keyed by "env/name"
vm_registry: [string]: #VMRef & {
    // Example entries; you can generate or maintain this
    "lab/vm-vault-01": {
        name: "vm-vault-01"
        env:  "lab"
    }
    "prod/vm-vault-01": {
        name: "vm-vault-01"
        env:  "prod"
    }
}

// Resolve VM definition by key
vm_definitions: [key=_]: {
    vm: {
        if vm_registry[key].env == "lab" {
            vmsLab[vm_registry[key].name]
        }
        if vm_registry[key].env == "prod" {
            vmsProd[vm_registry[key].name]
        }
        if vm_registry[key].env == "dev" {
            vmsDev[vm_registry[key].name]
        }
    }
}