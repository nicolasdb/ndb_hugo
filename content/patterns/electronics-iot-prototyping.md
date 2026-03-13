---
title: "Electronics & IoT Prototyping"
date: 2025-01-01
draft: false
description: "ESP32 projects, PCB design, sensor networks, smart valve controllers — hands-on making as knowledge creation."
tags: ["electronics", "ESP32", "IoT"]
confidence: 78
blockCount: 11
timespan: "2009 – present"
trajectory: rising
featuredOnHomepage: true
---

## What This Pattern Is

Hardware design and embedded systems development across the full stack — from PCB layout and sensor integration to firmware, MQTT communication, and field deployment. The skill cluster spans microcontroller selection, power budgeting, signal conditioning, and the unglamorous work of making hardware behave reliably outside a lab.

## How It Emerged

The earliest layer comes from spacecraft systems work (2009–2013): custom ASICs, telemetry protocols, radiation tolerance constraints. That taught the fundamentals — define your interfaces before writing a line of firmware, handle failure modes first, not last.

The consumer IoT wave made this accessible in a different way. ESP32 and similar platforms meant rapid prototyping at low cost. The Sewer Museum valve controller (2024) compressed years of accumulated intuition into a single confident deployment: read sensor state, debounce correctly, persist across power cycles, publish MQTT events. It worked on the first deployment.

The FabLab context added another dimension — explaining hardware design thinking to beginners, building teaching rigs, documenting why a decision was made.

## Evidence

- Satellite telemetry systems (2009–2013): custom ASICs, telemetry protocol design
- Multiple ESP32 sensor network deployments (2022–present), including distributed monitoring setups
- Sewer Museum valve controller: first-deployment success after solving MQTT timing and state persistence issues — [linked post](/posts/sewer-museum-valve-controller/)
- PCB design experience (KiCad), sensor conditioning circuits, wireless communication protocols

## Trajectory

Rising. The tooling keeps improving (better dev boards, better debuggers, better simulators) and so does my comfort with the full cycle from concept to field deployment. Federation protocol work in 2025 reused the same convergence-detection patterns from spacecraft telemetry — the pattern holds across a 15-year span.
