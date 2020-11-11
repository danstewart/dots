# What to do
```
git clone git@github.com:danstewart/dots.git
cd dots
perl links.pl --tag1 --tag2 [--force]
```

Tags are defined in `config.jsonc`

---

## Dependencies

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

Next things to do for a fresh Fedora install  
https://gist.github.com/danstewart/6cd497ddb122ba852357a0d6538a01fb  
