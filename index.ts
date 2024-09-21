import * as pulumi from "@pulumi/pulumi";
import * as proxmox from "@muhlba91/pulumi-proxmoxve";

const pulumiProxmoxConfig = new pulumi.Config("promox-pulumi");

const proxmoxNodeName = "proxmox";

const provider = new proxmox.Provider("proxmoxve", {
  endpoint: pulumiProxmoxConfig.require("proxmox-endpoint"),
  apiToken: pulumiProxmoxConfig.require("proxmox-api-token"),
  insecure: true,
});

const proxmoxVm = new proxmox.vm.VirtualMachine(
  "simple-vm-via-pulumi",
  {
    nodeName: proxmoxNodeName,
    agent: { enabled: true },
    started: true,
    clone: { full: true, vmId: 667, nodeName: proxmoxNodeName },
    initialization: {
      ipConfigs: [{ ipv4: { address: "dhcp" } }],
    },
    stopOnDestroy: true,
  },
  {
    provider: provider,
  }
);

export const ipv4Addresses = proxmoxVm.ipv4Addresses;
export const ipv6Addresses = proxmoxVm.ipv6Addresses;
