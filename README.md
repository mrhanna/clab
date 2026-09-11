# Network Labs

At the end of the first interview I got after I finished my CCNA, one of the interviewers recommended that I get hip to [containerlab](https://containerlab.dev/). No doubt it's going to be a game-changer. I'm planning to use this repo as a sandbox for building labs and saving configurations as I go as a sort of living portfolio.

I'll probably start simple, rebuilding some labs I did in Packet Tracer when I was studying for CCNA, and getting acclimated to clab. Probably a good opportunity to mess with other CLI styles too. From there, I'll work my way into more interesting topologies and automation.

## Architecture & Workflow

For now, I'm dropping into a shell to configure things manually, and doing a `clab save ./configs` when I'm done.

```text
.
├── README.md                  # Root index
├── .gitignore                 # Ignores local runtime directories (clab-*/)
  └── <lab-name>/
      ├── <lab-name>.clab.yml  # Containerlab topology definition
      └── configs/             # Persistent startup-configs (saved via `clab save`)
          ├── r1.cfg
          └── sw1.cfg

```

### Quickstart Workflow

1. **Deploy a Lab:**

```bash
sudo clab deploy -t <lab-folder>/<lab-name>.clab.yml

```

2. **Access & Configure:**
   Access device CLIs using `docker exec` or SSH to build and test configurations:

```bash
docker exec -it clab-<lab-name>-r1 Cli

```

3. **Persist Configuration to Git:**
   Once topology changes are complete, save the running configurations across all nodes back to the `configs/` directory in one command:

```bash
sudo clab save -t <lab-folder>/<lab-name>.clab.yml

```

4. **Tear Down:**

```bash
sudo clab destroy -t <lab-folder>/<lab-name>.clab.yml

```

---
