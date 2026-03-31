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
    Sleep    2s
    Search For Food
    Add Food To Diary
    Get Time From Web
    Open Mobile Application
    Open Account
    Sleep    2s
    Manual Confirm
    Open Diary
    Get Time From App
    Calculate Time Difference







*** Keywords ***
Open Cronometer Web
    New Page                   ${CRONOMETER_URL}
    sleep  2s
    Wait For Elements State    ${username_Web}      visible    
    Fill Text                  ${Username_XpathWeb}        ${Email}
    Fill Secret                ${Password_XpathWeb}       $password
    Click                      ${Login_ButtonWeb}
    sleep    10s
    Wait For Elements State    ${Cronometer_BarWeb}    visible    


Search For Food
    Wait For Elements State    ${Cronometer_BarWeb}    visible    
    Click                      ${Cronometer_BarWeb}
    sleep    2s
    click                      ${FoodsWeb}  
    Sleep    2s
    Click                      ${Search_buttonWeb}
    Sleep    2s
    Click                      ${Search_barWeb}
    sleep    2s
    Fill Text                  ${Search input's css}        ${Meal}
    Click                      ${Meal}

    Sleep    2s
    Click                      ${Choose Meal}

   
Add Food To Diary
    
    click                       ${Select_BananaWeb}
    sleep    2s
    wait for elements state     ${Add_To_DiaryWeb}        visible
    click                       ${Add_To_DiaryWeb}
    sleep    2s

Get Time From Web
    ${WEB_time} =    Get Current Date    result_format=%H:%M
    Log To Console    Current Time: ${WEB_time}
    #${WEB_epoch}=    Convert Date    ${WEB_time}    result_format=epoch


Open Mobile Application
    [Documentation]    Open Cronometer App
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
    Sleep    5s
    

Open Account
    wait until element is visible    ${AlreadyHaveAnAccountApp}
    Click Element                    ${AlreadyHaveAnAccountApp}
    wait until element is visible    ${EmailxpathApp}
    Click Element                    ${EmailxpathApp}
    sleep    2s
    click element                    ${Yomna's EmailApp}
    Click Element                    ${Password's xpathApp}
    Input Text                       ${Password's xpathApp}      ${password}
    Click Element                    ${LoginButtonApp}
    


Manual Confirm
    Pause Execution    


Open Diary
    wait until element is visible     ${Diary's XpathApp}
    click element                     ${Diary's XpathApp}
    Sleep    5s      
    wait until element is visible     ${Meal's ID}


Get Time From App
    ${APP_time} =    Get Current Date    result_format=%H:%M
    Log To Console    Current Time: ${APP_time}
    #${APP_epoch}=    Convert Date    ${APP_time}    result_format=epoch
Calculate Time Difference
    ${diff}=    Evaluate    ${WEB_time} - ${APP_time}
    Log To Console   Difference in seconds: ${diff}
    
    ${seconds}=      Evaluate    ${diff}%60
    ${diff}=         Evaluate    ${diff}-(${diff}%60)
    ${minutes}=      Evaluate    ${diff}//60
    Log To Console   Difference: ${minutes} minutes and ${seconds} seconds


   
