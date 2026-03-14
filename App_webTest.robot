*** Settings ***
Library        Browser
Library        DateTime
Library        os
Library        AppiumLibrary
Library        Dialogs
Variables      Resourses/VariablesApp_Web.yaml

Suite Setup       Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
Suite Teardown    Close Browser



***Test Cases ***
Cronometer App and Web Time Sync Test
    Open Mobile Application
    Open Account
    Sleep    5s
    Manual Confirm
    Add Food To Diary
    Get Time From App

    Open Cronometer Website
    Check Elements On Web
    Get Time From Web
    Get Time Difference



*** Keywords ***
Open Mobile Application
    [Documentation]    Open Cronometer App
    Sleep    5s



Open Account
    wait until element is visible    ${AlreadyHaveAnAccountApp}
    Click Element    ${AlreadyHaveAnAccountApp}
    wait until element is visible    ${EmailXpathApp}
    Click Element    ${EmailXpathApp}
    sleep    5s
    click element    ${Yomna's EmailApp}
    Click Element    ${PasswordXpathApp}
    Pause Execution
    #Input Text       ${PasswordXpathApp}   ${password}
    Click Element    ${LoginButtonApp}
    Sleep    10s

Manual Confirm
    Pause Execution

Add Food To Diary
    wait until element is visible     ${OpenCronometerBar}
    click element    ${OpenCronometerBar}
    wait until element is visible     ${AddFoodButton}
    click element    ${AddFoodButton}
    Sleep    5s
    #for searching the food
    click element       xpath =//android.widget.EditText
    #Pause Execution
    Input Text Into Current Element    Tomato
    Sleep    5s
    Click element    accessibility_id =Tomato Raw, Includes Cherry, Grape, Roma\n1 thin slice - 1/8" thick\nNCCDB
    Sleep    5s 
    wait until element is visible     ${AddToDiaryButton}
    click element    ${AddToDiaryButton}
    Sleep    5s


Get Time From App
    ${APP_time}=    Get Current Date    result_format=datetime
    Set Global Variable    ${APP_time}
    Log To Console    Current Time: ${APP_time}

Open Cronometer Website
    New Browser    ${BROWSER}      ${HEADLESS}
    New Page    ${CRONOMETER_URL}
    Sleep    5s
    Wait For Elements State    ${username_IDWEB}      visible    
    Fill Text                  ${Username_XpathWEB}        ${usernameWEB}
    Fill Text                  ${Password_XpathWEB}        ${password}
    Click                      ${Login_ButtonWEB}
    Sleep    10s  

Check Elements On Web
    Wait For Elements State    ${Cronometer_BarWEB}    visible    
    Click                      ${Cronometer_BarWEB}
    Sleep    5s
    Click                      ${DiaryButtonWEB}
    wait for elements state    xpath= //div[@class='gwt-HTML'][normalize-space()='Tomato Raw, Includes Cherry, Grape, Roma']   visible

Get Time From Web
    ${WEB_TIME}=    Get Current Date    result_format=datetime
    Set Global Variable    ${WEB_TIME}
    Log To Console    Current Time: ${WEB_TIME}

Get Time Difference
    ${time_diff}=    Subtract Time From Time   ${APP_time}     ${WEB_TIME}      result_format=datetime   
    Log To Console    Time Difference between Web and App: ${time_diff}