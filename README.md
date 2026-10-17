# Terraria Docker Server

Docker setup for running a Terraria dedicated server.

## Quick Start

1. **Build and run**:
```bash
docker-compose up -d
```

2. **View logs**:
```bash
docker-compose logs -f
```

3. **Stop server**:
```bash
docker-compose down
```

## Configuration

Edit `serverconfig.txt` to customize:
- `maxplayers` - Maximum players (default: 8)
- `password` - Server password (empty = no password)
- `worldname` - World name
- `difficulty` - 0=Classic, 1=Expert, 2=Master, 3=Journey
- `autocreate` - Auto-create world size (1=Small, 2=Medium, 3=Large)

## Ports

- `7777` - Terraria server (TCP)

## Data Persistence

Worlds are saved in `./worlds` directory and persist across container restarts.

## Server Commands

Access server console:
```bash
docker attach terraria-server
```

Detach without stopping: `Ctrl+P` then `Ctrl+Q`

## Updating Terraria Version

Edit `Dockerfile` and change `TERRARIA_VERSION` arg, then rebuild:
```bash
docker-compose build --no-cache
docker-compose up -d
```
