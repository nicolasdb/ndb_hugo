SHELL := /bin/bash
.DEFAULT_GOAL := help
# Run from inside the distrobox container — node/pnpm are not on the host (Fedora Kinoite)

guard-container:
	@test -f /run/.containerenv || (echo ""; echo "  ERROR: Run this from inside the distrobox container."; echo "  Hint:  distrobox enter <name>"; echo ""; exit 1)

.PHONY: help dev stop build test guard-container

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

dev: guard-container ## Start Hugo + CSS watcher with live reload (Ctrl+C to stop)
	pnpm run dev:watch

stop: guard-container ## Kill Hugo and Vite processes
	@pkill -f "hugo server" 2>/dev/null && echo "Hugo stopped" || echo "Hugo was not running"
	@pkill -f "vite" 2>/dev/null && echo "Vite stopped" || echo "Vite was not running"

build: guard-container ## Production build (minified, cache-busted)
	pnpm run build

test: guard-container ## Validate Hugo build (catches frontmatter and template errors)
	pnpm run test
