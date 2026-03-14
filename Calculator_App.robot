*** Settings ***
Library    AppiumLibrary

*** Variables ***
${REMOTE_URL}       http://127.0.0.1:4723
${PLATFORM_NAME}    Android
${DEVICE_NAME}      emulator-5554
${AUTOMATION_NAME}  UiAutomator2
${APP_PACKAGE}      com.google.android.calculator
${APP_ACTIVITY}     com.android.calculator2.Calculator

*** Test Cases ***
Add Nums
    Open Application    ${REMOTE_URL}
    ...    platformName=${PLATFORM_NAME}
    ...    deviceName=${DEVICE_NAME}
    ...    automationName=${AUTOMATION_NAME}
    ...    appPackage=${APP_PACKAGE}
    ...    appActivity=${APP_ACTIVITY}

    Click Element    xpath=//android.widget.ImageButton[@content-desc="5"]
    Click Element    xpath=//android.widget.ImageButton[@content-desc="plus"]
    Click Element    xpath=//android.widget.ImageButton[@content-desc="3"]
    Click Element    xpath=//android.widget.ImageButton[@content-desc="equals"]

    Sleep    2s
    Capture Page Screenshot    filename=result.png
    Close Application
