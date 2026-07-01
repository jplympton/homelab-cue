// schema/vm_ir.cue
package schema

import (
	vmSchema "homelab.local/homelab-cue/schema/vm"
	envSchema "homelab.local/homelab-cue/schema/environment"
	platformSchema "homelab.local/homelab-cue/schema/platform"
)

// -----------------------------------------------------------------------------
// Canonical VM IR Schema
// This is the contract between orchestrator → transform.
// -----------------------------------------------------------------------------

#VMIR: {
	// Base VM intent (all fields from vmSchema.#VM)
	vmSchema.#VM

	// Environment context (selector.result)
	environment: envSchema.#Environment & {
		// Effective platform is already projected
		platform: platformSchema.#Platform

		// Secrets are attached here
		SECRETS: _
	}

	// Expanded roles (after roleRegistry.#Expand)
	roles: [...#RoleIR]

	// Optional: resolved defaults applied at IR level
	// These are environment‑dependent and VM‑dependent.
	resolved?: {
		node?:     string
		vlan?:     int
		sdn_zone?: string
		storage?:  string
	}
}

// -----------------------------------------------------------------------------
// Role IR Schema
// -----------------------------------------------------------------------------

#RoleIR: {
	// Role name (e.g., "vault", "gitlab", "runner")
	name: string

	// Role-specific config after expansion
	config: _

	// Optional: role-level dependencies
	depends_on?: [...string]
}
