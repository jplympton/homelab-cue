package prod

import environment "homelab.local/homelab-cue/schema/environment"

env: environment.#Environment & {

    env: "prod"

    vm_defaults: {
        node:     "pve1"
        vlan:     10
        sdn_zone: "core"
        storage:  "ceph-vms"
    }

    vault: {
        address: "https://vault.prod.local:8200"
    }

    infisical: {
        address:     "https://infisical.prod.local"
        environment: "prod"
        project:     "homelab"
    }

    platform_overrides: {
        nodes: {
            pve0: {}
            pve1: {}
        }

        sdn: {
            zones: {
                core: {
                    nodes: ["pve0", "pve1"]
                }
            }
        }

        storage: {
            "ceph-vms": {}
        }
    }
}