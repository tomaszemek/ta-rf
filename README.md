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
    - Supported values for BROWSER are chromium and firefox.
    - The example command uses Linux path format.
    - The example make use of environment variables which are explicitly set.
    - For Docker execution on Windows, the path specifications (values for the -v arguments) 
        might need to be possibly adapted for backslash instead; 
        however as Docker image runs Linux internally, part of the paths (Docker facing) 
        still need to use Linux path format.

    4.1 Option 1 - Robot single threaded execution

    ```console
    cd ta-rf
    docker run \
        -v ./suites:/opt/robotframework/suites:Z \
        -v ./resources:/opt/robotframework/resources:Z \
        -v ./results:/opt/robotframework/results:Z \
        -e ROBOT_TESTS_DIR="/opt/robotframework/suites" \
        -e ROBOT_REPORTS_DIR="/opt/robotframework/results" \
        -e ROBOT_OPTIONS="--pythonpath /opt/robotframework" \
        -e BROWSER=chromium
        ppodgorsek/robot-framework:latest
    ```

    4.2 Option 2 - Pabot parallel multi threaded execution

    Here example with 4 execution pool threads and Chromium.

    ```console
    cd ta-rf
    docker run \
        -v ./suites:/opt/robotframework/suites:Z \
        -v ./resources:/opt/robotframework/resources:Z \
        -v ./results:/opt/robotframework/results:Z \
        -e ROBOT_TESTS_DIR="/opt/robotframework/suites" \
        -e ROBOT_REPORTS_DIR="/opt/robotframework/results" \
        -e ROBOT_OPTIONS="--pythonpath /opt/robotframework" \
        -e ROBOT_THREADS=4 \
        -e PABOT_OPTIONS="--testlevelsplit --pabotlib" \
        -e BROWSER=chromium
        ppodgorsek/robot-framework:latest
    ```

5. Test logs and reports can be found in ./results folder


## Manual

1. Python

    Install Python interpreter as per your OS specific instruction, recommended latest release.

2. Node.js (for UI tests)

    Install Node.js environment as per your OS specific instructions, recommended latest current.

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

    Use RobotCode plugin for Robot Framework integration within Code.
    
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

    NOTES: 
    
    - You can run part of the project by mapping a subfolder, e.g. ./suites/ui only.
    - Supported values for BROWSER are chromium and firefox.
    - The example command uses Linux path format.
    - The example make use of environment variables which are explicitly set.

    8.1 Option 1 - Robot single threaded execution

    ```console
    cd ta-rf
    export PYTHONPATH=.:$PYTHONPATH
    export BROWSER=chromium
    export ROBOT_RESULTS=./results
    robot --outputDir $ROBOT_RESULTS .
    ```

    8.2 Option 2 - Pabot parallel multi threaded execution

    ```console
    cd ta-rf
    export PYTHONPATH=.:$PYTHONPATH
    export BROWSER=chromium
    export ROBOT_THREADS=4
    export ROBOT_RESULTS=./results
    pabot --testlevelsplit --pabotlib --processes $ROBOT_THREADS --outputDir $ROBOT_RESULTS .
    ```


# Documentation

## Robot Framework
https://docs.robotframework.org/docs

## Requests Library
https://docs.robotframework.org/docs/different_libraries/requests

## Browser Library
https://docs.robotframework.org/docs/different_libraries/browser

## Data Driven Tests
https://docs.robotframework.org/docs/testcase_styles/datadriven

## Pabot Parallel Robot Framework Execution
https://pabot.org/

## Docker Robot Framework image
https://github.com/ppodgorsek/docker-robot-framework

## Practice Software Testing
https://github.com/testsmith-io/practice-software-testing


# TODO

suppress leaking API key values to logfiles, some background:

- https://forum.robotframework.org/t/secret-handling-using-robot/5417/3
- https://stackoverflow.com/questions/49237787/how-to-hide-login-credentials-in-log-html-file-in-robotframework
- https://github.com/robotframework/robotframework/issues/4537
- https://github.com/Snooz82/robotframework-crypto

