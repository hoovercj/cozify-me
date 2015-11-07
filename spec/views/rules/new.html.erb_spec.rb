require 'rails_helper'

RSpec.describe "rules/new", type: :view do
  before(:each) do
    assign(:rule, Rule.new(
      :rule_type => "MyText",
      :name => "MyText",
      :description => "MyText",
      :summary => "MyText",
      :capabilities => "MyText",
      :code => "MyText"
    ))
  end

  it "renders new rule form" do
    render

    assert_select "form[action=?][method=?]", rules_path, "post" do

      assert_select "textarea#rule_rule_type[name=?]", "rule[rule_type]"

      assert_select "textarea#rule_name[name=?]", "rule[name]"

      assert_select "textarea#rule_description[name=?]", "rule[description]"

      assert_select "textarea#rule_summary[name=?]", "rule[summary]"

      assert_select "textarea#rule_capabilities[name=?]", "rule[capabilities]"

      assert_select "textarea#rule_code[name=?]", "rule[code]"
    end
  end
end
