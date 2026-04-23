# Часть настроек меняется в xserver.nix и network.nix
# Некоторые настройки под конкретное железо https://github.com/NixOS/nixos-hardware

{ pkgs, config, ... }: {
  hardware = { # Параметры для 24.05 и unstable могут сильно отличаться
    
    graphics = { # hardware.opengl переименован в hardware.graphics в unstable ветке
      enable = true;
      enable32Bit = true; # install 32-bit drivers for 32-bit applications (such as Wine).
      extraPackages = with pkgs; [
        libva # VAAPI (Video Acceleration API)
      ];
    };

    nvidia = {
      # 🔹 Обязательно для >= 560
      open = false;
      
      # 🔹 Явно выбери НЕ-broken ветку:
      # Попробуй production (обычно стабильнее, чем stable в некоторых каналах)
      package = config.boot.kernelPackages.nvidiaPackages.production;
      
      # 🔹 Если production тоже сломан — попробуй:
      # package = config.boot.kernelPackages.nvidiaPackages.legacy_470;  # для старых GPU
      # package = config.boot.kernelPackages.nvidiaPackages.beta;  # для новых, если другие не работают
      
      # 🔹 Опционально: настройки режима
      modesetting.enable = true;
      nvidiaSettings = true;
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
  
  # ... существующие настройки ...

  # 🔹 Обязательная настройка для NVIDIA драйверов >= 560
  # false = проприетарные модули (стабильно, рекомендуется для большинства)
  # true = открытые модули (только для GPU Turing и новее: RTX 20xx+, GTX 16xx+) 
  # HIP
  # Most software has the HIP libraries hard-coded. You can work around it on NixOS by using:
  # systemd.tmpfiles.rules = [ # Legacy
  #   "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  # ];

  # Для AMD существует два драйвера Vulkan
  # Один официальный от AMD - amdvlk
  # Второй начат сообществом и сейчас поддерживается Valve - radv
  # В разных ситуациях разные драйверы будут лучше работать
  # В некоторых играх лучше работает radv, в некоторых amdvlk
  # Штука ниже не обязательна для работы radv, но я сохранил
  # environment.variables.AMD_VULKAN_ICD = "RADV";
}
