Feature: Strip Private Data
  As a an admin
  So that I can take production data and make it safe for distribution
  I want to be able to delete all private data from a database

  Scenario: Loomio admin wipes all private data when calling strip private data
    Given there is a private group with members, discussions, comments, and motions
    When I strip private data from the database
    Then the group should be deleted
    And all data associated with that group should be deleted

  Scenario: Loomio admin preserves all public data when calling strip private data
    Given there is a public group with members, discussions, comments, and motions
    When I strip private data from the database
    Then the group should not be deleted
    And no data associated with that group should be deleted
