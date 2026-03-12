---
title: "Evidence-First Engineering: How I Stopped Trusting My Own Estimates"
date: 2026-02-20
description: "A shift in how I approach technical decisions — from intuition-first to evidence-first — and what changed when I started demanding proof before conviction."
tags: ["engineering", "decision-making", "knowledge-systems"]
categories: ["Practice"]
draft: false
blockCount: 5
timespan: "January 2024 – February 2026"
---

For most of my career, I trusted my intuitions. When a technical decision felt right — a library choice, an architecture pattern, a trade-off — I'd lead with confidence and build justification afterward. This isn't dishonest; it's how most engineers work. We call it "experience."

The problem is that experience, unexamined, is just a collection of survivorship biases. You remember the calls that worked out. You quietly forget the ones that didn't. And your confidence compounds in directions that aren't always warranted.

The shift happened gradually, then all at once.

## The First Warning Sign

In early 2024, I was designing a container networking solution for a fablab environment. I was confident — I'd done networking before, I understood the concepts, the architecture felt obvious. I built it, presented it, and then spent three weeks debugging assumptions I'd never questioned.

The networking worked, eventually. But the experience left a residue: I hadn't verified anything before committing. I'd trusted the feeling of understanding over the evidence of it.

## What Evidence-First Actually Means

Evidence-first doesn't mean paralysis-by-analysis. It means establishing a minimum viable proof before conviction.

Before I commit to a technical direction now, I ask: what would I expect to see if this approach were correct? What would falsify it? Can I create a small, cheap test that generates real evidence rather than theoretical argument?

This sounds obvious. It isn't. The pressure to project confidence — in meetings, in architecture reviews, in Slack threads — consistently pushes toward leading with conclusions. Evidence-first requires resisting that pressure deliberately.

## The Docker Bridge Plugin

The same fablab networking problem became the proof of concept. After the initial failure, I rebuilt the approach evidence-first:

- Started with the smallest possible test: two containers, one bridge, one rule
- Documented what worked and what didn't, with dates and specific conditions
- Built up the confidence bar incrementally, block by block
- Only extended the architecture when each layer was verified

The result was a custom bridge plugin that handled DNS resolution, isolation policies, and automatic cleanup. More importantly: I understood exactly why it worked. Every decision was anchored to a specific test result, not a remembered heuristic.

## Knowledge Blocks as Evidence

The evidence.yaml format in this portfolio is a direct product of that shift. Each entry is a dated claim: "on this date, in this context, this understanding was confirmed (or revised)."

A confidence score of 78 on this post means: I've tested this approach across multiple contexts, it holds, but I'm still finding edge cases. A score of 85 would mean the pattern has been stable across substantially more varied environments.

The score isn't flattery. It's a calibration claim, and I'm willing to defend it.

## What Changed

Evidence-first engineering changed how I read other people's confidence, too. When someone presents a conclusion without showing their evidence, I now hear a gap. Not dishonesty — just a step that was skipped.

The question I ask most often now, to myself and others: what would change your mind?

If the answer is "nothing," that's not confidence. That's a position. And positions, unlike evidence, don't update.
