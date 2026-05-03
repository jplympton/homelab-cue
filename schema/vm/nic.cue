package vm

#NIC: {
    env: _

    bridge?:   string
    vlan?:     uint | "auto" | *env.vm_defaults.vlan
    sdn_zone?: string | "auto" | *env.vm_defaults.sdn_zone
    ip?:       string | "auto" | "dhcp"

    ...
}