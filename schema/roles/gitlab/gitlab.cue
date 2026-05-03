package gitlab

#RoleGitLab: {
    name: "gitlab"

    // Principal for GitLab server secrets (Rails, SMTP, OAuth, registry, etc.)
    gitlab_principal?: string | *"gitlab"

    services?: {
        docker_compose?: null
        systemd_units?: []
        ...
    }

    app?: {
        gitlab: {
            enabled?: true
            http_port?: 8080
            ssh_port?: 2222
            data_dir?: "/var/opt/gitlab"
            ...
        }
        ...
    }

    monitoring?: {
        exporters?: []
        ...
    }

    vault?: {
        templates?: []
        token_sink?: string
        ...
    }

    ...
}

#Transform: {
    vm: _
    context: _
    out: _
}