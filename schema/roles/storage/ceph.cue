package storage

#RoleCephStorage: {
    name: "ceph-storage"

    extra_nics?: [
        {
            bridge:   "vmbr2"
            vlan:     40
            sdn_zone: "ceph"
            ip:       "auto"
            ...
        }
    ]

    ...
}

#Transform: {
    vm: _
    context: _
    out: _
}