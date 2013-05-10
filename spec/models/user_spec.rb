require 'spec_helper'

describe User do
  it "has required attr first_name, last_name, email, role" do
    @user = User.new 
    @user.save.should == false
    @user.update_attributes(
    first_name: "john",
    last_name: "davison",
    email: "john@john",
    role: "boot"
    ).should == true
  end

  it "has optional attributes pic, contact_phone, contact_email, active, deleted" do
    @user = create :user
    @user.should respond_to(:pic, :contact_phone, :contact_email, :active, :deleted)
  end
end
