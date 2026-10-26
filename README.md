# os
The name isn't that original because this is simply the fruit of my interest in operating systems. Learning as I go, I intend to develop an OS targeting relatively modern hardware and standards, starting with x86-64 UEFI systems.

## Goals
<!-- Emojis are wider than standard monospaced fonts, so instead use their codepoints to display nicely in code editors -->
| Goal                                          | Status    |
| ---                                           | ---       |
| UEFI application that prints "Hello, world!"  | &#x2705;  |
| Clean up and document code                    | &#x231B;  |

## Build environment
| Software  | Ubuntu package(s) (tested via WSL)    | Fedora package(s)             |
| ---       | ---                                   | ---                           |
| gcc       | `gcc`                                 | `gcc`                         |
| GNU-EFI   | `gnu-efi`                             | `gnu-efi`, `gnu-efi-devel`    |
| QEMU      | `qemu-system`                         | `qemu-kvm`                    |
| OVMF      | `ovmf`                                | `edk2-ovmf`                   |

## References
- https://www.rodsbooks.com/efi-programming/hello.html
- https://wiki.osdev.org/GNU-EFI