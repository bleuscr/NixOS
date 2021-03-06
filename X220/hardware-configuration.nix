# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot =
  {
    loader =
    {
      systemd-boot.enable = true;
      
      grub =
      {
        version = 2;
        enable = true;
        efiSupport = true;
	device = "/dev/sda";
      };
      
      efi =
      {
	canTouchEfiVariables = true;
	efiSysMountPoint = "/boot/efi";
      };
  };
    
    initrd = 
    {
      availableKernelModules = 
      [
        "ehci_pci" 
        "ahci"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
        "sr_mod"
        "sdhci_pci"
        "ata_piix"
        "ohci_hcd"
        "usbhid"
        "f2fs"
        "btrfs"
        "ext4"
        "ntfs" 
      ];
      
      # https://bugzilla.kernel.org/show_bug.cgi?id=110941
      #kernelParams = [ "intel_pstate=no_hwp" ];
      
      kernelModules = 
      [
        "usb_storage"
        "dm_snapshot"
        "fbcon"
        "kvm-intel"
        "tp_smapi"
        "zram"
      ];
      

#boot.initrd.luks.devices."cryptboot".device = "/dev/disk/by-uuid/3057935f-ed92-471d-a65b-28efd3b5c18d";
  luks =
      {
        mitigateDMAAttacks = true;
        
        devices =
        [
          {
            preLVM = true;
	    name = "cryptboot";
            device = "/dev/disk/by-uuid/3057935f-ed92-471d-a65b-28efd3b5c18d";
          }
        ];
   
        #cryptoModules =
        #{
        #  	[ "aes" "xts" "sha256" "sha1" "cbc" ];
        #};
      };
    };
    
    extraModulePackages =
    [
      config.boot.kernelPackages.tp_smapi
    ];
  };
  
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/71d6856b-1ac5-406f-83ba-c523a35673d3";
      fsType = "f2fs";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/bb112a16-d770-4c4f-86e1-233088dfae7d";
      fsType = "f2fs";
    };

  fileSystems."/boot/efi" =
    { 
      device = "/dev/disk/by-uuid/90AC-5521";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
}
