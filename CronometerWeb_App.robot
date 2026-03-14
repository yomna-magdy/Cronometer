*** Settings ***
Library     Browser
Library     DateTime
Library     os
Library    AppiumLibrary
Library    Dialogs

Suite Setup       New Browser    ${BROWSER}      ${HEADLESS}
Suite Teardown     Close Application



*** Variables ***
${BROWSER}    chromium
${HEADLESS}    false
${CRONOMETER_URL}    https://cronometer.com/login/



${REMOTE_URL}      http://127.0.0.1:4723 
${PLATFORM_NAME}   Android
${DEVICE_NAME}     emulator-5554
${AUTOMATION_NAME}  UiAutomator2
${APP_PACKAGE}     com.cronometer.android.gold
${APP_ACTIVITY}    com.cronometer.cronometer.MainActivity
${APP_TO_SEARCH}   cronometer





${username_IDWEB}=           id=username
${Username_XpathWEB}=        xpath=//input[@id='username']
${Password_XpathWEB}=        xpath=//input[@id='password']
${usernameWEB} =             yomnaaaa2@gmail.com
${password} =             1234567891011
${Login_ButtonWEB} =         xpath=//button[@id='login-button']
${Cronometer_BarWEB} =         css=.btn.btn-toggle.text-white.align-items-baseline
${BananaWbe}=                  text=Banana, Fresh  
${FoodsWeb}=         css=body > div:nth-child(4) > nav:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > ul:nth-child(1) > li:nth-child(4) > div:nth-child(2) > ul:nth-child(1) > li:nth-child(7) > a:nth-child(1)
${Search_ButtonWeb}=          css=div[id='foods-collapse'] li:nth-child(7)
${Select_BananaWeb}=          xpath=//button[normalize-space()='Add to Diary']
${Add_to_DiaryWeb}=         xpath=//button[@class='gwt-Button btn-flat-jungle-green'][normalize-space()='Add to Diary']





${AlreadyHaveAnAccountApp}=  xpath=//*[contains(@content-desc, "Already have an account")]
${EmailXpathApp}=    xpath=//android.view.View[@content-desc="Copyright © 2011-2026"]/android.view.View[1]/android.widget.EditText[1]
${Yomna's EmailApp}=  xpath=//android.widget.TextView[@resource-id="android:id/text1"] 
${PasswordXpathApp}=    xpath=//android.view.View[@content-desc="Copyright © 2011-2026"]/android.view.View[1]/android.widget.EditText[2]
${LoginButtonApp}=    xpath=//*[contains(@content-desc, "LOG IN")]
${BananaApp}=   accessibility_id = Banana, Fresh\n1 large - 8" to 8 7/8" long\nNCCDB
${DiaryApp}=    xpath=//android.widget.ImageView[@content-desc="Diary"]


*** Test Cases ***
Add Food 
    Open Cronometer Website
    Open Account On Web
    Search For Food On Web    
    Add Food To Diary On Web
    Get Time From Web



Open Application
   [Documentation]    Open Cronometer App
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
    Sleep    5s

Open Account
    wait until element is visible    ${AlreadyHaveAnAccountApp}
    Click Element    ${AlreadyHaveAnAccountApp}
    wait until element is visible    ${EmailXpathApp}
    Click Element    ${EmailXpathApp}
    sleep    5s
    click element    ${Yomna's EmailApp}
    Click Element    ${PasswordXpathApp}
    Input Text       ${PasswordXpathApp}   ${password}
    Click Element    ${LoginButtonApp}
    Sleep    10s

Manual Confirm
    Pause Execution

Open Diary
    wait until element is visible   ${DiaryApp}
    click element    ${DiaryApp}
    Sleep    5s
    wait until element is visible     ${BananaApp}

Get Time From App
    ${APP_time}=    Get Time    result_format=%H:%M
    Log To Console    Current Time: ${APP_time}




*** Keywords ***
Open Cronometer Website
    New Browser    ${BROWSER}      ${HEADLESS}
    New Context    locale=en-GB
    New Page    ${CRONOMETER_URL}
    Sleep    5s

Open Account On Web
    Wait For Elements State    ${username_IDWEB}      visible    
    Fill Text                  ${Username_XpathWEB}        ${usernameWEB}
    Fill Text                  ${Password_XpathWEB}        ${password}
    Click                      ${Login_ButtonWEB}
    Sleep    10s  

Search For Food On Web
    Wait For Elements State    ${Cronometer_BarWEB}    visible    
    Click                      ${Cronometer_BarWEB}
    Sleep    5s
    Click                      ${FoodsWeb}
    Sleep    5s
    Click                      ${Search_ButtonWeb}

Add Food To Diary On Web
    Wait For Elements State    ${BananaWbe}    visible
    Click                      ${BananaWbe}
    Wait For Elements State    ${Select_BananaWeb}    visible
    Click                      ${Select_BananaWeb}
    Wait For Elements State    ${Add_to_DiaryWeb}    visible
    Click                      ${Add_to_DiaryWeb}
    Sleep    5s
Get Time From Web
    ${WEB_time}=    Get Time    result_format=%H:%M
    Log To Console    Current Time: ${WEB_time}
