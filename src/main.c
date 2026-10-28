#include <efi.h> // GNU-EFI's header for the UEFI interface
#include <efilib.h> // For GNU-EFI's library of helper functions that this is linked against

EFI_STATUS EFIAPI efi_main(EFI_HANDLE ImageHandle, EFI_SYSTEM_TABLE *SystemTable) { // EFIAPI tells GCC to use Microsoft's C calling conventions rather than Unix's
    InitializeLib(ImageHandle, SystemTable);

    // Retrieve GOP (graphics output protocol)
    EFI_GRAPHICS_OUTPUT_PROTOCOL *gop = NULL;
    EFI_STATUS status = uefi_call_wrapper(SystemTable->BootServices->LocateProtocol, 3, &GraphicsOutputProtocol, NULL, (VOID **) &gop);

    // Using GOP, query information about the current video mode
    UINTN size;
    EFI_GRAPHICS_OUTPUT_MODE_INFORMATION *info;
    status = uefi_call_wrapper(gop->QueryMode, 4, gop, gop->Mode->Mode, &size, &info);

    UINT8 *framebuffer = (UINT8 *)(UINTN) gop->Mode->FrameBufferBase;

    // Fill the screen with a color
    for (int i = 0; i < info->HorizontalResolution * info->VerticalResolution; i++) {
        framebuffer[i * 4] = 0xff;
        framebuffer[i * 4 + 1] = 0x00;
        framebuffer[i * 4 + 2] = 0x00;
        framebuffer[i * 4 + 3] = 0x00;
    }


    while (true);
    return EFI_SUCCESS;
}