#!/usr/bin/env bash
gcc -I/usr/include/efi -I/usr/include/efi/x86_64 -I/usr/include/efi/protocol -fno-stack-protector -fpic -fshort-wchar -mno-red-zone -Wall -DEFI_FUNCTION_WRAPPER -c main.c -o main.o # -ffreestanding -fno-stack-check -maccumulate-outgoing-args
ld -nostdlib -znocombreloc -T /usr/lib/elf_x86_64_efi.lds -shared -Bsymbolic -L /usr/lib /usr/lib/crt0-efi-x86_64.o main.o -o bootx64.so -lefi -lgnuefi
objcopy -j .text -j .sdata -j .data -j .rodata -j .dynamic -j .dynsym -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc -O efi-app-x86_64 --subsystem=10 bootx64.so bootx64.efi
# mkdir drive
mv bootx64.efi drive/efi/boot
# For Fedora: qemu-system-x86_64 -bios /usr/share/edk2/ovmf/OVMF_CODE.fd -drive format=raw,file=fat:rw:./drive -display gtk,zoom-to-fit=on
# For Ubuntu:
qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -drive format=raw,file=fat:rw:./drive -display gtk,zoom-to-fit=on