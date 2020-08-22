from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, extension, widget


def get_key_bindings(
    mod_key: str,
    terminal: str,
    launcher_sys: str,
    launcher_www: str,
    display_locker: str,
) -> list:
    """Make key bindings"""

    return [
        ### QTile management
        # Restart qtile
        Key([mod_key, "control"], "r", lazy.restart()),
        # Exit qtile
        Key([mod_key, "control"], "q", lazy.shutdown()),
        ### Stack navigation
        # Change pane focus
        Key(frozenset({mod_key}), "j", lazy.layout.down()),
        Key(frozenset({mod_key}), "k", lazy.layout.up()),
        ### Stack management
        # Close window
        Key(frozenset({mod_key}), "q", lazy.window.kill()),
        # Shift stack position
        Key(frozenset({mod_key, "shift"}), "h", lazy.layout.swap_left()),
        Key(frozenset({mod_key, "shift"}), "l", lazy.layout.swap_right()),
        Key(frozenset({mod_key, "shift"}), "j", lazy.layout.shuffle_down()),
        Key(frozenset({mod_key, "shift"}), "k", lazy.layout.shuffle_up()),
        # Increase main size
        Key(frozenset({mod_key}), "l", lazy.layout.grow_main()),
        # Decrease main size
        Key(frozenset({mod_key}), "h", lazy.layout.shrink_main()),
        # Swap main and stack panes
        Key(frozenset({mod_key}), "space", lazy.layout.swap_main()),
        # Toggle fullscreen
        Key(frozenset({mod_key}), "f", lazy.window.toggle_fullscreen()),
        ### Layout management
        # Toggle between different layouts
        Key(frozenset({mod_key}), "Tab", lazy.next_layout()),
        ### Screen management
        # Move to next screen
        Key(frozenset({mod_key}), "period", lazy.next_screen()),
        # Move to previous screen
        Key(frozenset({mod_key}), "comma", lazy.next_screen()),
        # Lock screen
        Key(frozenset({mod_key}), "x", lazy.spawn(display_locker)),
        ### Launch programs
        # Terminal emulator
        Key(frozenset({mod_key}), "Return", lazy.spawn(terminal)),
        # Key(frozenset({mod_key})], "Return", lazy.spawn(terminal + " -e tmux")),  # With tmux
        # Launcher
        Key(frozenset({mod_key}), "d", lazy.spawn(launcher_sys)),
        Key(frozenset({mod_key}), "w", lazy.spawn(launcher_www)),
    ]
