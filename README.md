# What to do
```
git clone git@github.com:danstewart/dots.git
cd dots
bash init.sh
perl links.pl [--server|--desktop] [--force]
```

Tags are defined in `config.jsonc`

---

## Dependencies
The only dependency that isn't already provided on most systems is the perl JSON.pm module.  
The `init.sh` script will handle this for you on Ubuntu, Fedora and Arch.  
```
# Fedora
sudo dnf install perl-JSON

# Ubuntu
sudo apt install libjson-perl

# Arch
sudo pacman -S perl-json
```

---

## config.jsonc

This file has a list of tags and the files they should link.  
The key is the source file within /config and the value is either the target to link or an object.  

Tags can include other tags by having "&include": [ "otherTag" ]  
$HOME will automatically be replaced  

If the file maps to an object then you can specify  
- `src`: The path of the src file (Defaults to the key if not specified)
- `target`: The target to link to
- `andThen`: Optional shell command to run after linking
- `cond`: Optional shell condition (automatically wrapped in [])
- `noForce`: Overrides --force flag to never overwrite

---

# Fresh Install

See [docs](https://github.com/danstewart/dots/tree/main/docs) for next steps for a fresh system install.
