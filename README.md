# github_provider_kitchen
This repo contains kitchen test code that will test terraform github provider

# What is this repo for

This repo contains terraform code that will create a github repository in a organization of your choosing.

# Why use this repo

This could be used to understand how to use github provider in terraform and how to test your code with kitchen.

# How to use this repo

### Before using this code there are some prerequisites that need to be fulfilled.

* Terraform installed

You can download Terraform from this [link](https://www.terraform.io/downloads.html)

* Ruby >= 2.4, < 2.7

Ruby can be installed with `brew install ruby`

* Bundler installed

Bundler can be installed with `gem install bundler`

### Steps to use this code

* Download this repository to you local workstation

```
git clone git@github.com:yordanivh/github_provider_kitchen
```

* Change to the downloaded repo

```
cd github_provider_kitchen
```

* In the Gemfile you can see that we will use `kitchen-terraform` gem, there we need to download it for this environment with the following command

```
bundle install
```
* create a `terraform.tfvars` file to put in the values of the variables

```
touch terraform.tfvars
```

* put the following infromation there - Information on how to generate your access Token [here](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line). Make sure your token has rights to create and delete repositories in your organization.

```
github_token = "Your_personal_access_token"
github_organization = "Your_organization_name"
github_repo_name = "Your_desired_repo_name"
```

* You also need to edit the control for the kitchen test.

```
vim test/integration/default/default_test.rb
```
The URL needs to be changed to reflect you personal organization and repository names

```
 describe http('https://github.com/<Your_organization_name>/<Your_desired_repo_name>') do
```
 Save and exit the file
 
 ```
 :wq! + Enter
 ```

* Now we can perform the test. First step is to create the resource we will test.

```
bundle exec kitchen converge
```

* You can expect the output of the command to look something like this.

```
❯ bundle exec kitchen converge
-----> Starting Test Kitchen (v2.4.0)
-----> Converging <default-github>...
$$$$$$ Verifying the Terraform client version is in the supported interval of >= 0.11.4, < 0.13.0...
$$$$$$ Reading the Terraform client version...
       Terraform v0.12.23
       + provider.github v2.6.1
       
       Your version of Terraform is out of date! The latest version
       is 0.12.24. You can update by downloading from https://www.terraform.io/downloads.html
$$$$$$ Finished reading the Terraform client version.
$$$$$$ Finished verifying the Terraform client version.
$$$$$$ Selecting the kitchen-terraform-default-github Terraform workspace...
$$$$$$ Finished selecting the kitchen-terraform-default-github Terraform workspace.
$$$$$$ Downloading the modules needed for the Terraform configuration...
$$$$$$ Finished downloading the modules needed for the Terraform configuration.
$$$$$$ Validating the Terraform configuration files...
       
       Warning: The -var and -var-file flags are not used in validate. Setting them has no effect.
       
       These flags will be removed in a future version of Terraform.
       
       Success! The configuration is valid, but there were some validation warnings as shown above.
       
$$$$$$ Finished validating the Terraform configuration files.
$$$$$$ Building the infrastructure based on the Terraform configuration...
       github_repository.repo_in_organization: Refreshing state... [id=test-repo]
       github_repository.repo_in_organization: Creating...
       github_repository.repo_in_organization: Creation complete after 4s [id=test-repo]
       
       Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
$$$$$$ Finished building the infrastructure based on the Terraform configuration.
$$$$$$ Reading the output variables from the Terraform state...
$$$$$$ Finished reading the output variables from the Terraform state.
$$$$$$ Parsing the Terraform output variables as JSON...
$$$$$$ Finished parsing the Terraform output variables as JSON.
$$$$$$ Writing the output variables to the Kitchen instance state...
$$$$$$ Finished writing the output varibales to the Kitchen instance state.
$$$$$$ Writing the input variables to the Kitchen instance state...
$$$$$$ Finished writing the input variables to the Kitchen instance state.
       Finished converging <default-github> (0m7.43s).
-----> Test Kitchen is finished. (0m8.08s)
```

* Execute the following command to perform the test

```
bundle exec kitchen verify
```



* The outout should look like this

```
❯ bundle exec kitchen verify
-----> Starting Test Kitchen (v2.4.0)
-----> Setting up <default-github>...
       Finished setting up <default-github> (0m0.00s).
-----> Verifying <default-github>...
$$$$$$ Reading the Terraform input variables from the Kitchen instance state...
$$$$$$ Finished reading the Terraform input variables from the Kitchen instance state.
$$$$$$ Reading the Terraform output variables from the Kitchen instance state...
$$$$$$ Finished reading the Terraform output varibales from the Kitchen instance state.
$$$$$$ Verifying the systems...
$$$$$$ Verifying the 'default' system...

Profile: tests from /Users/yhalachev/repos/github_provider/test/integration/default (tests from .Users.yhalachev.repos.github_provider.test.integration.default)
Version: (not specified)
Target:  local://

  ✔  check_website: HTTP GET on https://github.com/yordanivh-source/test-repo
     ✔  HTTP GET on https://github.com/yordanivh-source/test-repo status is expected to cmp == 200
     ✔  HTTP GET on https://github.com/yordanivh-source/test-repo body is expected to match "This is a test"


Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 2 successful, 0 failures, 0 skipped
$$$$$$ Finished verifying the 'default' system.
$$$$$$ Finished verifying the systems.
       Finished verifying <default-github> (0m0.66s).
-----> Test Kitchen is finished. (0m1.31s)
```

You can see that the test was caried out and that the request for the repo page got a 200 OK responce. Repo was created.

* Next step is to destroy the test. Always a good idea to clean after yourself.

```
bundle exec kitchen destroy
```

* Output

```
❯ bundle exec kitchen destroy
-----> Starting Test Kitchen (v2.4.0)
-----> Destroying <default-github>...
$$$$$$ Verifying the Terraform client version is in the supported interval of >= 0.11.4, < 0.13.0...
$$$$$$ Reading the Terraform client version...
       Terraform v0.12.23
       + provider.github v2.6.1
       
       Your version of Terraform is out of date! The latest version
       is 0.12.24. You can update by downloading from https://www.terraform.io/downloads.html
$$$$$$ Finished reading the Terraform client version.
$$$$$$ Finished verifying the Terraform client version.
$$$$$$ Initializing the Terraform working directory...
       
       Initializing the backend...
       
       Initializing provider plugins...
       
       The following providers do not have any version constraints in configuration,
       so the latest version was installed.
       
       To prevent automatic upgrades to new major versions that may contain breaking
       changes, it is recommended to add version = "..." constraints to the
       corresponding provider blocks in configuration, with the constraint strings
       suggested below.
       
       * provider.github: version = "~> 2.6"
       
       Terraform has been successfully initialized!
$$$$$$ Finished initializing the Terraform working directory.
$$$$$$ Selecting the kitchen-terraform-default-github Terraform workspace...
$$$$$$ Finished selecting the kitchen-terraform-default-github Terraform workspace.
$$$$$$ Destroying the Terraform-managed infrastructure...
       github_repository.repo_in_organization: Refreshing state... [id=test-repo]
       github_repository.repo_in_organization: Destroying... [id=test-repo]
       github_repository.repo_in_organization: Destruction complete after 1s
       
       Destroy complete! Resources: 1 destroyed.
$$$$$$ Finished destroying the Terraform-managed infrastructure.
$$$$$$ Selecting the default Terraform workspace...
       Switched to workspace "default".
$$$$$$ Finished selecting the default Terraform workspace.
$$$$$$ Deleting the kitchen-terraform-default-github Terraform workspace...
       Deleted workspace "kitchen-terraform-default-github"!
$$$$$$ Finished deleting the kitchen-terraform-default-github Terraform workspace.
       Finished destroying <default-github> (0m3.72s).
-----> Test Kitchen is finished. (0m4.37s)
```
