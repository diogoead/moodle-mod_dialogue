@mod @mod_dialogue @javascript
Feature: Recipient search respects group membership in separate groups mode
  As a student in a dialogue activity using separate groups
  I want the recipient search to consider only the members of my groups
  So that the recipient is auto-selected only when there is a single one

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | teacher2 | Teacher   | 2        | teacher2@example.com |
      | student1 | Student   | 1        | student1@example.com |
      | student2 | Student   | 2        | student2@example.com |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | teacher2 | C1     | editingteacher |
      | student1 | C1     | student        |
      | student2 | C1     | student        |
    And the following "groups" exist:
      | name    | course | idnumber |
      | Class 1 | C1     | class1   |
      | Class 2 | C1     | class2   |
    And the following "group members" exist:
      | user     | group  |
      | teacher1 | class1 |
      | teacher1 | class2 |
      | teacher2 | class2 |
      | student2 | class1 |
      | student2 | class2 |
    And the following "activities" exist:
      | activity | name          | course | idnumber  | usecoursegroups |
      | dialogue | Test Dialogue | C1     | dialogue1 | 1               |

  Scenario: Student without a group opens the create form and finds no recipients
    Given I am on the "Test Dialogue" "dialogue activity" page logged in as student1
    When I click on "Create" "link"
    And I open the autocomplete suggestions list
    Then "Subject" "field" should exist
    And "Teacher 1" "autocomplete_suggestions" should not exist

  Scenario: Student sharing several groups with a teacher still sees every recipient
    Given I am on the "Test Dialogue" "dialogue activity" page logged in as student2
    When I click on "Create" "link"
    And I open the autocomplete suggestions list
    Then "Teacher 1" "autocomplete_suggestions" should exist
    And "Teacher 2" "autocomplete_suggestions" should exist
