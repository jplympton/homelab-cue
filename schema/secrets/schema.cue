package secrets

#Secrets: {
    vault_root_token?:    string
    proxmox_api_token?:   string
    gitlab_runner_token?: string

    ssh?: {
        [principal=string]: {
            keys: [...string]
        }
    }

    ...
}