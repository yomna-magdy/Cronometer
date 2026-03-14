*** Settings ***
Library    AppiumLibrary
Library    Browser
Library    os 
Library    DateTime
Library    Dialogs

Suite Setup       Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
Teardown    Close Application

*** Variables ***


${BROWSER}    chromium
${HEADLESS}    false


${REMOTE_URL}      http://127.0.0.1:4723 
${PLATFORM_NAME}   Android
${DEVICE_NAME}     emulator-5554
${AUTOMATION_NAME}  UiAutomator2
${APP_PACKAGE}     com.cronometer.android.gold
${APP_ACTIVITY}    com.cronometer.cronometer.MainActivity
${APP_TO_SEARCH}   cronometer

${AlreadyHaveAnAccount}=  xpath=//*[contains(@content-desc, "Already have an account")]
${EmailXpath}=    xpath=//android.view.View[@content-desc="Copyright © 2011-2026"]/android.view.View[1]/android.widget.EditText[1]
${Yomna's Email}=  xpath=//android.widget.TextView[@resource-id="android:id/text1"] 
${PasswordXpath}=    xpath=//android.view.View[@content-desc="Copyright © 2011-2026"]/android.view.View[1]/android.widget.EditText[2]
${Password}=     1234567891011
${LoginButton}=    xpath=//*[contains(@content-desc, "LOG IN")]
${Banana}=   accessibility_id = Banana, Fresh\n1 large - 8\" to 8 7/8\" long\n119.7 kcal\n119.7\nkcal
${Diary's Xpath}=    xpath=//android.widget.ImageView[@content-desc="Diary"]

#Test Teardown = Close Application

 
 
*** Test Cases ***
Open Application
    [Documentation]    Open Cronometer App
    #Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
    Sleep    5s
    

Open Account
    wait until element is visible    ${AlreadyHaveAnAccount}
    Click Element    ${AlreadyHaveAnAccount}
    wait until element is visible    ${Emailxpath}
    Click Element    ${Emailxpath}
    sleep    5s
    click element    ${Yomna's Email}
    Click Element    ${PasswordXpath}
    Input Text       ${PasswordXpath}   ${Password}
    Click Element    ${LoginButton}
    


Manual Confirm
    Pause Execution    
 
Open Diary
    wait until element is visible   ${Diary's Xpath}
    click element    ${Diary's Xpath}
    #wait until element is visible     xpath=//android.widget.ImageView[@content-desc="Diary"]
    #click element    xpath=//android.widget.ImageView[@content-desc="Diary"]
    wait until element is visible     ${Banana}

Get Time From App
    ${APP_time}=    Get Time    result_format=%H:%M
    Log To Console    Current Time: ${APP_time}
   