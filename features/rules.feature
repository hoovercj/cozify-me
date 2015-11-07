Feature: Add a new rule

  As a cozify user
  So that I can share my rules with others
  I want to add new rules to cozify-me
  
Background: I am on the new rule page

  When I go to the new rules page

Scenario: can't find similar movies if we don't know director (sad path)
  Given I am on the details page for "Alien"
  Then  I should not see "Ridley Scott"
  When  I follow "Find Movies With Same Director"
  Then  I should be on the home page
  And   I should see "'Alien' has no director info"