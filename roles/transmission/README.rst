===================
Transmission README
===================

Transmission is a set of lightweight BitTorrent clients (in GUI, CLI and daemon form).  All these incarnations feature a very simple and intuitive interface, on top on an efficient, cross-platform backend: https://transmissionbt.com

Transmission is intended to download KA Lite content to Internet-in-a-Box (IIAB) from places like http://pantry.learningequality.org/downloads/ka-lite/0.17/content/ — and also to seed content, assisting others.

For example, once KA Lite videos and thumbnails are confirmed downloaded, copy them (carefully!) from ``/library/transmission`` into ``/library/ka-lite/content`` as outlined by "KA Lite Administration: What tips & tricks exist?" at http://FAQ.IIAB.IO

Caution
-------

Usage of Transmission consumes significant Internet data and system resources.
Caveat emptor!  (That's Latin for "Buyer Beware")

Using It
--------

Install Transmission by setting 'transmission_install' and 'transmission_enabled' to True in /etc/iiab/local_vars.yml and then running::

  cd /opt/iiab/iiab
  ./runrole transmission
  ./iiab-network

Or if you prefer a complete reinstall of IIAB::

  cd /opt/iiab/iiab
  ./iiab-install --reinstall
  
Login to Transmission's web interface http://box:9091 using administrative account::

  Username: Admin
  Password: changeme

Alternatively, you can run ``transmission-remote`` at the command-line.

Configuration
-------------

Configure Transmission using its web interface: http://box:9091

More settings can be changed within '/etc/transmission-daemon/settings.json' if you first ensure that the transmission-daemon.service is stopped::

  systemctl stop transmission-daemon

Then edit the file::

  nano /etc/transmission-daemon/settings.json

Here are some short explanations, as to what those 70+ variables mean: https://github.com/transmission/transmission/wiki/Editing-Configuration-Files

After saving your changes in settings.json, restart Transmission by running::

  systemctl restart transmission-daemon

Adding Torrents
---------------

Transmission can facilitate provisioning content onto your IIAB, e.g. by adding thousands of KA Lite videos from places like: http://pantry.learningequality.org/downloads/ka-lite/0.17/content/

Please read the lettered instructions (A, B, C, D) in /etc/iiab/local_vars.yml and "KA Lite Administration: What tips & tricks exist?" at http://FAQ.IIAB.IO outlining how to use Transmission to download and then install KA Lite content.

You can also download other torrents using Transmission's web interface, or by typing 'transmission-remote' at the command-line::

  transmission-remote -a <path_to_the.torrent>

Known Issues
------------

* Default Transmission user/group may need fixing (https://github.com/transmission/transmission/issues/537).  You can set Ansible variables 'transmission_user' and 'transmission_group' e.g. in /opt/iiab/iiab/roles/transmission/defaults/main.yml (you might need 'User=' and 'Group=' in systemd unit file /lib/systemd/system/transmission-daemon.service — both might need to be set to 'debian-transmission' — if so 'systemctl daemon-reload' then 'systemctl restart transmission-daemon').

* Random Ports: Currently it is not possible to use random ports in the range 49152-65535.  It is difficult to open multiple ports in IIAB's iptables-based firewall.

Troubleshooting
---------------

Verify that transmission-daemon is running::

  systemctl status transmission-daemon

Re-check that Transmission's settings are correct, while following the instructions above, under 'Configuration'::

  /etc/transmission-daemon/settings.json
