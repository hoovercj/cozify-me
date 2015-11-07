require 'rails_helper'

RSpec.describe "rules/index", type: :view do
  before(:each) do
    assign(:rules, [
      Rule.create!(
        :rule_type => "MyText",
        :name => "MyText",
        :description => "MyText",
        :summary => "MyText",
        :capabilities => "MyText",
        :code => "MyText"
      ),
      Rule.create!(
        :rule_type => "MyText",
        :name => "MyText",
        :description => "MyText",
        :summary => "MyText",
        :capabilities => "MyText",
        :code => "MyText"
      )
    ])
  end

  it "renders a list of rules" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
