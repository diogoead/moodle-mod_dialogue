@mod @mod_dialogue @javascript
Feature: Separate groups forced by the course apply to the dialogue activity
  As a student in a course that forces separate groups
  I need to see only teachers from my own group in the open with selector
  So that group separation is respected even when the activity has no group mode

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | teacher2 | Teacher   | 2        | teacher2@example.com |
      | teacher3 | Teacher   | 3        | teacher3@example.com |
      | student1 | Student   | 1        | student1@example.com |
    And the following "courses" exist:
      | fullname | shortname | groupmode | groupmodeforce |
      | Course 1 | C1        | 1         | 1              |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | teacher2 | C1     | editingteacher |
      | teacher3 | C1     | editingteacher |
      | student1 | C1     | student        |
    And the following "groups" exist:
      | name    | course | idnumber |
      | Class 1 | C1     | class1   |
      | Class 2 | C1     | class2   |
    And the following "group members" exist:
      | user     | group  |
      | teacher1 | class1 |
      | teacher3 | class1 |
      | student1 | class1 |
      | teacher2 | class2 |
    And the following "activities" exist:
      | activity | name          | course | idnumber  | groupmode |
      | dialogue | Test Dialogue | C1     | dialogue1 | 0         |

  Scenario: Student sees the group menu and only teachers from their own group
    Given I am on the "Test Dialogue" "dialogue activity" page logged in as student1
    Then I should see "Separate groups"
    When I click on "Create" "link"
    And I open the autocomplete suggestions list
    Then "Teacher 1" "autocomplete_suggestions" should exist
    And "Teacher 3" "autocomplete_suggestions" should exist
    And "Teacher 2" "autocomplete_suggestions" should not exist
