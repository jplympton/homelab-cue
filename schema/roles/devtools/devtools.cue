package devtools

#RoleDevTools: {
    name: "devtools"

    services?: {
        docker_compose?: null
        systemd_units?: []
        ...
    }

    app?: {
        devtools: {
            includes: ["cue", "git", "docker", "kubectl"]
            ...
        }
        ...
    }

    ...
}

#Transform: {
    vm: _
    context: _
    out: _
}