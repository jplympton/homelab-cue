# Orchestrator Layer

The orchestrator is the middle layer of the Homelab IaC pipeline. It sits between:

`selector → orchestrator → transform`

Its purpose is to construct the canonical VM IR (Intermediate Representation) by combining:

- VM intent
- Environment context (from selector)
- Expanded roles (from role registry)

The orchestrator does not perform any provider-specific logic. It produces a normalized IR and hands it to the transform layer.

## Responsibilities

1. Load VM Intent
   - The orchestrator selects a VM definition from `vms/<env>/<vm>.cue`
2. Bind Environment Context
   - It invokes the selector with the chosen environment. The selector provides:
     - environment defaults
     - secrets
     - projected platform (subset of base platform)
3. Construct `vm_input`
   - This is the VM intent unified with the environment context.
4. Expand Roles
   - Using `role_registry.#Expand`, the orchestrator converts role names into fully expanded role definitions.
5. Build Canonical IR (`vm_ir`)
   - The IR is defined by `schema/vm_ir.cue` and includes:
     - VM intent
     - environment context
     - expanded roles
6. Hand Off to Transform
   - The orchestrator passes:
     - `vm_ir`
     - `context`
   to the transform layer.

## What the Orchestrator Does Not Do

- provider transforms
- OS transforms
- role transforms
- cloud-init generation
- Proxmox generation
- secrets resolution
- platform projection (selector does this)

## File Layout

```
orchestrator/
    entrypoint.cue
    README.md
```

## Running the Orchestrator

Example:

```sh
cue eval ./orchestrator -e proxmox -e vm_name='"vm-vault-01"' -e vm_env='"lab"'
```

This produces:

- IR
- `vm` (effective VM)
- Proxmox output
- cloud-init output

The orchestrator is intentionally small, deterministic, and easy to reason about.
