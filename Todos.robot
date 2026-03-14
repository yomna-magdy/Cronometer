*** Settings ***
Library     Browser
Library     String
Suite Setup    New Browser    ${BROWSER}      ${HEADLESS}

Test Teardown    Close Context  #To clear the sessions and Cookies after each test case
Suite Teardown    Close Browser  #To close the browser after all test cases

*** Variables ***
${BROWSER}    chromium    #To Open Chromium Browser (Chrome)
${HEADLESS}   False     #To be Visible                     


*** Test Cases ***  # Each Test Case is Independent and unique
Add Two ToDos And Check Items
    ToDo App is open
    ADD TODO    "Learn Robot Framework"
    ADD TODO    "Write Test Cases"
    VAR    ${Count}     2
    Check Item Count    ${Count}        
    Sleep  3s 
    


Add Two ToDos And Check Wrong Number Of Items
    ToDo App is open
    ADD TODO    "Learn Robot Framework"
    ADD TODO    "Write Test Cases"
    VAR    ${Count}     3
    Check Item Count    ${Count}
    Sleep  3s    
    


Add ToDo And Mark Same ToDo
    ToDo App is open
    ADD TODO    "Learn Robot Framework"
    Click    css=ul.todo-list li:nth-child(1) input.toggle
    Sleep  3s



Check If Marked ToDos are removed
    ToDo App is open
    ADD TODO    "Learn Robot Framework"
    ADD TODO    "Write Test Cases"
    Click    css=ul.todo-list li:nth-child(1) input.toggle
    VAR    ${Count}     1
    Check Item Count    ${Count} 
    Sleep  3s


Split ToDos
    ToDo App is open
    Split    "Learn Robot Framework&Write Test Cases&Sleep"
    VAR    ${Count}     3
    Check Item Count    ${Count} 
    Sleep  3s
      


Add A Lot Of Todos
    ToDo App is open
       VAR    @{items}    Bread    Milk    Eggs    Butter   Cheese    Apples    Bananas    Chicken    Rice    Pasta    Coffee

    FOR    ${item}    IN    @{items}
        ADD TODO   ${item}
    END

    VAR    ${Count}     11
    Check Item Count    ${Count}
    Sleep  3s

Add A Lot Of Todos With WHILE
    ToDo App is open  
    VAR    ${i}   0
    VAR    ${items}    10
    WHILE    ${i} <= ${items}
        ADD TODO    Item ${i}
        ${i}=    Evaluate    ${i} + 1
        
    END

    VAR    ${Count}     11
    Check Item Count    ${Count}  
    Sleep  3s
 





*** Keywords ***     
 #Like Functions in programming languages 
ToDo App is open
    New Page    https://todomvc.com/examples/react/dist/



ADD TODO 
    [Arguments]  ${text}
    Fill Text   .new-todo    ${text}
    Press Keys  .new-todo     Enter



Check Item Count
    [Arguments]    ${Count}
    Get Text    span.todo-count    matches     ${Count}  items? left*            


Split 
    [Arguments]  ${todo}
    IF  "&" in $todo
        @{todos}    Split String    ${todo}    separator=&
        FOR  ${item}  IN  @{todos}
            Fill Text  .new-todo  ${item}
            Press Keys  .new-todo  Enter 
        END
    ELSE
        Fill Text  .new-todo  ${todo}
        Press Keys  .new-todo  Enter
    END

