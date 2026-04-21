# 02 — Lab Kali (Validation poste attaquant)

**Date :** 20/04/2026 — 15h30 → 16h00
**Contexte :** Préparation du poste attaquant Kali 2025.1 sur VMnet5. Objectif : valider la connectivité réseau, la résolution DNS et le routage vers DC01 avant de lancer les audits. Aucune vulnérabilité testée à ce stade — c'est de la **due diligence de lab**.

## Captures

| Fichier | Description |
|---|---|
| `ip-config.png` | `ip addr` sur Kali → `10.10.10.100/24` sur `eth0`, passerelle absente (lab isolé) |
| `ping-dc01.png` | `ping -c 4 10.10.10.10` → 0% loss, RTT < 1 ms (réseau fonctionnel) |
| `dns-resolution.png` | `nslookup dc01.secuvia.local 10.10.10.10` → résolution OK (DNS DC-hosted) |

## Vulnérabilités identifiées

Aucune. Ce dossier sert de **baseline** : il prouve que les captures d'audit suivantes sont bien issues d'un Kali correctement configuré et connecté à la cible.

## Impact CIA

N/A (preuve de configuration, pas d'exploitation).

## Remédiation prévue (Phase 2)

N/A. Note : en environnement réel, la simple capacité d'un poste externe à pinger un DC indique un segment réseau mal isolé — à tracer dans la phase 2 via microsegmentation VMnet.
