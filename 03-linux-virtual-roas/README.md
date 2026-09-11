# Linux virtual ROAS

**9/11/2026** - Thus far my experience working with Linux networking stacks has been limited. When I've done virtualization (in my lab, Docker, Proxmox, Containerlab) or set up VPN tunnels with wg-quick, it has handled the low-level configuration for me. And I've done most of the heavy OpenWRT configs for my homelab through LuCI. So this morning, I read through [Daniil Baturin's](https://baturin.org/) excellent [Task-centered iproute2 user guide](https://baturin.org/docs/iproute2/) and got a better sense of what's going on under the hood.

To try it out for the first time, I rebuilt a [dirt-simple ROAS demo lab](../01%20arista-roas/) but now with less familiar Linux syntax. I deployed a single Alpine container, and represented the two end-hosts, the switch, and the router with network namespaces. The configuration sequence is in [config.sh](config.sh).
