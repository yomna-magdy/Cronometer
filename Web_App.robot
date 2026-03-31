*** Settings ***
Library     Browser
Library     DateTime
Library     os
Library    AppiumLibrary
Library    Dialogs
Variables  Resources/VariablesWeb_App.yaml




Suite Setup       New Browser    ${BROWSER}      ${HEADLESS} 
Suite Teardown    Close Application
*** Test Cases ***
Cronometer Web and App Time Sync Test
    Open Cronometer Web
    Sleep    5s
    Search For Food
    Add Food To Diary
    Get Time From Web
    Open Mobile Application
    Open Account
    Sleep    5s
    Manual Confirm
    Open Diary
    Get Time From App
    Calculate Time Difference







*** Keywords ***
Open Cronometer Web
    New Page    ${CRONOMETER_URL}
    sleep  10s
    Wait For Elements State    ${username_IDWeb}      visible    
    Fill Text                  ${Username_XpathWeb}        ${usernameWeb}
    Fill Secret                  ${Password_XpathWeb}       roIp$4XLqd4s@7Q
    Click                      ${Login_ButtonWeb}
    sleep    10s
    Wait For Elements State    ${Cronometer_BarWeb}    visible    


Search For Food
    Wait For Elements State    ${Cronometer_BarWeb}    visible    
    Click                      ${Cronometer_BarWeb}
    sleep    5s
    click                      ${FoodsWeb}  
    Sleep    5s
    Click                      ${Search_buttonWeb}
    Sleep    5s
    Click                      ${Search_barWeb}
    sleep    5s
    Fill Text                  ${Search input's css}        ${Text}
    Click                      ${Banana's Xpath}

    Sleep    5s
    Click                      text = CHOOSE

   
Add Food To Diary
    
    click        ${Select_BananaWeb}
    sleep    5s
    wait for elements state    ${Add_To_DiaryWeb}        visible
    click    ${Add_To_DiaryWeb}
    sleep    5s

Get Time From Web
    ${WEB_time} =    Get Current Date    result_format=%H:%M
    Log To Console    Current Time: ${WEB_time}
    ${WEB_epoch}=    Convert Date    ${WEB_time}    result_format=epoch


Open Mobile Application
    [Documentation]    Open Cronometer App
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
    Sleep    5s
    

Open Account
    wait until element is visible    ${AlreadyHaveAnAccountApp}
    Click Element    ${AlreadyHaveAnAccountApp}
    wait until element is visible    ${EmailxpathApp}
    Click Element    ${EmailxpathApp}
    sleep    5s
    click element    ${Yomna's EmailApp}
    Click Element    ${PasswordXpathApp}
    Input Text       ${PasswordXpathApp}   roIp$4XLqd4s@7Q
    Click Element    ${LoginButtonApp}
    


Manual Confirm
    Pause Execution    


Open Diary
    wait until element is visible   ${Diary's XpathApp}
    click element    ${Diary's XpathApp}
    Sleep    5s      
    wait until element is visible     accessibility_id= Banana, Fresh\n1 large - 8" to 8 7/8" long\n119.7 kcal\n119.7\nkcal

Get Time From App
    ${APP_time} =    Get Current Date    result_format=%H:%M
    Log To Console    Current Time: ${APP_time}
    ${APP_epoch}=    Convert Date    ${APP_time}    result_format=epoch
Calculate Time Difference
    ${diff}=    Evaluate    ${WEB_epoch} - ${APP_epoch}
    Log To Console   Difference in seconds: ${diff}
    
    ${seconds}=      Evaluate    ${diff}%60
    ${diff}=         Evaluate    ${diff}-(${diff}%60)
    ${minutes}=      Evaluate    ${diff}//60
    Log To Console   Difference: ${minutes} minutes and ${seconds} seconds


   
