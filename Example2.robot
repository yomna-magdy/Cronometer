*** Settings ***
Library    Browser


*** Variables ***
${BROWSER}    chromium
${HEADLESS}    false

*** Test Cases ***
Create Quote for Car
    Open Insurance Application
    Enter Vehicle Data for Automobile
    Enter Insurant Data
    Enter Product Data
    Select Price Option
    Send Quote
    End Test

   # Set Input Files    id=open     playright  library





*** Keywords ***
Open Insurance Application
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    locale=en-GB
    New Page       http://sampleapp.tricentis.com/


Enter Vehicle Data for Automobile    
    
    Click                div.main-navigation >> "Automobile"
    Wait For Elements State    css=section[style="display: block;"] >> #engineperformance    visible    5s
    Select Options By    css=#make    Text    Audi 
    Fill Text            css=#engineperformance    1200
    Fill Text            css=#dateofmanufacture    01/01/2020
    Select Options By    css=#numberofseats    Text    5
    Select Options By    css=#fuel    Text     Petrol
    Fill Text            css=#listprice    30000
    Fill Text            css=#licenseplatenumber    ABC123
    Fill Text            css=#annualmileage    15000
    Click                css=#nextenterinsurantdata
    Sleep  3s

   
Enter Insurant Data
    [Arguments]      ${FirtName}=Yomna    ${LastName}=AboElnaga
    Fill Text           id=firstname    ${FirtName}
    Fill Text           id=lastname     ${LastName}
    Fill Text           id=birthdate    01/01/2003
    #Click               Text=Female 
    Fill Text           id=streetaddress    123 Street
    Select Options By   id=country    Text    Egypt
    Fill Text           id=zipcode    12345
    Fill Text           id=city       Cairo
    Select Options By   id=occupation    Text    Employee
    Click               *css=label >> css=[value="Skydiving"]
    Fill Text           id=website    www.example.com
    Click               id=nextenterproductdata
    Sleep  3s



Enter Product Data
    Fill Text           id=startdate    01/01/2026
    Select Options By   id=insurancesum    Text    3.000.000,00
    Select Options By   id=meritrating    Text    Bonus 7
    Select Options By   id=damageinsurance    Text    Full Coverage
    Check Checkbox      *css=label >> id=EuroProtection
    Select Options By   id=courtesycar    Text    Yes
    Click               id=nextselectpriceoption



Select Price Option
    Click    *css=label >> css=[value="Silver"]
    Click               id=nextsendquote



Send Quote
    Fill Text          id=email    yomna@gmail.com
    Fill Text          id=phone    0123456789
    Fill Text          id=username    yomna123 
    Fill Text          id=password    Yomna123@   
    Fill Text          id=confirmpassword    Yomna123@
    Fill Text          id=Comments    No comments  
    Click              id=sendemail
    Wait For Elements State    css=div.sweet-alert.showSweetAlert.visible >> h2    visible    10s
    ${alert_text}=    Get Text    css=div.sweet-alert.showSweetAlert.visible >> h2
    Should Be Equal    ${alert_text}    Sending e-mail success! 
    Click              css=button.confirm  




End Test
    Close context
    Close Browser