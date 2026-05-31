package platform

// No imports needed here as #Platform is available within the 'platform' package.

// Subset-of-platform schema: every path must exist in the base platform.
#PlatformOverrides: {
    // Nodes subset
    nodes?: {
        [nodeName=string]: #Platform.nodes[nodeName] & {
            bridges?: {
                [bridgeName=string]: #Platform.nodes[nodeName].bridges[bridgeName] & {
                    vlan_ids?: [...int]
                    mtu?: int
                    description?: string
                    sdn_zones?: [...string]
                    nics?: [...string]
                }
            }

            iscsi?: #Platform.nodes[nodeName].iscsi & {
                via_bridge?: string
                vlan?: int
                multipath_targets?: [...string]
            }

            ceph_interfaces?: [...string]
            migration_interface?: string | null
        }
    }

    // SDN subset
    sdn?: {
        zones?: {
            [zoneName=string]: #Platform.sdn.zones[zoneName] & {
                nodes?: [...string]
                backend?: string
                bridge?: string
                description?: string
            }
        }
        // Allow other SDN fields if needed
        // vxlan_overlays?: _
    }

    // Storage subset
    storage?: {
        [storageName=string]: #Platform.storage[storageName] & {
            type?: string
            content?: [...string]
            nodes?: [...string]
            lvm_thin?: {
                thinpool?: string
                vg?: string
            }
        }
    }
}