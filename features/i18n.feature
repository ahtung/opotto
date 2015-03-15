Feature: i18n
  In order to use the site
  A visitor
  Should be able to browse the site in English or Turkish

  Scenario: Browse in English
    Given I have accept language tr
    When I visit root
    Then page should have "Tum haklari saklidir"

  Scenario: Browse in Turkish
    Given I have accept language en
    When I visit root
    Then page should have "All rights reserved"