# Installation

This page contains full details for installing nimbsh, both quickly, and building from source.

## Oh-My-Nimbsh:

Use the `omn` (oh-my-nimbsh) installer to install `omn`:

```
curl -fsSL https://omn.srsxnsh.xyz/install | bash
```

Then run `omn` to install or update nimbsh.

## Nix/Nixos (`nixpkgs`):

Coming soon.


## Arch Linux (AUR):

Nimbsh is available on the AUR!

To install, simply use your preferred helper to download the `nimbsh` package.

```
yay -S nimbsh
```

## Building from Source:

One can also compile the shell from source quite easily.

### Dependencies:

The shell needs a few dependencies in order to build + compile:

* Git
* [Nim](https://nim-lang.org)
* A C compiler that works with Nim, for example GCC.

### Cloning:

Clone the repo from `https://github.com/srsxnsh/nimbsh`.

```
git clone https://github.com/srsxnsh/nimbsh ~/.nimbsh

cd ~/.nimbsh
```

### Compiling:

Simply build with `nim c`, then create a symlink to `bin`.

```
nim c nimbsh.nim

ln -sf ~/.nimbsh/nimbsh /usr/bin/nimbsh
```

### Updating:

Pull from origin and recompile:

```
cd ~/.nimbsh
git pull

nim c nimbsh.nim
```


# Starting the shell:

```
nimbsh
```

