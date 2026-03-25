*** Settings ***
Library     Browser
Variables  Resources/VariablesFor3Meals.yaml


Suite Setup       New Browser    ${BROWSER}      ${HEADLESS} 
Suite Teardown    Close Browser



*** Test Cases ***
Add 3 Meals To Diary
    [Documentation]    This test case will add 3 meals to the diary and check if they are added successfully.
    Login To Cronometer Web
    Open Cronometer bar
    
    #First Meal
    Search For Food      Milk, Goat      cell
    Add Food To Diary    Breakfast
    Back To Foods
    
    Search For Food      Cereals, Oats, Regular and Quick, Not Fortified, Dry     cell
    Add Food To Diary    Breakfast
    Back To Foods

    #Second Meal
    Search For Food      Chicken Thigh, Skin Removed     cell
    Add Food To Diary    Lunch    
    Back To Foods

    Search For Food      Brown Rice, Cooked in Unsalted Water     cell
    Add Food To Diary    Lunch
    Back To Foods
    
    #Third Meal
    Search For Food      Greek Yogurt, Plain, Nonfat   cell
    Add Food To Diary    Dinner
    Back To Foods

    Search For Food      Broccoli Cheese Soup, Homemade    cell
    Add Food To Diary    Dinner    
    Back To Foods

    #Snack
    Search For Food      Apple, Fresh, With Skin    cell
    Add Food To Diary    Snacks
    



*** Keywords ***
Login To Cronometer Web
    New Page    ${CRONOMETER_URL}
    sleep  5s
    Wait For Elements State    ${username_ID}      visible    
    Fill Text                  ${Username_Xpath}        ${username}
    Fill Secret                  ${Password_Xpath}       $password
    Click                      ${Login_Button}
    sleep    5s
    Wait For Elements State    ${Cronometer_Bar}    visible

Open Cronometer bar
    # Click                      ${Cronometer_Bar}
    sleep    2s
    Click                      ${Foods_Button's Xpath}  
    Sleep    2s
    Click                      ${Search_Foods_Button}
    Sleep    2s


Search For Food
    [Arguments]      ${food to search}       ${food's role}
    Click                      ${Search Foods & Recipes }
    sleep    2s
    Fill Text                  ${Search Foods & Recipes's bar}        ${food to search}
    Click                      ${Search Button}
    ${food to search's xpath}=   Get Element By Role    ${food's role}  name=${food to search}      exact=True
    Click                      ${food to search's xpath}
    Click                      ${Choose Meal}


Add Food To Diary
    [Arguments]       ${Category's type}
    Click                      ${Add to Diary Button}
    Sleep    2s
    Click                      ${Diary group}

    ${Category}=    Get Element By Role    ${Category's Role}    name=${Category's type}   
    
    Click                      ${Category} 

    Click                      ${Add to Diary's second Button}
    Sleep    2s

Back To Foods
    Click                      ${Back to foods's button}
    Sleep    5s

Logout From Cronometer Web
    Click                      ${Logout_Button}


