package environment

#Environment: {
    // Name of the environment: dev, lab, prod
    env: string

    // Default VM placement and networking for this environment
    vm_defaults?: {
        node?:     string
        vlan?:     int
        sdn_zone?: string
        storage?:  string
        ...
    }

    // Vault endpoint for this environment
    vault?: {
        address?: string
        ...
    }

    // Infisical endpoint and project/environment mapping
    infisical?: {
        address?:     string
        environment?: string
        project?:     string
        ...
    }

    // Sparse platform overrides applied on top of the base cluster platform
    platform_overrides?: {
        nodes?: {
            [string]: { ... }
        }

        sdn?: {
            zones?: {
                [string]: { ... }
            }
        }

        storage?: {
            [string]: { ... }
        }
    }

    ...
}