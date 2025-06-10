# ta-rf

Simple Test Automation project demonstrating use of Robot Framework for API and acceptance testing

# Usage

## Docker

Preferably use docker to run the whole test execution environment.

1. Install docker environment as per OS specific instructions

2. Clone the ta-rf repo 

3. Set valid API keys in the resources/secrets/APIKey.secret.resource

4. Run the tests using the recommended docker image:

    ```console
        cd ta-rf
        docker run \
            -v ./results:/opt/robotframework/reports:Z \
            -v ./tests:/opt/robotframework/tests:Z \
            ppodgorsek/robot-framework:latest
    ```

## Manual

1. Python

    System wide Python interpreter per your OS specific instruction

2. Clone the ta-rf repo

3. Virtual environment

    Crate one to isolate local runtime environment from interfering with other ones:

    ```console
        cd ta-rf
        python -m venv .venv
    ```

4. Robot framework & libraries

    Activate the virtual environment and install required libraries into it:

    ```console
        cd ta-rf
        source ./.venv/bin/activate
        pip install -r requirements.txt
    ```

5. VS Code settings - Robocorp plugin

    Enable resource path resolution from within the IDE:

    ```console
        "robotcode.robot.pythonPath": [
            "./"
            ],
    ```

6. Set valid API keys in the resources/secrets/APIKey.secret.resource

7. Run the tests from VS Code or from terminal


# Documentation

## RF Requests library
https://docs.robotframework.org/docs/different_libraries/requests


# TODO

suppress leaking API key values to logfiles, some background:

- https://forum.robotframework.org/t/secret-handling-using-robot/5417/3
- https://stackoverflow.com/questions/49237787/how-to-hide-login-credentials-in-log-html-file-in-robotframework
- https://github.com/robotframework/robotframework/issues/4537
- https://github.com/Snooz82/robotframework-crypto

