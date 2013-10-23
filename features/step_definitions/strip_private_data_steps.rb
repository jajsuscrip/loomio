Given(/^there is a private group with members, discussions, comments, and motions$/) do
  group = FactoryGirl.create :group, viewable_by: 'members'
  @group_id = group.id
  @membership_id = group.memberships.first.id
  discussion = FactoryGirl.create :discussion, group: group
  @discussion_id = discussion.id
  comment = FactoryGirl.create :comment, discussion: discussion
  @comment_id = comment.id
  motion = FactoryGirl.create :motion, discussion: discussion
  @motion_id = motion.id
end

When(/^I strip private data from the database$/) do
  StripPrivateData.go
end

Then(/^the group should be deleted$/) do
  Group.unscoped.where(id: @group_id).should == []
end

Then(/^all data associated with that group should be deleted$/) do
  Membership.unscoped.where(id: @membership_id).should == []
  Discussion.unscoped.where(id: @discussion_id).should == []
  Comment.unscoped.where(id: @comment_id).should == []
  Motion.unscoped.where(id: @motion_id).should == []
end

Given(/^there is a public group with members, discussions, comments, and motions$/) do
  group = FactoryGirl.create :group, viewable_by: 'everyone'
  @group_id = group.id
  @membership_id = group.memberships.first.id
  discussion = FactoryGirl.create :discussion, group: group
  @discussion_id = discussion.id
  comment = FactoryGirl.create :comment, discussion: discussion
  @comment_id = comment.id
  motion = FactoryGirl.create :motion, discussion: discussion
  @motion_id = motion.id
end

Then(/^the group should not be deleted$/) do
  Group.find_by_id(@group_id).should be_present
end

Then(/^no data associated with that group should be deleted$/) do
  Membership.unscoped.where(id: @membership_id).should be_present
  Discussion.unscoped.where(id: @discussion_id).should be_present
  Comment.unscoped.where(id: @comment_id).should be_present
  Motion.unscoped.where(id: @motion_id).should be_present
end
