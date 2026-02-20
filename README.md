![nimbsh logo](assets/logo_transparent.svg)
___________
[![AUR version](https://img.shields.io/aur/version/nimbsh)](https://aur.archlinux.org/packages/nimbsh) 


## A Simple Shell Written in Nim.

Nimbsh is a simple OS shell written for UNIX or GNU/Linux based operating systems.

The entire main shell was built in Nim, with all documentation being written in Markdown and shipped using the Docsify framework.

[Documentation](https://nimbsh.srsxnsh.xyz) | [AUR](https://aur.archlinux.org/packages/nimbsh)

___________

## Quick Install

To quickly start using nimbsh, use the `omn` installer (AUR and source compilation instructions also available, `nixpkgs` package coming in the next version):

```
curl -fsSL https://omn.srsxnsh.xyz/install  | bash
```

(You will not be able to run the installed program on Nixos due to using `/usr/bin`, you can run the file direct with bash instead, and run the shell with `/usr/bin/nimbsh`)

A dedicated `nixpkgs` port is on it's way. Nimbsh is registered as `nimbsh` on the AUR.

Then run `omn` to update or install nimbsh.

Run `nimbsh` to enter the shell.

Full build instructions and other more advanced options can all be found in the [docs](https://nimbsh.srsxnsh.xyz/#/install).
