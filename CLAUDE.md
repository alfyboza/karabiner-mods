# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## About This Project

This is a collection of personal Karabiner-Elements complex modifications that customize keyboard behavior on macOS. The project contains JSON configuration files that define key mappings and an installation script to deploy them.

## Development Commands

### Installation
```bash
./scripts/install.sh [--debug] [--dry-run]
```
- Installs modifications by creating symlinks in `~/.config/karabiner/assets/complex_modifications/`
- Use `--dry-run` to preview changes without making them
- Use `--debug` to enable verbose output

## Architecture

### Project Structure
- `modifications/` - Contains JSON files defining Karabiner-Elements complex modifications
- `scripts/install.sh` - Installation script that creates symlinks to modifications

### Karabiner Modification Format
Each JSON file in `modifications/` follows the Karabiner-Elements complex modification schema:
- `title` - Human-readable name for the modification set
- `rules[]` - Array of modification rules
- `rules[].description` - Description of what the rule does
- `rules[].manipulators[]` - Array of key manipulation definitions
- `manipulators[].from` - Source key configuration
- `manipulators[].to` - Target key configuration
- `manipulators[].conditions[]` - Optional conditions (e.g., device filters)

### Key Concepts
- Modifications are device-aware and can exclude specific devices using `device_unless` conditions
- The `vendor_id: 1452` condition excludes Apple keyboards
- Modifications support optional modifier keys (shift, command, etc.)
- The install script creates symlinks rather than copying files for easier development

## Working with Modifications

When adding new modifications:
1. Create a new JSON file in `modifications/` following the existing schema
2. Test the modification format matches Karabiner-Elements requirements
3. Use the install script to deploy and test the changes
4. Modifications are automatically picked up by Karabiner-Elements when symlinked