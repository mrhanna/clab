# Single Area OSPF

**As a** Network Engineer

**I want to** deploy a single-area OSPF backbone across a multi-access LAN core and point-to-point remote branch links

**So that** all subnets achieve dynamic full-mesh reachability with predictable path selection, secured interfaces, and custom designated router elections.

---

## Topology Concept

A 4-router topology combining a multi-access segment and point-to-point links:

- **Core Segment (Broadcast Multi-Access):**
- `core-sw1` (Layer 2 switch) connecting `r1`, `r2`, and `r3` on a shared `/29` subnet.

- **Point-to-Point Links:**
- `r1` connects to `r4` over a dedicated `/30` point-to-point link.
- `r2` connects to `r4` over a secondary `/30` point-to-point link (creating a redundant path to `r4`).

- **Edge / LAN Interfaces:**
- Each router gets a Loopback `1` interface (`/32`) to act as its stable ID. A Loopback `2` interface (`/24`) is also added to simulate an edge LAN network without adding more devices to the lab.

---

## Acceptance Criteria

### 1. Control Plane & Adjacencies

- [x] All 4 routers participate in **OSPF Area 0**.
- [x] Each router has an explicitly assigned **Router ID** matching its loopback address in private IP space (e.g., `172.16.0.1` for `r1`, `172.16.0.2` for `r2`).
- [x] On the shared multi-access segment:
- `r1` must win the election to become the **Designated Router (DR)**.
- `r2` must become the **Backup Designated Router (BDR)**.
- `r3` must be forced into a **DROTHER** state.

- [ ] Point-to-point links between `r1`-`r4` and `r2`-`r4` must form direct adjacencies without electing a DR/BDR.

### 2. Traffic Steering

- [x] All loopback subnets are advertised into Area 0, but loopbacks are set as **passive interfaces** so no OSPF hellos are emitted on them.

### 3. Verification & Definition of Done

- [x] Running `show ip route ospf` (or your vendor's equivalent) on `r4` confirms routes to all loopbacks via OSPF.
- [x] Shutting down `r1`'s link to `r4` causes OSPF to converge, shifting `r4`'s route to `r3` through `r2` without dropping traffic indefinitely.
- [x] Running `clab save` persists all 4 device configurations back to your repo.
