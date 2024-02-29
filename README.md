This repository is for the test task.
# Problem Statement

There is a python application at https://github.com/ustream/homework .
Your task is to automate the installation/configuration/startup process of the application which is explained 
in the README.md file in the repository. 

You can use Docker using an ubuntu or alpine base image.

# The Deliverable

* A Docker solution with a command which was used to successfully build and start up the application
* Optionally future improvement suggestions

# Solution

* This project contains the files for deploying the application mentioned in the problem statement on a docker container. 
* This repository contains the following files: 
    ```bash
    .
    ├── add_mysql_user.sh
    ├── docker-compose.yaml
    ├── Dockerfile
    ├── .env
    ├── mysql_secure.sh
    └── README.md
    ```

### add_mysql_user.sh
- This shell script is used to configure a new database user in mysql. 

### .env
- This file contains all the environment variables which are needed by the application.

### mysql_secure.sh
- This shell script configures the mysql in the container after mysql is installed. 

### Dockerfile
This file is used to create a docker image from an ubuntu base image for the [python application](https://github.com/ustream/homework).
- I have used ubuntu as the base image. 
- I have installed all the required packages to run mysql on the container. 
- I used git command to clone the [python application](https://github.com/ustream/homework). 
- I set the work directory to homework.
- Then I copied the scripts to configure mysql and add user to the database.
- In the next step I installed all the packages from `requirements.txt`.
- Then copied the `.env` file to the workdir. 
- Then exposed the ports 3306 and 6000 for the application
- In the final step of dockerfile I used CMD command to do the following
    - Start the mysql service 
    - Execute the scripts to configure mysql
    - create a database user.
    - Execute countapp/init_database.py script to create the database structure.
    - Executed the command to run the application. 
      ```bash
      gunicorn --bind 0.0.0.0:6000 --chdir countapp countapp.wsgi:app --reload --timeout=900
      ``` 

### docker-compose.yaml
- This is the docker compose file which can be used to deploy the application. 
- First run the build command
  ```bash
  docker compose build
  ``` 
- Then after this run the command to start the container. 
  ```bash
  docker compose up -d 
  ```
  This command will run the container in detached mode.


# Future Enhancements
- For future enhancement, we can generate all the password using a passsword generator and upload them to a vault, for example hashicorp vault, GCP secret manager, AWS secret manager or any other vault of choice.
- We can also encode them before saving them to the vaults using base64 encoding
- This will help us secure the passwords. 
- There were some dependencies which were not up to date in the readme file which I had to install separately in the dockerfile using pip. We can update the requirements.txt for the same. 
- If we deploy this on a cloud we can use the logging offered by the cloud. This can be done in the docker compose file. For example, we can use gcplogs driver to export the logs to the gcp stackdriver. 
