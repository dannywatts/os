#include <efi.h> // GNU-EFI's header for the UEFI interface
#include <efilib.h> // For GNU-EFI's library of helper functions that this is linked against

EFI_STATUS EFIAPI efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) { // EFIAPI tells GCC to use Microsoft's C calling conventions rather than Unix's
    InitializeLib(ImageHandle, SystemTable);

    Print(L"Hello, world!\n");
    while (true);

    return EFI_SUCCESS;
}