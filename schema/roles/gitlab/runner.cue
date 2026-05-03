package gitlab

#RoleGitLabRunner: {
    name: "gitlab-runner"

    // Principal for runner registration tokens
    runner_principal?: string | *"gitlab-runner"

    services?: {
        docker_compose?: null
        systemd_units?: []
        ...
    }

    app?: {
        gitlab_runner: {
            enabled?: true
            concurrent?: 4
            executor?: "docker"
            ...
        }
        ...
    }

    monitoring?: {
        exporters?: []
        ...
    }

    ...
}

#Transform: {
    vm: _
    context: _
    out: _
}