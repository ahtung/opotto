@javascript
Feature: Pages
  In order to view the site
  A visitor
  Should be able to browse pages

  Scenario: Browse about page
    When I visit about page
    Then page should have translated "site.about_text" content

  Scenario: Contact
    When I visit Contact Page
    Then page should have "Seven things to know about Kickstarter"
