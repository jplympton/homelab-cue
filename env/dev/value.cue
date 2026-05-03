package dev

import environment "homelab.local/homelab-cue/schema/environment"

// Export the environment at the package root
env: environment.#Environment & {

    env: "dev"

    vm_defaults: {
        node:     "pve0"
        vlan:     20
        sdn_zone: "dev"
        storage:  "local-lvm"
    }

    vault: {
        address: "http://vault.dev.local:8200"
    }

    infisical: {
        address:     "http://infisical.dev.local"
        environment: "dev"
        project:     "homelab"
    }

    platform_overrides: {
        nodes: {
            pve0: {
                bridges: {
                    vmbr0: {
                        vlan_ids: [20]
                    }
                }
            }
        }

        sdn: {
            zones: {
                dev: {
                    nodes: ["pve0"]
                }
            }
        }

        storage: {
            "local-lvm": {
                lvm_thin: {
                    thinpool: "data-dev"
                }
            }
        }
    }
}