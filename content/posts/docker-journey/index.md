---
title: "From Confusion to Contribution: A Docker Journey"
date: 2025-01-15
draft: false
description: "What started as networking confusion became a custom bridge plugin. Somewhere in between, I taught it to interns — and teaching is where the real understanding happened."
tags: ["docker", "networking", "teaching"]
---

In March 2024, I couldn't make two Docker containers talk to each other on a custom bridge network. The official documentation assumed a working knowledge of Linux networking that I didn't have, and every Stack Overflow answer started three steps ahead of where I was.

By January 2025, I had written a custom Docker bridge plugin that handled DNS resolution, isolation policies, and automatic cleanup — and I'd taught the fundamentals to a group of interns along the way. This is the story of what happened in between, and why the path from confusion to contribution was anything but linear.

## The Starting Point

The fablab needed isolated networks for different project groups. Each group should be able to reach shared services (registry, wiki) but not interfere with each other. Standard Docker networking doesn't give you that out of the box.

## What I Learned

The most valuable insight wasn't technical. It was pedagogical: explaining bridge networking to interns forced me to confront every gap in my own understanding. You can't handwave when someone asks "but why does the packet go there?"

And the custom plugin? It's the proof that understanding accrues. Dormant knowledge doesn't expire. It waits for the right problem to activate it.
