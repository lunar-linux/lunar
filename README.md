# Lunar

Lunar is a source-based package management system for [Lunar Linux](https://lunar-linux.org).
It compiles software from source, resolves dependencies, and tracks installed files.
Written in Bash, it uses a "moonbase" repository of module definitions organized by section.

## Programs

| Command | Purpose                                                                  |
|---------|--------------------------------------------------------------------------|
| `lunar` | Menu-driven management interface (install, remove, update, rebuild, fix) |
| `lin`   | Install modules -- handles dependencies, download, and build             |
| `lrm`   | Remove modules                                                           |
| `lvu`   | Query module info from moonbase and installed packages                   |
| `lget`  | Download and update the moonbase repository                              |
| `lvis`  | Front-end to lin with build output in a separate xterm                   |
| `lsh`   | Interactive shell with the lunar environment loaded                      |

## Install

```bash
make install                 # Install to system (default /)
make DESTDIR=/path install   # Install to staging directory
```

There is no build step -- the Bash source is installed directly.

## Project Structure

```
prog/       Programs (lunar, lin, lrm, lvu, lget, lvis, lsh)
libs/       Shared Bash function libraries (installed to /var/lib/lunar/functions/)
plugins/    Dynamically-loaded plugins for download, verify, unpack, build, check
menu/       Dialog menu definitions for the lunar interface
etc/        Default configuration
mirrors/    Mirror lists
man/        Man pages
```

## Configuration

- `/etc/lunar/config` -- Default settings and path definitions
- `/etc/lunar/local/config` -- User overrides
- `/etc/lunar/local/depends/` -- Per-module dependency configuration

## State Files

Module state and dependency data are stored in `/var/state/lunar/`:

- `packages` -- Installed module status and versions
- `depends` -- Dependency database
- `depends.cache` -- Cached dependency info rebuilt from moonbase DEPENDS files
- `module.index` -- Module-to-section lookup cache
- `replacement.index` -- Module replacement mappings

## License

GPL-2.0
