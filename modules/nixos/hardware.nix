# Часть настроек меняется в xserver.nix и network.nix
# Некоторые настройки под конкретное железо https://github.com/NixOS/nixos-hardware

{ pkgs, ... }: {
 hardware = { # Параметры для 24.05 и unstable могут сильно отличаться

  graphics = { # hardware.opengl переименован в hardware.graphics в unstable ветке
    enable = true;
    enable32Bit = true; # install 32-bit drivers for 32-bit applications (such as Wine).
    extraPackages = with pkgs; [
      libva # VAAPI (Video Acceleration API)
      # 🔥 УДАЛЕНО: rocmPackages.clr.icd — не нужен для NVIDIA, CUDA идёт через драйвер
    ];
  };

  opentabletdriver.enable = true; # Установить, настроить и добавить в автозапуск otd

  keyboard.qmk.enable = true; # Еnable non-root access to the firmware of QMK keyboards.

  # Список пакетов-драйверов, которые будут активированы лишь при нахождении подходящего оборудования
  # firmware = with pkgs; [];

  # Мало раскомментить. Надо настроить при необходимости
  # fancontrol = {};

  # В стоке false. Не понял зачем надо, сохранил из интереса
  # enableAllFirmware = true;

  # Whether to enable firmware with a license allowing redistribution.
  # enableRedistributableFirmware = true;

  # Разные способы управлять яркостью экрана и подсветки для юзеров в группе video
  # Подробности тут https://wiki.archlinux.org/title/Backlight#Backlight_utilities
  # brillo.enable = true;
  # acpilight.enable = true;

 };

 # HIP (AMD) — 🔥 УДАЛЕНО, не нужно для NVIDIA
 # systemd.tmpfiles.rules = [ # Legacy
 #  "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
 # ];

 # Для AMD существует два драйвера Vulkan — 🔥 УДАЛЕНО, не нужно для NVIDIA
 # environment.variables.AMD_VULKAN_ICD = "RADV";
}
