require 'rails_helper'

RSpec.describe "rules/show", type: :view do
  before(:each) do
    @rule = assign(:rule, Rule.create!(
      :rule_type => "MyText",
      :name => "MyText",
      :description => "MyText",
      :summary => "MyText",
      :capabilities => "MyText",
      :code => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
