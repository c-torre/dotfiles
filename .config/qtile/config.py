# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, extension, widget

from typing import List  # noqa: F401

import key_bindings

# General configuration
NUM_SCREENS = 2

# Default programs
try:
    TERMINAL = os.getenv("TERMINAL")
except:
    TERMINAL = "xterm-256color"
LAUNCHER = "rofi -show run"
DISPLAY_LOCKER = "slock"

# Key bindings configuration
MOD_KEY = "mod4"  # Super key

keys = key_bindings.get_key_bindings(MOD_KEY, TERMINAL, LAUNCHER, DISPLAY_LOCKER)


def make_groups_and_keybindings() -> tuple:
    """Make groups and their respective keybindings"""

    groups = tuple(Group(str(i)) for i in range(1, 10))

    for group in groups:
        keys.extend([
            # mod1 + letter of group = switch to group
            Key(frozenset({MOD_KEY}), group.name, lazy.group[group.name].toscreen()),
            # mod1 + shift + letter of group = switch to & move focused window to group
            # Key([mod, "shift"], group.name, lazy.window.togroup(group.name, switch_group=True)),
            # Or, use below if you prefer not to switch to that group.
            # mod1 + shift + letter of group = move focused window to group
            Key(frozenset({MOD_KEY, "shift"}), group.name, lazy.window.togroup(group.name)),
        ])

    return groups


groups = make_groups_and_keybindings()


def get_layout_defaults() -> dict:
    """Make default settings for layouts"""

    return dict(
        border_focus="#ffffff",  # White border
        margin=5,  # Useless gaps size
        new_at_current=True,  # Open new pane at current stack
        ratio=0.55,  # Main pane stack proportion
        max_ratio=(max_:=0.8),
        min_ratio=1 - max_,
)

def get_layouts() -> tuple:
    """Enable xmonad/dwm-like horizontal and vertical stack"""

    return (
        # layout.Stack(num_stacks=2),
        # Try more layouts by unleashing below layouts.
        # layout.Bsp(),
        # layout.Columns(),
        # layout.Matrix(),
        layout.MonadTall(
            **get_layout_defaults()
        ),
        layout.MonadWide(
            **get_layout_defaults()
        ),
        # layout.Max(),
        # layout.RatioTile(),
        # layout.Tile(),
        # layout.TreeTab(),
        # layout.VerticalTile(),
        # layout.Zoomy(),
    )


layouts = get_layouts()


def get_widget_defaults() -> dict:
    """Get widget default settings"""

    return dict(
        font='sans',
        fontsize=12,
        padding=3,
    )


extension_defaults = get_widget_defaults()


def get_screen(linewidth, padding):
    return Screen(
        top=bar.Bar(
            [
                # Bar left anchor
                widget.Sep(
                    linewidth=linewidth, padding=padding
                ),
                widget.GroupBox(
                    hide_unused=True
                ),
                widget.Sep(
                    linewidth=linewidth, padding=padding
                ),
                widget.WindowName(
                ),
                # Bar right anchor
                widget.Systray(
                    icon_size=15
                ),
                widget.Sep(
                    linewidth=linewidth, padding=padding
                ),
                widget.Clock(
                    format='%a %d %b %H:%M'
                ),
                widget.Sep(
                    linewidth=linewidth, padding=padding
                ),
                widget.TextBox(
                    text="?",
                    mouse_callbacks={
                        "Button1": lambda qtile: qtile.cmd_spawn("show-manual")
                    },
                ),
               #widget.QuickExit(),
            ],
            24,
        ),
    )

screens = tuple(get_screen(linewidth=0, padding=7) for _ in range(NUM_SCREENS))
#screens = tuple(Screen() for _ in range(NUM_SCREENS))  # No bar configuration

# Drag floating layouts.
mouse = [
    Drag(frozenset({MOD_KEY}), "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag(frozenset({MOD_KEY}), "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click(frozenset({MOD_KEY}), "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
