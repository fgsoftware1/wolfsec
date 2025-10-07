=======
WolfSec
=======

Welcome to WolfSec, a custom Arch-based Linux distribution

Features
--------

- Based on Arch Linux
- Pre-configured for Wayland with Sway(more WMs/DEs to come)

Prerequisites
-------------

- Docker (for containerized build)
- Or an Arch-based system with necessary tools (for barebones build)

Setup with Docker (Recommended)
-------------------------------

1. Clone the repository::

    git clone https://github.com/fgsoftware1/wolfsec.git
    cd wolfsec

2. Run the container to build the ISO::

    bash run-container.sh

   The ISO will be generated in the `out/` directory.

Barebones Setup on Arch-based Distro
-------------------------------------

If you prefer to build directly on your Arch system:

1. Clone the repository::

    git clone https://github.com/yourusername/wolfsec.git
    cd wolfsec

3. Run the setup script::

    bash setup.sh

   The ISO will be generated in the `out/` directory.

Contributing
------------

Feel free to submit issues or pull requests!

License
-------

This project is licensed under the MIT License.