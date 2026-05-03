package homelab_iac

import (
    selectorPkg   "homelab.local/homelab-cue/env/selector"
    secretsSchema "homelab.local/homelab-cue/schema/secrets"
)

// Parameters with defaults; override via -t cluster=... -t env=...
parameter: {
    cluster: *"CLU-1" | string @tag(cluster)
    env:     *"lab"   | string @tag(env)
}

// Selector instance
selector: selectorPkg & {
    cluster: parameter.cluster
    env:     parameter.env
}

// Unified environment
environment: selector.#result

// Secrets derived from environment
secrets: secretsSchema.#Secrets & environment.SECRETS

// Exported for vms/ packages (keeps your existing pattern working)
#exported_environment: environment
#exported_secrets:     secrets

test_output: {
    selected_cluster: parameter.cluster
    selected_env:     parameter.env
    env_obj:          environment
}