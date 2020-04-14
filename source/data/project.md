# project management

To help you to get organize, as well as internal and external collaborator to help and contribute to your project, we ask lab members to use a project template.
To use the commands below, you have to first setup your account (TODO: link).

## Starting a project

You can create as many project as you want

1. Create a project dir and a corresponding python virtual environment

```
mkproject <my_new_project_name>
```

2. initialize the project architecture from the recommended template using cookiecutter
```
cookiecutter -o $PROJECT_HOME -f  https://github.com/drivendata/cookiecutter-data-science
project_name [project_name]: <my_new_project_name>
repo_name [my_new_project_name]:    
author_name [Your name (or your organization/company/team)]: <SIMEXP|courtois-neuromod>
description [A short description of the project.]: My cool project
Select open_source_license:
1 - MIT
2 - BSD-3-Clause
3 - No license file
Choose from 1, 2, 3 [1]: 1
s3_bucket [[OPTIONAL] your-bucket-for-syncing-data (do not include 's3://')]:
aws_profile [default]:
Select python_interpreter:
1 - python3
2 - python
Choose from 1, 2 [1]:
```

The project directory now contains a number of directory and files that will help you organize your project.

An auto generated README file contains a description of the data structure and how to organize your file in it.

Here is what it looks like

```
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
```

3. Link that project dir to a github repository

Go to the github organization where you want to host that project (SIMEXP or courtois-neuromod for instance).

Create a new repository named <my_new_project_name>, copy the ssh URL on the right side (TODO: screenshot).

Then within the project dir on the cluster, save all the changes and link and sync to the github repo as the origin remote, eg.

```
datalad create -f
datalad save
datalad siblings -s origin --url git@github.com:SIMEXP/<my_new_project_name>.git add
# or datalad siblings -s origin --url git@github.com:courtois-neuromod/<my_new_project_name>.git add
datalad publish --to origin
```

Voilà! Your project on the cluster is linked and synced to the github repo.

Datalad will allow you to version large files in your project that cannot live within git.
Important: these large files are not transferred to github, so do not delete your project directory unless you really know what you are doing.

### Returning to work on your project

When logging out and login back to the cluster, you will exit the project you are working on.
You can return to that project, moving to the project dir and loading the corresponding virtual environment using.

```
workon <my_new_project_name>
```

Easy-peasy no?

### Migrating an existing project to another cluster

TODO: install with ssh from the other cluster, to allow migrating large files.

## Using pre-installed dataset in your project

You can list the existing datasets with `lsdatasets`.

If a dataset you want to use is not there, ask the data admins of the lab to install it. TODO:link to procedure

A dataset can have multiple version: you can list the version with: `showdataset <dataset_name>` .

Once you activated the project using `workon <my_project>`, you can add datasets from the one listed to your project using.
`use_dataset <dataset_name> <version>` TODO: write the command/alias for datalad install reckless as a subdataset in the current PROJECT_DIR/data/ and checkout tag.

The dataset is now installed in the `data` directory of the current project directory.

## keeping packages in sync
