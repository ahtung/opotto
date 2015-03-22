@javascript
Feature: Pages
  In order to view the site
  A visitor
  Should be able to browse pages

  Scenario: Contact
    When I visit Contact Page
    Then page should have "Seven things to know about Kickstarter"
