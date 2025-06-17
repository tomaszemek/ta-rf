# ta-rf

Simple Test Automation project demonstrating use of Robot Framework for acceptance testing on API and UI flows

# Usage

## Docker

Preferably use docker to run the whole test execution environment.

1. Install docker environment as per OS specific instructions

2. Clone the ta-rf repo 

3. Set valid API keys in the WeatherAPIKey.secret.resource and GeolocateAPIKey.secret.resource

4. Run the tests

    NOTES: 
    
    - The docker image to be created is quite big in size, about 4.5 GB in the end.
    - You can run part of the project by mapping a subfolder, e.g. ./suites/ui only.
    - Supported values for BROWSER are chromium, firefox and webkit (limitation of Playwright).
    - The example command uses Linux path format
    - For Docker execution on Windows, the path specifications (values for the -v arguments) 
        might need to be possibly adapted for backslash instead; 
        however as Docker image runs Linux internally, part of the paths (Docker facing) 
        still need to use Linux path format.
    
    ```console
    cd ta-rf
    docker run \
        -v ./results:/opt/robotframework/reports:Z \
        -v ./suites:/opt/robotframework/suites:Z \
        -v ./resources:/opt/robotframework/resources:Z \
        -e ROBOT_TESTS_DIR="/opt/robotframework/suites" \
        -e ROBOT_OPTIONS="--pythonpath /opt/robotframework" \
        -e BROWSER=chromium
        ppodgorsek/robot-framework:latest
    ```
5. Test logs and reports can be found in ./results folder


## Manual

1. Python

    Install Python interpreter as per your OS specific instruction, recommended latest release

2. Node.js (for UI tests)

    Install Node.js environment as per your OS specific instructions, recommended latest current

3. Clone the ta-rf repo

4. Python virtual environment

    This is recommended to do to support multiple runtime evironments with different prerequisities.
    
    Create one to isolate local runtime environment from interfering with other ones:

    ```console
    cd ta-rf
    python -m venv .venv
    ```

4. Robot framework & libraries

    Activate the virtual environment and install required libraries into it. Then initialize Browser library.

    ```console
    cd ta-rf
    (Linux:)    source ./.venv/bin/activate
    (Windows Powershell:)   .\.venv\Scripts\Activate.ps1
    (Windows cmd:)  .\.venv\Scripts\activate.bat
    pip install -r requirements.txt
    rfbrowser init
    ```

5. VS Code settings - RobotCode plugin

    Use RobotCode plugin for Robot Framework integration within Code
    
    Enable resource path resolution from within the IDE (File - Preferences - Settings):

    ```console
    "robotcode.robot.pythonPath": [
        "."
        ],
    ```

6. Set BROWSER for test execution via VS Code

    In order to support execution within Docker, environment variables are used to carry information.
    However during execution within VS Code, those need to be set as well.
    Best way to achieve that is make use of the RobotCode features and set the variable within 
    the extension preferences file robot.toml.
    In case you already have that file, just merge the contents.

7. Set valid API keys in the WeatherAPIKey.secret.resource and GeolocateAPIKey.secret.resource

8. Run the tests from VS Code or from terminal


# Documentation

## Robot Framework
https://docs.robotframework.org/docs


# TODO

suppress leaking API key values to logfiles, some background:

- https://forum.robotframework.org/t/secret-handling-using-robot/5417/3
- https://stackoverflow.com/questions/49237787/how-to-hide-login-credentials-in-log-html-file-in-robotframework
- https://github.com/robotframework/robotframework/issues/4537
- https://github.com/Snooz82/robotframework-crypto

