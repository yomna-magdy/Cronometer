Feature: Restful Booker API Testing

  Background:
    * url 'https://restful-booker.herokuapp.com'

  Scenario: Get Bookings with First Name Ali
    Given path 'booking'
    And param firstname = 'Ali'
    When method get
    Then status 200
    And print response

    * def bookings = response
    * def bookingIds = []
    * for (var i in bookings) bookingIds.push(bookings[i].bookingid)
    * print bookingIds

    * for (var id in bookingIds)
      Given path 'booking', id
      When method get
      Then print response

  Scenario: Create a Booking
    * def booking_dates = { checkin: '2022-12-31', checkout: '2023-01-01' }
    * def body = { firstname: 'Ali', lastname: 'Can', totalprice: 100, depositpaid: true, bookingdates: booking_dates }
    Given path 'booking'
    And request body
    When method post
    Then status 200
    And def bookingid = response.bookingid
    And print bookingid

    Given path 'booking', bookingid
    When method get
    Then status 200
    And match response.lastname == 'Can'
    And match response.firstname == 'Ali'
    And match response.totalprice == 100
    And match response contains { lastname: 'Can' }

  Scenario: Delete Booking
    * def token = call read('token-generator.feature')
    * def header = { cookie: 'token=' + token }
    Given path 'booking', bookingid
    And headers header
    When method delete
    Then status 201
