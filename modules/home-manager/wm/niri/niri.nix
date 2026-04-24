{ config, pkgs, inputs, ... }:

{
  # 🔹 Пакет niri из твоего flake input
  home.packages = [ inputs.niri.packages.${pkgs.system}.niri ];

  # 🔹 Минимальный конфиг для niri (config.kdl)
  # Генерируется в ~/.config/niri/config.kdl
  xdg.configFile."niri/config.kdl".text = ''
    # === Базовые настройки ===
    # Автозапуск полезных утилит
    spawn "swayidle" "timeout" "300" "swaylock" "-f" "-c" "000000"
    spawn "dunst"
    spawn "wl-paste" "--type" "text" "--watch" "cliphist" "store"
    spawn "wl-paste" "--type" "image" "--watch" "cliphist" "store"
    
    # === Клавиши ===
    modifier "Super"
    
    # Базовые бинды
    bind "Super" "Return" { spawn "alacritty"; }
    bind "Super" "Q" { close-window; }
    bind "Super" "Shift" "Q" { kill; }
    bind "Super" "E" { spawn "rofi" "-show" "drun"; }
    bind "Super" "W" { spawn "firefox"; }
    
    # Переключение рабочих столов (1-9)
    bind "Super" "1" { focus-workspace 1; }
    bind "Super" "2" { focus-workspace 2; }
    bind "Super" "3" { focus-workspace 3; }
    bind "Super" "4" { focus-workspace 4; }
    bind "Super" "5" { focus-workspace 5; }
    
    # Перемещение окон между рабочими столами
    bind "Super" "Shift" "1" { move-window-to-workspace 1; }
    bind "Super" "Shift" "2" { move-window-to-workspace 2; }
    
    # Скролл-тайлинг (фишка niri)
    layout {
      center-focused-window "never"
      default-column-width { proportion 0.5; }
      gap-width 4
    }
    
    # === Индикаторы ===
    hotkey-overlay {
      skip-at-startup false  # Показывать подсказки при нажатии модификатора
    }
    
    # === Поведение окон ===
    window-resize-cursor {
      width 16
      color "#ff0000"
    }
  '';

  # 🔹 Интеграция со stylix (тема автоматически применится к конфигам)
  # Если нужно вручную подставить цвета, можно использовать:
  # ${config.lib.stylix.colors.base00} и т.д.
}
