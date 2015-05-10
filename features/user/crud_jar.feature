@javascript
Feature: Jar CRUD
  In order to use opotto
  A User
  Should be able to CRUD jars

  @focus
  Scenario: Create Jar
    When I sign in with "dunyakirkali@gmail.com"
     And create a jar
    Then page should have translated "jar.created" content
  Scenario: Read Jar
    When I sign in with "dunyakirkali@gmail.com"
     And read a jar
    Then page should have translated "jar.title" content
  Scenario: Update Jar
    When I sign in with "dunyakirkali@gmail.com"
     And update a jar
    Then page should have translated "jar.updated" content
  Scenario: Destroy Jar
    When I sign in with "dunyakirkali@gmail.com"
     And destroy a jar
    Then page should have translated "jar.deleted" content