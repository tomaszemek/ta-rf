*** Comments ***
This module makes sure that the available API keys are all used in a random manner

*** Settings ***
Resource    resources/secrets/APIKey.secret.resource

*** Keywords ***
Get Random API Key
    ${API_KEY}=  Evaluate  random.choice(${API_KEY_SET})  random
    RETURN    ${API_KEY}