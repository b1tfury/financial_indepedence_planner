require 'rails_helper'


describe 'Routes to all controllers', :type => :routing do
  it 'routes /income_tax to income controller' do
    expect(:get => "/income_tax").to route_to(:controller => "income", :action => "show")
  end
end
