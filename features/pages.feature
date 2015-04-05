@javascript
Feature: Pages
  In order to view the site
  A visitor
  Should be able to browse pages

  Scenario: Browse about page
    When I visit "page_path('about')"
    Then page should have translated "site.about_text" content

  Scenario: Browse contact page
    When I visit "page_path('contact')"
    Then page should have translated "site.contact" content

  Scenario: Browse secuirty page
    When I visit "page_path('security')"
    Then page should have translated "site.security" content