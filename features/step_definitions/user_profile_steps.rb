Given /^I am in one of the same groups as another user$/ do
  @group = FactoryGirl.create(:group)
  @group.add_member!(@user)
  @other_user = FactoryGirl.create(:user)
  @group.add_member!(@other_user)
  @private_group = FactoryGirl.create(:group, viewable_by: 'members')
  @private_group.add_member!(@other_user)
  p @other_user.groups
end

Given /^I am not in any of the same groups as another user$/ do
  @group = FactoryGirl.create(:group)
  @group.add_member!(@user)
  @other_user = FactoryGirl.create(:user)
  @private_group = FactoryGirl.create(:group, viewable_by: 'members')
  @private_group.add_member!(@other_user)
end

Given /^another user exists$/ do
  @other_user = FactoryGirl.create(:user)
  @private_group = FactoryGirl.create(:group, viewable_by: 'members')
  @private_group.add_member!(@other_user)
end

When /^I visit the other user's profile page$/ do
  visit(user_path(@other_user))
end

Then /^I should see the other user's profile information$/ do
  page.should have_css(".users.show")
  page.should have_content(@other_user.email)
end

Then /^I should not see the other user's profile information$/ do
  page.should_not have_css(".users.show")
  page.should_not have_content(@other_user.email)
end

Then(/^I should see the public groups the other user is in$/) do
  page.should have_content(@group.name)
  page.should_not have_content(@private_group.name)
end

Then(/^I should not see any public group the other user is in$/) do
  page.should_not have_css("#user-groups-list")
end
