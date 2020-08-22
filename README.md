Dotfiles
========

My configuration files made to work on a [Parabola GNU/Linux-libre](https://www.parabola.nu/) system.
Some are forked from [Luke Smith repositories](https://github.com/LukeSmithxyz).
Others from these repositories are unaltered and not pushed here.

Usage
-----

Clone this repository, make sure you have the required packages, and take the files you want to use.
An install script for packages is provided, more information below.

**Important**: some packages and options are defined as environmental variables at `.zprofile` to increase modularity and portability.
Change those accordingly.

Dependencies
------------

Some packages are assumed by the config files.
A file with tabular data about installation method, package, and description is located at `.local/share/packages.csv`.
Names and descriptions correspond to those found in a Parabola GNU/Linux-libre x64 system.
The first column indicates the install method:

* "a": [Arch User Repository (AUR)](https://wiki.archlinux.org/index.php/Arch_User_Repository)
* "g": [git](https://wiki.archlinux.org/index.php/Git).
* Any other: package manager (likely [pacman](https://wiki.archlinux.org/index.php/Pacman)).

An install script is provided for the git and package manager methods for convenience.
Due to the nature of [AUR helpers](https://wiki.archlinux.org/index.php/AUR_helpers), providing a fully automated install script for AUR packages is challenging, and probably involved a significant security or system breaking risk.
AUR packages from the list should be [manually installed](https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_and_upgrading_packages).
The installation script *may* work on `apt`-based systems.

Contributing
------------

Please Issue/Merge request feedback and fixes.

License
-------

Al my files licensed under the GPLv3.
Other files may have their own licenses.
