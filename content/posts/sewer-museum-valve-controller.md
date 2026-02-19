---
title: "Designing the Brussels Sewer Museum Valve Controller"
date: 2024-12-10
draft: false
description: "An ESP32-based system with I2C-addressable modules controlling water valves for a museum installation. Wet-environment constraints forced every decision to be deliberate."
tags: ["electronics", "ESP32", "museum"]
---

The Brussels Sewer Museum needed a way to control water flow through a scale model of the city's drainage system. Visitors would interact with touchpoints that opened and closed valves, watching how water moved through the network.

The constraints were unusual: everything had to survive high humidity, the control modules needed to be individually addressable (twelve valves across three zones), and the system had to fail safe — valves closed, not open.

## Design Decisions

We chose ESP32 modules communicating over I2C. Each module handles four valves through MOSFET drivers. The main controller runs a simple state machine that maps visitor interactions to valve sequences.

The wet environment forced deliberate choices at every level: conformal coating on all boards, sealed connectors, and a watchdog timer that closes all valves if the main controller stops responding.

## What Emerged

Twelve years of accumulated hardware intuition compressed into a single confident afternoon of architecture decisions. The patterns from satellite systems — redundancy, fail-safe defaults, watchdog timers — mapped directly to museum installation constraints. Different scale, identical architecture.
