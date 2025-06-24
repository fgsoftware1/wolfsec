if status --is-interactive; and not set -q WAYLAND_DISPLAY
    exec sway
end
