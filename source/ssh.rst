Secure Shell connection
=======================

The Secure Shell (ssh) protocol is a software package that uses encryption to secure the connection between a client and a server.
It is the standard way of communicating to any data center.
`Openssh <https://www.openssh.com/>`_ is the most widely known open source implementation of the ``ssh`` protocol
and this is what we will be using for this tutorial.
You will not need to install anything since it is already installed by default on many Linux systems.

Pre-requisites
::::::::::::::
* Basics use of Linux (cmd line)

What will you learn ?
:::::::::::::::::::::
* Establish secure connection between your computer and a server

The importance of key-pairs
:::::::::::::::::::::::::::

The passwords used to authentificate are called *encryption key-pair* : there is a public one (used to prove ownership) and a private one (to encrypt data).

``ssh`` uses `public-key cryptography <https://en.wikipedia.org/wiki/Public-key_cryptography>`_, with the idea that a mathematical 
function can encode information in the form of a ``string``. The passwords used to authentificate are called *encryption key-pair*: 
there is a public one (used to prove ownership) and a private one (to encrypt data).
Just the owner of the private key can decode this information, otherwise it would require a hugh amount of compute power to find the private key (prime factors).

Many application derives from this algorithm :

* Connect to your mail acount
* Pay via your credit card
* Paying games online
* Blockchain technology (mostly hashing algos)

Hand's on
:::::::::

Create encription keys
----------------------

1.  Open a prompt with ``ctrl+alt+t``
2.  Create your keys

    .. code:: bash

        ssh-keygen -t rsa

3.  Press enter at each step
4.  Your private key `~/.ssh/id_rsa` and public key `~/.ssh/id_rsa.pub` are now on your cmputer, you can open them to see how they look like.

    .. code:: bash

        cat ~/.ssh/id_rsa.pub

    It should look like:

    .. literalinclude:: files/id_rsa.pub
        :linenos:

    .. literalinclude:: files/id_rsa
        :linenos:

.. warning::
    You should NEVER share your private key ``id_rsa`` to anyone, nor leaving it on a remote server. As mentionned before, the private key allows to decode
    the informations you are sending. Avoid sharing the public key ``id_rsa.pub`` if unnecessary, hackers could use it to identify you.

Connect to a server
-------------------

1.  We will try to connect to ``stark``,

    .. code:: bash

        ssh <you_username>@stark

    .. note::
        When using ``ssh``, it will automatically use your key under ``~/.ssh``. You can specify a key with ``-i /path/to/my/key``.

2.  You can now type your UNF password.

3.  On your computer, you will see a new file ``~/.ssh/known_hosts``. It contains all the server that you visited with ``ssh``.

.. note::
    You can also connect to a server using its public IP in the form XXX.XX.XX.XX

TIPS
::::

Automatic authentification
--------------------------

Every time you login to a server, you will be asked for the password if available.
To avoid that, you can add your public key so the server doesn't need you password to prove ownership.

1. Send your public key to the server,

    .. code:: bash

        ssh-copy-id <you_username>@stark

2.  When you will log-in to the server, you will be asked for your password a last time.
    Whenever you log-in again, it should not ask for it.

    .. code:: bash

        ssh <your_username>@stark

3.  You can check the file `~/.ssh/authorized_keys` on the server, it should match your public key ``id_rsa.pub``.

Easy ssh
--------

It can be cumbersome to type the ``ssh`` command if you have lot of arguments.
For example, let's say you want to set-up port forwarding on a specific server with a specific user, you would need to type:

.. code-block:: bash

    ssh -L 1234:localhost:80 -i ~/.ssh/root/id_root root@server2.domain.cloud.com

It is possible to put all the options inside a single file in ``~/.ssh/config``, and call ``ssh`` with a single command.
For example, you would call the previous command with just:

.. code-block:: bash

    ssh server1

With this ``~/.ssh/config``:

    .. literalinclude:: files/config
        :linenos:

Easy ssh

Questions ?
:::::::::::

If you have any issues with ssh, you can ask on the SIMEXP lab slack in ``#neuroinformatics`` channel!