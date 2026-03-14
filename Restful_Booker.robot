*** Settings ***
#Like cURL/ Postman
Library        RequestsLibrary

#For Dectionaries and Lists
library        Collections

#for cURL commands
Library        Process

# Create Admin Token
Suite Setup    Authenticate as Admin



*** Test Cases ***
Get Bookings from Restful Booker
    #create dectionary to save firstname key and Ali value
    ${body}=    Create Dictionary    firstname=Ali
    #send GET request to the API to Get all booking with first name ali and save response in variable(response)
    ${response}=    GET    https://restful-booker.herokuapp.com/booking    ${body}
    #cheack if it's run successfully
    Status Should Be    200
    #print value of response
    Log List    ${response.json()}
    #loop through each booking id in response and get details of each booking
    FOR  ${booking}  IN  @{response.json()}
        ${response}    GET    https://restful-booker.herokuapp.com/booking/${booking}[bookingid]
        #print value of response
        TRY
            Log    ${response.json()}
        #catch invalid json exception
        EXCEPT
            Log    Cannot retrieve JSON due to invalid data
        END
    END


Create a Booking at Restful Booker  
    #create 2 dectionary to save booking details(key and value pairs of json)
    ${booking_dates}     Create Dictionary    checkin=2022-12-31    checkout=2023-01-01
    ${body}    Create Dictionary    firstname=Ali    lastname=Can    totalprice=100    depositpaid=True    bookingdates=${booking_dates}        
    #send POST request to the API to create a booking and save response in variable(response) with body details
    ${response}    POST    url=https://restful-booker.herokuapp.com/booking    json=${body}   
    #set booking id from response to variable id
    ${id}     Set Variable     ${response.json()}[bookingid]
    #make id as suite variable to use in other test cases(like global variable)
    Set Suite Variable        ${id}
    #send get command to Cheak if the booking created successfully
    ${response}    GET    https://restful-booker.herokuapp.com/booking/${id} 
    #cheack if it's created successfully
    Should Be Equal    ${response.json()}[lastname]    Can
    Should Be Equal    ${response.json()}[firstname]   Ali 
    
    Should Be Equal As Numbers    ${response.json()}[totalprice]    100
    Dictionary Should Contain Value     ${response.json()}    Can


Delete Booking at Restful Booker
    #create header dectionary to save token key and value pairs of json to delete booking
    ${header}    Create Dictionary        cookie=token\=${token}
    #send DELETE request to the API to delete a booking with id and save response in variable(response) with header details
    ${response}    DELETE     url=https://restful-booker.herokuapp.com/booking/${id}    headers=${header}
    #cheack if it's deleted successfully
    Status Should Be    201     ${response}
    



    



*** Keywords ***
Authenticate as Admin
    #create dectionary to save username and password (key and value pairs of json)
    ${body} =       Create Dictionary    username=admin    password=password123

    #send requst to the API to get token using POST method and save response in variable(response)
    ${response} =   POST   https://restful-booker.herokuapp.com/auth   json=${body}
    
    #print value of response
    Log    ${response.json()}
    
    #set response value to variable token
    ${token} =    Set Variable   ${response.json()}[token]

    #print value of token
    Log  ${token}

    #set token as suite variable to use in other test cases(like global variable)
    Set Suite Variable        ${token}
    
    

