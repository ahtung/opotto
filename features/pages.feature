@javascript
Feature: pages
  In order to view the site
  A visitor
  Should be able to browse pages

  Scenario: Browse about page
    When I visit about page
    Then page should have translated "site.about_text" content