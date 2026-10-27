@mod @mod_dialogue @javascript
Feature: Users with viewgroups see conversations that include any member of their groups
  As a mentor with the viewgroups capability
  I need to see the conversations that include members of the groups I mentor
  So that I can follow the communication within those groups

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
      | teacher2 | Teacher   | 2        | teacher2@example.com |
      | mentor1  | Mentor    | 1        | mentor1@example.com  |
      | student1 | Student   | 1        | student1@example.com |
      | student2 | Student   | 2        | student2@example.com |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | teacher2 | C1     | editingteacher |
      | mentor1  | C1     | teacher        |
      | student1 | C1     | student        |
      | student2 | C1     | student        |
    And the following "groups" exist:
      | name    | course | idnumber |
      | Class 1 | C1     | class1   |
      | Class 2 | C1     | class2   |
    And the following "group members" exist:
      | user     | group  |
      | teacher1 | class1 |
      | mentor1  | class1 |
      | student1 | class1 |
      | teacher2 | class2 |
      | student2 | class2 |
    And the following "activities" exist:
      | activity | name          | course | idnumber  |
      | dialogue | Test Dialogue | C1     | dialogue1 |
    And the following "permission overrides" exist:
      | capability              | permission | role    | contextlevel    | reference |
      | mod/dialogue:viewgroups | Allow      | teacher | Activity module | dialogue1 |
    And I am on the "Test Dialogue" "dialogue activity" page logged in as teacher1
    And I click on "Create" "link"
    And I open the autocomplete suggestions list
    And I click on "Student 1" item in the autocomplete list
    And I set the field "Subject" to "Teacher 1 and Student 1"
    And I set the field "Message" to "Hello Student 1"
    And I press "Send"
    And I click on "Create" "link"
    And I open the autocomplete suggestions list
    And I click on "Student 2" item in the autocomplete list
    And I set the field "Subject" to "Teacher 1 and Student 2"
    And I set the field "Message" to "Hello Student 2"
    And I press "Send"
    And I am on the "Test Dialogue" "dialogue activity" page logged in as teacher2
    And I click on "Create" "link"
    And I open the autocomplete suggestions list
    And I click on "Student 2" item in the autocomplete list
    And I set the field "Subject" to "Teacher 2 and Student 2"
    And I set the field "Message" to "Hello again Student 2"
    And I press "Send"

  Scenario: Mentor sees conversations that include a member of their group
    When I am on the "Test Dialogue" "dialogue activity" page logged in as mentor1
    Then I should see "Teacher 1 and Student 1"
    And I should see "Teacher 1 and Student 2"
    And I should not see "Teacher 2 and Student 2"
    And I click on "Teacher 1 and Student 2" "text"
    And I should see "Hello Student 2"
