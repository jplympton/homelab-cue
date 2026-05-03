package vlan

#VLAN: {
    id:          uint
    name?:       string
    description?: string
    zone?:       string
    tagged?:     bool | *false
}