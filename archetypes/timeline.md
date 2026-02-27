---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
year: {{ now.Year }}
# color: REQUIRED — semantic color (one of: fresh | convergence | pattern | temporal | frontier | block)
#   fresh: new insight, learning moment, strong signal
#   convergence: old idea meets new work, synthesis, understanding
#   pattern: extracted skill pattern, reusable template
#   temporal: time marker, historical reflection
#   frontier: unexplored, speculative
#   block: neutral, raw knowledge block
color: block
# quote: REQUIRED — 1-2 sentence italic reflection of the "moment of recognition"
#   This is the core of the timeline entry. First-person voice. The insight that clicked.
#   Example: "Teaching Docker to interns forced me to explain things I'd only understood intuitively."
quote: ""
# linkedPost: optional — relative URL to related post or pattern
#   Example: /posts/docker-journey/ or /patterns/distributed-systems/
#   Omit this line if no related content exists.
# linkedPost:
featuredOnHomepage: false
---

