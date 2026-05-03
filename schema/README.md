VM Schema
Overview
The VM Schema defines the authoritative, provider‑agnostic structure for virtual machine configuration in the Homelab Orchestrator.
It is the single source of truth for all VM definitions and is consumed by:
- the Orchestrator Model
- the Transform Layer (Terraform, Cloud‑Init, Systemd, Docker Compose, Vault Agent, Bootstrap)
- the Debug Harness
The schema ensures that all VM definitions are valid, complete, and safe to transform into provider‑specific artifacts.

File Location
schema/vm/config.cue


This file exports a single top‑level definition:
#VM


Every VM in the system must conform to this definition.

Purpose of the VM Schema
The VM Schema provides:
- A stable contract between VM definitions and transforms
- Strong validation to prevent invalid configurations
- A provider‑agnostic representation of VM intent
- A consistent structure for all VMs
- A foundation for deterministic transforms and reproducible provisioning
The schema is intentionally strict to eliminate drift and runtime errors.

Schema Structure
The schema is organized into the following sections:
- Identity
- Placement
- Resources
- Disks
- NICs
- Networking
- OS / Cloud‑Init
- Services
- Vault Integration
Each section is validated with type constraints, value constraints, structural constraints, and cross‑field rules.

Key Validation Rules
Identity
- VM name must match a safe hostname pattern.
- Description is optional.
Placement
- Node may be explicitly set or default to "auto".
Resources
- CPU must be > 0
- Memory must be >= 512 MB
Disks
- At least one disk is required
- Disk size must be > 0
- Disk type must be one of: scsi, virtio, ide
- Storage backend must be valid
NICs
- At least one NIC is required
- VLAN must be between 0 and 4094
- NIC model must be one of: virtio, e1000, rtl8139
Networking
- IP must be either "dhcp" or a valid IPv4 CIDR
- SDN zone must be one of: auto, trusted, dmz, infra
OS / Cloud‑Init
- SSH user defaults to "ubuntu"
- At least one SSH key is required
Services
- docker_compose and systemd_units are optional
- If docker-compose is used, systemd must include a compose unit
Vault Integration
- approle defaults to "auto"
- If templates exist, approle must not be empty

Cross‑Field Constraints
The schema enforces relationships between fields:
- Static IP requires NICs (already enforced by NIC count)
- Vault templates require a non-empty approle
- docker-compose implies systemd integration
These constraints prevent invalid or incomplete VM definitions from entering the transform layer.

Example VM Definition
vm-security: #VM & {
    name: "vm-security"
    description: "Security services VM"

    node: "auto"

    resources: {
        cpu: 4
        memory: 8192
    }

    disks: [{
        name: "root"
        sizeGB: 20
        type: "scsi"
        storage: "local-lvm"
    }]

    nics: [{
        name: "ens18"
        model: "virtio"
        bridge: "vmbr0"
        vlan: 1
    }]

    network: {
        ip: "dhcp"
        sdn_zone: "auto"
    }

    os: {
        image: "tpl-uefi-deb13"
        ssh_user: "jim"
        ssh_authorized_keys: [
            "ssh-ed25519 AAAA..."
        ]
    }

    services: {
        docker_compose: ["vault", "vault-ui"]
        systemd_units: ["vault-agent-extra.service"]
    }

    vault: {
        approle: "auto"
        templates: ["vault-agent.hcl.tpl"]
    }
}



How Transforms Use the Schema
The VM Schema feeds directly into:
- Terraform (proxmox_vms.cue)
- Cloud‑Init (cloud-init.cue)
- Systemd (systemd.cue)
- Docker Compose (docker-compose.cue)
- Vault Agent (vault-agent.cue)
- Bootstrap (bootstrap.cue)
Because the schema enforces correctness, transforms can assume:
- at least one disk
- at least one NIC
- valid IP format
- valid VLAN
- valid SSH keys
- valid disk and NIC types
This eliminates entire classes of runtime errors.

Debug Harness Integration
You can validate VM definitions using:
make debug-model
make debug


The debug harness ensures:
- schema unification
- transform compatibility
- version injection correctness
- multi-VM consistency

Future Extensions (Milestone 3)
The schema is designed to support:
- environment variables
- volume mappings
- overlay networks
- static IP routing
- secrets injection
- service-level configuration blocks
These will be added in Milestone 3.
