.PHONY: build test clean

build: src/main.c
	# Prepare the output directories
	mkdir -p out/objs
	mkdir -p out/system/efi/boot

	# Compile the source code into an object file
	gcc -I/usr/include/efi -I/usr/include/efi/x86_64 -I/usr/include/efi/protocol -fno-stack-protector -fpic -fshort-wchar -mno-red-zone -Wall -DEFI_FUNCTION_WRAPPER -c src/main.c -o out/objs/main.o # -ffreestanding -fno-stack-check -maccumulate-outgoing-args

	# Link the object files against the UEFI libraries to create a shared object file and then convert it to an EFI application
	ld -nostdlib -znocombreloc -T /usr/lib/elf_x86_64_efi.lds -shared -Bsymbolic -L /usr/lib /usr/lib/crt0-efi-x86_64.o out/objs/main.o -o out/objs/bootx64.so -lefi -lgnuefi
	objcopy -j .text -j .sdata -j .data -j .rodata -j .dynamic -j .dynsym -j .rel -j .rela -j .rel.* -j .rela.* -j .reloc -O efi-app-x86_64 --subsystem=10 out/objs/bootx64.so out/system/efi/boot/bootx64.efi

out/OVMF_VARS_4M.fd: /usr/share/OVMF/OVMF_VARS_4M.fd
	mkdir -p out
	cp $< $@

test: out/OVMF_VARS_4M.fd build
	# For Fedora: qemu-system-x86_64 -bios /usr/share/edk2/ovmf/OVMF_CODE.fd -drive format=raw,file=fat:rw:./drive -display gtk,zoom-to-fit=on
	# For Ubuntu:
	qemu-system-x86_64 -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.fd -drive if=pflash,format=raw,file=out/OVMF_VARS_4M.fd --drive format=raw,file=fat:rw:./out/system -display gtk,zoom-to-fit=on

clean:
	rm -r out