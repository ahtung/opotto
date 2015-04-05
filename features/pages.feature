@javascript
Feature: Pages
  In order to view the site
  A visitor
  Should be able to browse pages

  Scenario: Browse about page
    When I visit "about"
    Then page should have translated "site.about.content" content

  Scenario: Browse contact page
    When I visit "contact"
    Then page should have translated "site.contact" content

  Scenario: Browse secuirty page
    When I visit "security"
    Then page should have translated "site.security" content