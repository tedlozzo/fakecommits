# 💥 TED LOZZO: Destroyer of Git Metrics

This repository exists for one purpose:  
To **visually demonstrate** how easy it is to fake GitHub contributions and why measuring developer productivity by **commit count** is a flawed idea.

## 🧨 What This Script Does

[`commit_faker.sh`](./commit_faker.sh) will:

- Nuke the entire Git history
- Replace it with a **single, surgically-crafted commit**
- Set the author name to `TED LOZZO`
- Set the commit date to `2025-04-28`
- Force-push the lie

This creates a clean, suspiciously perfect GitHub graph.

## ⚠️ Why?

Because someone, somewhere, still thinks:
> "Just count commits, it’ll show who’s most productive."

Spoiler: it won’t.  
This repo is your visual proof.

## 🛠️ Usage

> Only run this in a **throwaway repo**. You’ve been warned.

```bash
chmod +x commit_faker.sh
bash commit_faker.sh
git push -f origin main
