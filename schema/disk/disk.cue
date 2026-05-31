package disk

// #Disk defines the canonical structure for virtual disks in the homelab.
#Disk: {
	env: _

	name:    string
	sizeGB:  int & >0
	type:    "scsi" | "virtio" | "ide"
	storage: string
	...
}