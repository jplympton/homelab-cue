Transform Layer
The transform layer is the final stage of the Homelab IaC pipeline.
It consumes:
- vm_ir (canonical IR from orchestrator)
- context (environment context)
and produces:
- vm_effective
- provider outputs (Proxmox, cloud-init, etc.)
The transform layer is pure: given the same IR and context, it always produces the same output.

Responsibilities
1. OS Layer
The transform resolves:
- SSH principal → authorized keys
- OS user
- OS configuration
2. Role Transforms
Each role in vm_ir.roles contains a #Transform function.
The transform layer executes:
r.#Transform & { vm: vm_ir, context: context }


and collects the outputs into:
vm_effective.roles


3. Build vm_effective
This is the fully resolved VM:
- VM intent
- environment context
- OS layer
- role outputs
4. Provider Transforms
Each provider receives:
{ vm: vm_effective }


and produces:
- Proxmox VM JSON
- cloud-init configs
- (future) Terraform JSON
- (future) Ansible inventory
5. Final Output
The transform exposes:
result: {
    vm:        vm_effective
    proxmox:   proxmox_output
    cloudinit: cloudinit_output
}



What the Transform Does Not Do
- No environment selection
- No secrets selection
- No platform projection
- No role expansion
- No IR construction
Those belong to the selector and orchestrator.

File Layout
transform/
    transform.cue
    README.md



Running the Transform
The transform is normally invoked through the orchestrator, but can be tested directly:
cue eval ./transform -e result


The transform layer is intentionally pure and deterministic.
