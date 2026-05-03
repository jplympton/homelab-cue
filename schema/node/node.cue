package node

import network "homelab.local/homelab-cue/schema/network"

#Node: {
    // Optional because overrides may delete or replace NIC/bridge maps
    nics?:    { [string]: #NIC }
    bridges?: { [string]: network.#Bridge }

    // Optional sub‑objects
    iscsi?: #ISCSI

    // Optional list fields
    ceph_interfaces?:    [...string],
    migration_interface?: string | null,
    storage_backends?:   [...string],

    // Allow forward‑compatible fields
    ...
}

#NIC: {
    // Optional because overrides may delete or replace NICs
    name?:  string
    mac?:   string
    pci?:   string
    mtu?:   uint
    speed?: string

    ...
}

#ISCSI: {
    // Optional because overrides may delete or replace iSCSI
    via_bridge?:        string
    vlan?:              uint
    multipath_targets?: [...string],

    ...
}