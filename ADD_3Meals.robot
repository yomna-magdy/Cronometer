*** Settings ***
Library     Browser
Variables  Resourses/VariablesFor3Meals.yaml




Suite Setup       New Browser    ${BROWSER}      ${HEADLESS} 
Suite Teardown    Close Browser

*** Test Cases ***
Add 3 Meals To Diary
    [Documentation]    This test case will add 3 meals to the diary and check if they are added successfully.
    Login To Cronometer Web
    Open Cronometer bar
    Search For Food
    Add Food To Diary
    Back To Foods


*** Keywords ***
Login To Cronometer Web
    New Page    ${CRONOMETER_URL}
    sleep  10s
    Wait For Elements State    ${username_ID}      visible    
    Fill Text                  ${Username_Xpath}        ${username}
    Fill Text                  ${Password_Xpath}       ${password}
    Click                      ${Login_Button}
    sleep    10s
    Wait For Elements State    ${Cronometer_Bar}    visible


Open Cronometer bar
   # Click                      ${Cronometer_Bar}
    sleep    2s
    Click                      ${Foods_Button's Xpath}  
    Sleep    2s
    Click                      ${Search_Foods_Button}
    Sleep    2s


Search For Food
    Click                      ${Search Foods & Recipes }
    sleep    2s
    Fill Text                  ${Search Foods & Recipes's bar}        Milk, Goat
    Click                       "Milk, Goat"
    Click                      ${Choose Meal}


Add Food To Diary
    Click                      ${Add to Diary Button}
    Sleep    2s
    Select From List By Value  ${Diary group}        ${Category}=>Breakfast
    Click                      ${Add to Diary's second Button}
    Sleep    2s

Back To Foods
    Click                      ${Back To Foods Button}
    Sleep    2s