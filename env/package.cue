package env

import (
    devPkg  "homelab.local/homelab-cue/env/dev"
    labPkg  "homelab.local/homelab-cue/env/lab"
    prodPkg "homelab.local/homelab-cue/env/prod"
)

// Re-export subpackages so selector can iterate them
dev:  devPkg
lab:  labPkg
prod: prodPkg