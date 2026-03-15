# IntelliJ IDEA

Installs [IntelliJ IDEA](https://www.jetbrains.com/idea/) desktop client.

- **macOS**: Homebrew Cask (`intellij-idea-ce` / `intellij-idea`)
- **Arch**:
	- Community: pacman (`intellij-idea-community-edition`)
	- Ultimate: Flatpak (`com.jetbrains.IntelliJ-IDEA-Ultimate`)
- **Ubuntu**: Flatpak (`com.jetbrains.IntelliJ-IDEA-Community` / `com.jetbrains.IntelliJ-IDEA-Ultimate`)
- **Fedora**: Flatpak (`com.jetbrains.IntelliJ-IDEA-Community` / `com.jetbrains.IntelliJ-IDEA-Ultimate`)

## Configuration

You can choose which IntelliJ edition to install with `intellij_edition`.

Supported values:
- `community` (default)
- `ultimate`

Example (`group_vars/all.yml`):

```yaml
intellij_edition: ultimate
```

You can also choose a release line or pinned version with `intellij_version`.

Supported values:
- `latest` (default)
- `2025.2` (installs latest patch in that minor line)
- `2025.2.x` (same behavior as `2025.2`)
- `2025.2.4` (exact match)

Examples (`group_vars/all.yml`):

```yaml
intellij_edition: community
intellij_version: 2025.2.x
```

```yaml
intellij_edition: ultimate
intellij_version: 2025.2.4
```

Notes:
- Linux (`Ubuntu`, `Fedora`, `Archlinux`) supports version pinning via JetBrains release archives.
- macOS currently supports `intellij_version: latest` only.

## Usage

```bash
dotfiles -t intellij
```
