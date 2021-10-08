Make a python project from zero
===============================

It is most likely that the project you are currently working on heavily depends on existing softwares, whether from the lab or not.
There is also a high chance that it will be published and/or re-used internally, this is why it is important to have good `python <https://www.python.org/>`_ coding practices.

.. image:: img/o5fy9.gif
    :width: 600px

Pre-requisites
::::::::::::::
* Our tutorial on :doc:`unix_intro`

What will you learn ?
:::::::::::::::::::::
* Using Visual Studio code IDE
* Organize your python project
* Run basic vscode plugins on your code

Hand's on
:::::::::

Ubuntu 18 is the preferrable OS
-------------------------------

It is important to share a common devlopement environment, because it reduces potential source of bugs when working with the lab tools.
Also, most of the neuroinformatic team and students heavily rely on the same OS, so getting help will be much easier.

That is why we highly recomend you to change your OS to a linux based one like `ubuntu <https://ubuntu.com/>`_.
If you can't, then you can use the lab computers or continue with your original OS at your own risk.

Visual Studio code IDE
----------------------

`Visual Studio Code <https://code.visualstudio.com/>`_ is a verry popular IDE whether in industry or academia, supported in windows, macOS and of course linux.
We invite you to install it by running the following commands on your computer:

.. code:: bash

  sudo apt update
  sudo apt install software-properties-common apt-transport-https wget
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  sudo apt update
  sudo apt install code

We will now install the python vscode plugin:

.. code:: bash

  code --install-extension ms-python.python
  code --install-extension ms-python.vscode-pylance

And the auto-formatting tool:

.. code:: bash

  python3 -m pip install autopep8

Cookiecutter template
---------------------

`Cookiecutter <https://github.com/cookiecutter/cookiecutter>`_ is a little command line utility to help you initialize a (python) project.

If you already initialized a project on Béluga with :doc:`project.md`, you can clone your github repo and skip this section.
If that is not the case, we will use `our lab cookiecutter template 
<https://simexp-documentation.readthedocs.io/en/latest/data/project.html#starting-a-project>`_ to initialize a new project:

.. code:: bash

  mkdir /PATH/TO/MY/PROJECT
  cookiecutter -o /PATH/TO/MY/PROJECT -f  https://github.com/SIMEXP/cookiecutter-data-science
  
Overall the whole repository layout should look like this:

.. code:: bash

  ├── LICENSE
  ├── Makefile           <- Makefile with commands like `make data` or `make train`
  ├── README.md          <- The top-level README for developers using this project.
  ├── data               <- Where the dataset will be installed
  ├── docs               <- A default Sphinx project; see sphinx-doc.org for details
  │
  ├── models             <- Trained and serialized models, model predictions, or model summaries
  │
  ├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
  │                         the creator's initials, and a short `-` delimited description, e.g.
  │                         `1.0-jqp-initial-data-exploration`.
  │
  ├── references         <- Data dictionaries, manuals, and all other explanatory materials.
  │
  ├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
  │   └── figures        <- Generated graphics and figures to be used in reporting
  │
  ├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g.
  │                         generated with `pip freeze > requirements.txt`
  │
  ├── setup.py           <- makes project pip installable (pip install -e .) so src can be imported
  ├── src                <- Source code for use in this project.
  │   ├── __init__.py    <- Makes src a Python module
  │   │
  │   ├── data           <- Scripts to download or generate data
  │   │   └── make_dataset.py
  │   │
  │   ├── features       <- Scripts to turn raw data into features for modeling
  │   │   └── build_features.py
  │   │
  │   ├── models         <- Scripts to train models and then use trained models to make
  │   │   │                 predictions
  │   │   ├── predict_model.py
  │   │   └── train_model.py
  │   │
  │   └── visualization  <- Scripts to create exploratory and results oriented visualizations
  │       └── visualize.py
  │
  └── tox.ini            <- tox file with settings for running tox; see tox.testrun.org

Python code formating
---------------------

You are now ready to dive into the development of your project!
Go to your project directory and open vscode:

.. code:: bash

  cd /PATH/TO/MY/PROJECT
  code .

Let's make sure that your auto-formatter is enabled clicking on ``File > Preferences > Settings`` and select ``autopep8`` after typing ``python formatting provider``.
Search now ``format on save`` and enable it.

You can start populating the repository based on your need, keep in mind that you should fit your files with the current layout.

.. note ::
  We advice you to enable the dark mode in File > Preferences > Color Theme.
  Your eyes will be gratefull. :)

You will realize that after saving your file, all the content will automatically auto-format ! That should save you lot of times, instead of formatting code yourself.

Linting your code
-----------------

Where auto-formatter helps you re-format your code easilly, a linter will help you re-organize your code
We will again check if you enabled linting.
Type ``CTRL+SHIFT+p`` to open a dialog and type ``python enable linting`` to enable it.

Other optionnal advices
-----------------------

What we just saw are the strict minimal good practices when writing python code.
Additionnally, you would like to add tests with `pytest <https://docs.pytest.org/en/6.2.x/>`_ (in the ``src/test`` folder).
A good documentation on how to run your code in the ``README.md`` file is also really apreciated.
Finally, for others to be able to reproduce your experiments, it is important to make a good `requirement file <https://pip.pypa.io/en/stable/user_guide/#requirements-files>`_ to list the software dependencies.

To go further
:::::::::::::

If you have difficulties running this tutorial, or you want to learn more about python, you should definitively check the `software-carpentry courses <https://software-carpentry.org/lessons/>`_.
Check `this post <https://astrobites.org/2020/10/23/towards-better-research-code-and-software/>`_, a good guide for better research code.


Questions ?
:::::::::::

If you have any issues using the UNIX command line, don’t hesitate to ask your questions on the SIMEXP lab slack in #python channel!
