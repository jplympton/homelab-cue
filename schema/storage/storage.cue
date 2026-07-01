package storage

#Storage: {
	// Optional because overrides may delete or replace storage backends
	type?: string

	// Optional list fields
	content?: [...string]
	nodes?: [...string]

	// Optional subtype blocks
	lvm_thin?: #LVMThin
	rbd?:      #RBD

	// Allow forward‑compatible fields
	...
}

#LVMThin: {
	// Optional because overrides may delete or replace fields
	type?:     "lvm-thin"
	vg?:       string
	thinpool?: string

	// Optional list field
	content?: [...string]

	...
}

#RBD: {
	// Optional because overrides may delete or replace fields
	type?: "rbd"
	pool?: string

	// Optional list fields
	content?: [...string]
	monitors?: [...string]

	...
}
