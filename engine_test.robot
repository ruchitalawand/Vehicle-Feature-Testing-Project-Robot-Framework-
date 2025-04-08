*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://vehicle-dashboard.local

*** Test Cases ***
Start Engine Feature Test
    Open Browser    ${URL}    Chrome
    Click Element   id=start-engine
    Element Should Contain    id=engine-status    ON
    Close Browser

*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Dashboard
Suite Teardown    Close Browser
Test Setup        Go To Dashboard
Test Teardown     Capture Page Screenshot

*** Variables ***
${BROWSER}        Chrome
${URL}            http://vehicle-dashboard.local

*** Keywords ***
Open Browser To Dashboard
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Go To Dashboard
    Go To    ${URL}

*** Test Cases ***
[Smoke] Engine Start/Stop Functionality
    Click Element           id=start-engine
    Element Text Should Be  id=engine-status    ON
    Click Element           id=stop-engine
    Element Text Should Be  id=engine-status    OFF

[Regression] Brake System Safety Check
    Click Element           id=brake-status
    Element Should Contain  id=brake-status    ENGAGED
    Page Should Contain     Brake pressure within safe limit

[Sanity] Headlight Auto Mode Activation
    Click Element           id=lights-toggle
    Element Should Contain  id=light-status    AUTO

[UI] Dashboard Load Time Check
    ${start}=    Get Time
    Reload Page
    Wait Until Page Contains Element    id=dashboard    timeout=10s
    ${end}=      Get Time
    ${duration}= Evaluate    ${end} - ${start}
    Should Be True    ${duration} < 5

[Functional] Indicator Light Toggle Test
    Click Element           id=indicator-left
    Element Text Should Be  id=indicator-status    LEFT
    Click Element           id=indicator-right
    Element Text Should Be  id=indicator-status    RIGHT