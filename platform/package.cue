package platform

import (
    CLU_1 "homelab.local/homelab-cue/platform/CLU_1"
    CLU_2 "homelab.local/homelab-cue/platform/CLU_2"
)

clusters: {
    "CLU-1": CLU_1.data
    "CLU-2": CLU_2.data
}