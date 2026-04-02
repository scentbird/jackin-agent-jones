# agent-jones

`agent-jones` is the Scentbird `jackin` agent. It provides the agent-specific environment layer for the Scentbird Java monorepo.

`jackin` validates this repo's Dockerfile, derives the final image itself, and mounts the cached repo checkout into `/workspace` when you run:

```sh
jackin load scentbird/agent-jones
```

## Contract

- Final Dockerfile stage must literally be `FROM donbeave/jackin-construct:trixie`
- Plugins are declared in `jackin.agent.toml`

## Environment

- **Node.js** LTS (via mise)
- **Java** Oracle GraalVM 21.0.7 and 23.0.2 (23.0.2 is default, via mise)
- **Protobuf compiler** (via mise)
- **ctx7** (npm)

Shared shell/runtime tools come from `jackin-construct:trixie`.
