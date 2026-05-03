package selector

import (
    platformClusters "homelab.local/homelab-cue/platform"
    platformSchema   "homelab.local/homelab-cue/schema/platform"
    envSchema        "homelab.local/homelab-cue/schema/environment"

    envs "homelab.local/homelab-cue/env"
)

// Defaults
cluster: string | *"CLU-1"
env:     string | *"lab"

// env/ package re-exports dev/lab/prod as dev, lab, prod
// envs.dev, envs.lab, envs.prod

// Dynamically collect all environments
environments: {
    for k, v in envs {
        "\(k)": v.env
    }
}

// Dynamically collect all secrets
secrets: {
    for k, v in envs {
        "\(k)": v.secrets
    }
}

// Selected env + secrets
env_value:     environments[env] & envSchema.#Environment
secrets_value: secrets[env]

// Base platform instance
base_platform: platformClusters.clusters[cluster] & platformSchema.#Platform

// Validate platform_overrides as a subset of the base platform
platform_overrides: platformSchema.#PlatformOverrides & env_value.platform_overrides

// Projection: platform_effective is the subset view
platform_effective: base_platform & platform_overrides

// Final environment context
result: env_value & {
    platform: platform_effective
    SECRETS:  secrets_value
}