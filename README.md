# HT Booking API
This project is a simple Ruby on Rails application that demonstrates a scalable approach to parsing and saving multiple payloads.

For simplicity purpose when setting and running the project, this project uses all default configurations including SQLite as the database and minitest as the testing framework.

To foster a culture of 'continuous integration' and 'automated testing', we have setup GitHub Actions to automatically run tests whenever a push or pull request is made.

## Table of contents
1. [Getting Started](#getting-started)
2. [Running the Tests](#running-the-tests)
3. [Automated Tests with GitHub Actions](#automated-tests-with-github-actions)
4. [API Authentication](#api-authentication)
5. [API Usage](#api-usage)
6. [License](#license)

## Getting Started
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

1. Ruby - Version 3.2.2 and above
2. Rails - Version 7.0.6 and above
3. SQLite

### Installing
* Clone this repository to your local machine using:
  ```
  git clone https://github.com/IrvanFza/ht-booking-api.git
  ```
* Go to project directory:
  ```
  cd ht-booking-api
  ```
* Install all dependencies:
  ```
  bundle install
  ```
* Create database:
  ```
  rails db:create
  ```
* Apply migration to the database:
  ```
  rails db:migrate
  ```
* To start the server:
  ```
  rails server
  ```

## Running the Tests
The system comes with a suite of tests that ensure code quality and application's behavior. Run the following command in your terminal to execute all the tests:
```
rails test
```

## Automated Tests with GitHub Actions
The project is configured with GitHub Actions to automatically run the test suite on every push or pull request event.
This helps us maintain code quality and detect any breaking changes early in the development lifecycle.
You can view the results of these tests in the Actions tab of the project's GitHub page.

## API Authentication
The API uses a simple authentication mechanism to ensure that only authorized users can access the API. The API expects a `API-Key` header to be present in the request.

The values for the header can be found in the Rails credentials. To access the credentials, run the following command in your terminal:
```
rails credentials:show
```

That command will require you to enter the master key. Please contact the project owner to get the master key.

## API Usage
The API provides one primary endpoint to create and update the booking data:
* Endpoint: `/api/v1/bookings`
* Method: `POST`
* Example Payloads:

  Payload #1
  ```
  {
    "reservation_code": "YYY12345678",
    "start_date": "2021-04-14",
    "end_date": "2021-04-18",
    "nights": 4,
    "guests": 4,
    "adults": 2,
    "children": 2,
    "infants": 0,
    "status": "accepted",
    "guest": {
      "first_name": "Wayne",
      "last_name": "Woodbridge",
      "phone": "639123456789",
      "email": "wayne_woodbridge@bnb.com"
    },
    "currency": "AUD",
    "payout_price": "4200.00",
    "security_price": "500",
    "total_price": "4700.00"
  }
  ```

  Payload #2
  ```
  {
    "reservation": {
      "code": "XXX12345678",
      "start_date": "2021-03-12",
      "end_date": "2021-03-16",
      "expected_payout_amount": "3800.00",
      "guest_details": {
        "localized_description": "4 guests",
        "number_of_adults": 2,
        "number_of_children": 2,
        "number_of_infants": 0
      },
      "guest_email": "wayne_woodbridge@bnb.com",
      "guest_first_name": "Wayne",
      "guest_last_name": "Woodbridge",
      "guest_phone_numbers": [
        "639123456789",
        "639123456789"
      ],
      "listing_security_price_accurate": "500.00",
      "host_currency": "AUD",
      "nights": 4,
      "number_of_guests": 4,
      "status_type": "accepted",
      "total_paid_amount_accurate": "4300.00"
    }
  }
  ```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.