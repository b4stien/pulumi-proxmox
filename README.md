# Proxmox w Pulumi

A simple reproduction to try automating the pop/depop of VMs on Proxmox and their IP recovery as outputs via Pulumi.

# To reproduce

- Setup the Proxmox host with `prepare-vm-template.sh` (download and setup a Debian 12 Proxmox VM template).
- Setup proper values in `Pulumi.dev.yaml` for Proxmox's API token and endpoint.
- Launch pulumi with `pulumi up -s dev`.

## The output

As we can see, we get an error and no IP: "warning: Undefined value (ipv4Addresses) will not show as a stack output.".

```
14h07: bastien at alizee3 in ~/dev/oui/pulumi-proxmox on g:master:
↪ pulumi up -s dev
Previewing update (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/b4stien/promox-pulumi/dev/previews/1dc00aa4-34a4-495c-acc4-feb45988a091

     Type                            Name               Plan
 +   pulumi:pulumi:Stack             promox-pulumi-dev  create
 +   ├─ pulumi:providers:proxmoxve   proxmoxve          create
 +   └─ proxmoxve:VM:VirtualMachine  simple-vm          create

Outputs:
    ipv4Addresses: output<string>

Resources:
    + 3 to create

Do you want to perform this update? yes
Updating (dev)

View in Browser (Ctrl+O): https://app.pulumi.com/b4stien/promox-pulumi/dev/updates/7

     Type                            Name               Status              Info
 +   pulumi:pulumi:Stack             promox-pulumi-dev  created (14s)       1 warning; 1 message
 +   ├─ pulumi:providers:proxmoxve   proxmoxve          created (0.41s)
 +   └─ proxmoxve:VM:VirtualMachine  simple-vm          created (12s)

Diagnostics:
  pulumi:pulumi:Stack (promox-pulumi-dev):
    undefined

    warning: Undefined value (ipv4Addresses) will not show as a stack output.

Resources:
    + 3 created

Duration: 17s
```
