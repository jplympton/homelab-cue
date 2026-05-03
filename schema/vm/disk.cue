package vm

#Disk: {
    env: _

    name?: string
    size?: string
    type?: *"scsi" | "virtio" | "ide"

    storage?: *env.vm_defaults.storage | string

    ...
}