from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, extension, widget


def get_key_bindings(mod_key: str, terminal: str, launcher: str, display_locker: str) -> list:
    """Make key bindings"""

    return [
        # Restart qtile
        Key([mod_key, "control"], "r", lazy.restart()),
        # Focus next window
        Key(frozenset({mod_key}), "j", lazy.layout.down()),
        # Focus previous window
        Key(frozenset({mod_key}), "k", lazy.layout.up()),
        # Shift stack position
        Key(frozenset({mod_key, "shift"}), "h", lazy.layout.swap_left()),
        Key(frozenset({mod_key, "shift"}), "l", lazy.layout.swap_right()),
        Key(frozenset({mod_key, "shift"}), "j", lazy.layout.shuffle_down()),
        Key(frozenset({mod_key, "shift"}), "k", lazy.layout.shuffle_up()),
        # Increase main size
        Key(frozenset({mod_key}), "l", lazy.layout.grow_main()),
        # Decrease main size
        Key(frozenset({mod_key}), "h", lazy.layout.shrink_main()),
        #Key(frozenset({mod_key}), "n", lazy.layout.normalize()), # not working
        #Key(frozenset({mod_key}), "o", lazy.layout.maximize()),
        Key(frozenset({mod_key}), "space", lazy.layout.swap_main()),

        # # Switch window focus to other pane(s) of stack
        # Key([mod], "space", lazy.layout.next()),

        # # Swap panes of split stack
        # Key([mod, "shift"], "space", lazy.layout.rotate()),

        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        #Key([mod_key, "shift"], "Return", lazy.layout.toggle_split()),
        # Launch terminal emulator
        Key(frozenset({mod_key}), "Return", lazy.spawn(terminal)),
        # Key([mod], "Return", lazy.spawn(TERM + " -e tmux")),  # With tmux
        # Launch launcher
        Key(frozenset({mod_key}), "d", lazy.spawn(launcher)),

        # Toggle between different layouts
        Key(frozenset({mod_key}), "Tab", lazy.next_layout()),
        # Toggle fullscreen
        Key(frozenset({mod_key}), "f", lazy.window.toggle_fullscreen()),
        # Close window
        Key(frozenset({mod_key}), "q", lazy.window.kill()),
        # Move to next screen
        Key(frozenset({mod_key}), "period", lazy.next_screen()),
        # Move to previous screen
        Key(frozenset({mod_key}), "comma", lazy.next_screen()),
        # Exit qtile
        Key([mod_key, "control"], "q", lazy.shutdown()),
        # Lock screen
        Key(frozenset({mod_key}), "x", lazy.spawn(display_locker)),
        # cycle to previous group
        #Key([mod], "u", lazy.group.prev_group().toscreen()),
        # cycle to next group
        #Key([mod], "m", lazy.group.next_group()),
    ]

