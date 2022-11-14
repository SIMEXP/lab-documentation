# Let's get started

The lab applies for storage space and compute time on Alliance Canada every year.
These resources are limited and have to be shared fairly across members of the lab.
Given that no member of the lab has privileged admin rights, this fairness relies on everyone adopting a clear code of conduct, and shared organization.

## Get access 
To get access to simexp resources in compute canada, create an account on https://ccdb.computecanada.ca/ and then apply for resources with CCRI `gsf-624-02

## Setup your environment

When you are new to Alliance Canada, we will ask you to run a setup script that will set data management access and give you access to utils for project management, including:

- setup ACLs for the data admin to the project and nearline folders
- add project management commands to your bash environment
- generate SSH keys if not already created, and help you set them up on Github for easier access
- configure the ssh agent and keychain to avoid typing your ssh key password each time you push to github or ssh to another server.
- configure git global variables


You can do it just once on each cluster:

```
/project/def-pbellec/share/data_admin/utils/setup_user_account.sh
```

## Add a new dataset

Datasets are stored in `~/project/(rrg|def)-pbellec/datasets`

> __IMPORTANT__ When applying, it is important that you involve the lab's data admins so they can also sign the non-sharing agreement or other nescessary documents.

If you want to add a new dataset please contact the lab's data admin (Basile and Arnaud).
