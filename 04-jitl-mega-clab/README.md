# JITL Mega (c)Lab + Ansible

A couple of weeks before I took the CCNA last May, I did [Jeremy's IT Lab's](https://www.jeremysitlab.com/) Mega Lab in Packet Tracer. It was great practice, and a great lab, except for Packet Tracer getting more and more unusable for crashing the closer I got to the end. So I'm thinking, why not try to reproduce most of it in containerlab?

## Log

**9/11/2026** - I'll use an cEOS image to keep it more lightweight. I'm not sure yet what I'm going to do for the IP phones and WLC/LWAP; maybe I'll mock them with Alpine containers?

[x] Reproduced most of the physical topology in containerlab. (Skipped WLC and LWAPs for now)

**9/14/2026** - Did some first work with Ansible, including a first Ansible playbook. I think I will make one playbook per original Packet Tracer step.
