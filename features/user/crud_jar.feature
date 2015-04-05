@javascript
Feature: Jar CRUD
  In order to use opotto
  A User
  Should be able to CRUD jars

  Scenario: Create Jar
    When I sign in as a user with Google
     And create a jar
    Then page should have translated "jar.created" content
  Scenario: Read Jar
    When I sign in as a user with Google
     And create a jar
    Then page should have translated "jar.title" content
  Scenario: Update Jar
    When I sign in as a user with Google
     And create a jar
    Then page should have translated "jar.updated" content
  Scenario: Destroy Jar
    When I sign in as a user with Google
     And create a jar
    Then page should have translated "jar.deleted" content