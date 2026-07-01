package role_registry

import subroles "homelab.local/homelab-cue/schema/roles"

#AllRoles: subroles

#Expand: {
	input: [...]
	output: [for r in input {r}]
}
