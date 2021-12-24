## Purpose
* Self learning
* Test a potential set up for a different project

## Overview

```
./
 |- dist/                  # contains "the server" you are going to run on EC2 
 |- tf/                    # contains the terraform files for the system
 |- Dockerfile             # for testing your server and user_data_template logic
 `- user_data_template.sh  # terraform substitutes ${var}s and uses the output as EC2 user data
```

## TODOs
* dynamic distro-based install
* dynamic distro-based service set up
~~* manual vpc & nat set up~~
~~* manual ec2 start~~
~~* ssh the box~~
~~* line by exec test~~
~~* curl to local host test~~
* ~~TF~~
  * ~~VPC~~
  * ~~Subnet~~
  * ~~IG~~
  * ~~Instance~~
  * ~~user data script~~
  * ~~connect & curl~~
  * ~~restart & curl~~
* ~~Curl from here~~

