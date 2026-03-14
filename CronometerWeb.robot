*** Settings ***
Library     Browser
Library     DateTime
Library     os

Suite Setup       New Browser    ${BROWSER}      ${HEADLESS}
#Test Setup        New Page    https://cronometer.com/login/
Test Teardown     Close Context
Suite Teardown    Close Browser 

*** Variables ***
${BROWSER}    chromium
${HEADLESS}    false
${CRONOMETER_URL}    https://cronometer.com/login/


${username_ID}=           id=username
${Username_Xpath}=        xpath=//input[@id='username']
${Password_Xpath}=        xpath=//input[@id='password']
${username} =             yomnaaaa2@gmail.com
${password} =             1234567891011
${Login_Button} =         xpath=//button[@id='login-button']
${Cronometer_Bar} =         css=.btn.btn-toggle.text-white.align-items-baseline
${Foods}=         css=body > div:nth-child(4) > nav:nth-child(1) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > div:nth-child(1) > ul:nth-child(1) > li:nth-child(4) > div:nth-child(2) > ul:nth-child(1) > li:nth-child(7) > a:nth-child(1)
${Search_button}=          css=div[id='foods-collapse'] li:nth-child(7)
${Banana}=                 xpath=(//div[@class='gwt-Label'][normalize-space()='Banana, Fresh'])[1]
${Select_Banana}=          xpath=//button[normalize-space()='Add to Diary']
${Add_to_Diary}=         xpath=//button[@class='gwt-Button btn-flat-jungle-green'][normalize-space()='Add to Diary']
*** Test Cases ***


Add Food 
    Open Cronometer Web
    Open Account
    Search For Food    
    Add Food To Diary
    Get Time From Web
    




*** Keywords ***
Open Cronometer Web
    New Page    ${CRONOMETER_URL}


Open Account
    Wait For Elements State    ${username_ID}      visible    
    Fill Text                  ${Username_Xpath}        yomnaaaa2@gmail.com
    Fill Text                  ${Password_Xpath}        1234567891011
    Click                      ${Login_Button}
    sleep    10s
    Wait For Elements State    ${Cronometer_Bar}    visible    


Search For Food
    Wait For Elements State    ${Cronometer_Bar}    visible    
    Click                      ${Cronometer_Bar}
    sleep    5s
    click                      ${Foods}  
    Sleep    5s
    Click                      ${Search_button}
    Sleep    5s

   
Add Food To Diary
    click        ${Banana}
    click        ${Select_Banana}
    sleep    5s
    wait for elements state    ${Add_To_Diary}        visible
    click    ${Add_To_Diary}
    sleep    5s

Get Time From Web
    ${WEB_time}=    Get Time    result_format=%H:%M
    Log To Console    Current Time: ${WEB_time}

