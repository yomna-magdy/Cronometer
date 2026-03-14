*** Settings ***
Library    SeleniumLibrary



*** Variables ***
${Browser}    chrome
${URL}        http://sampleapp.tricentis.com/



*** Test Cases ***
Create Quote for Car
    Open Insurance Application
    Enter Vehicle Data for Automobile
    Enter Insurant Data
    Enter Product Data
    select Price Option
    send Quote 
    Close Browser   










*** Keywords ***

Open Insurance Application
    Open Browser    ${URL}    ${Browser}
    Click Link    Automobile



Enter Vehicle Data for Automobile
    Select From List By Value     id=make    BMW
    Input Text    id=engineperformance    150
    Input Text    id=dateofmanufacture    01/01/2020
    Select From List By Value   id=numberofseats    5
    Select From List By Value     id=fuel    Petrol
    Input Text    id=listprice    30000
    Input Text    id=licenseplatenumber    ABC123
    Input Text    id=annualmileage    12000
    Click Button    id=nextenterinsurantdata



Enter Insurant Data
    Input Text                      id=firstname    Yomna
    Input Text                      id=lastname    Mohamed
    Input Text                      id=birthdate    01/01/2003
    #Click Element                   css=label[for="genderfemale"]
    #Click Element                   xpath=//label[@for="genderfemale"]
    Click Element                   xpath=//label[contains(.,'Female')]
    Input Text                      id=streetaddress    123 Ali bn Abi Talib St    
    Select From List By Value       id=country    Egypt
    Input Text                      id=zipcode    12345
    Input Text                      id=city    Cairo
    Select From List By Value       id=occupation    Employee
    Click Element                   xpath=//label[contains(.,'Skydiving')]
    Click Element                   xpath=//label[contains(.,'Other')]
    Click Button                    id=nextenterproductdata




Enter Product Data
    Input Text                      id=startdate    01/01/2026
    Select From List By Value       id=insurancesum    3000000
    Select From List By Value       id=meritrating    Bonus 1
    Select From List By Value       id=damageinsurance    Full Coverage
    Click Element                   xpath=//label[contains(.,'Euro Protection')]
    Click Element                   xpath=//label[contains(.,'Legal Defense Insurance')]
    Select From List By Value       id=courtesycar    Yes
    Click Button                    id=nextselectpriceoption



select Price Option
    Wait Until Element Is Visible   css=#selectultimate    10s
    #Click Element                   xpath=//input[@value="Ultimate"]
    Click Element                   xpath=//span[contains(@class,'ideal-radio')]
    Click Button                    id=nextsendquote
   


send Quote
    Input Text                      id=email    yomna@gmail.com
    Input Text                      id=phone    01012345678
    Input Text                      id=username    yomna123
    Input Text                      id=password    Yomna1234
    Input Text                      id=confirmpassword    Yomna1234
    Input Text                      id=Comments    No comments
    Click Button                    id=sendemail
    Wait Until Element Is Visible   xpath=//div[contains(.,'Sending e-mail successful!')]    15s
    Element Should Be Visible       xpath=//div[contains(.,'Sending e-mail successful!')]
    Sleep                           3s





    #اركز علي الxpath و المفهوم بتاعها في البحث عن العناصر
    # web scrabing 
    # RPA
    # xpath selectors hub 
    #  
    # 
    # 
    # 
 