describe "Imports integration" do
  before do
    Capybara.current_driver = Capybara.javascript_driver
    page.driver.headers = { "Authorization" => ActionController::HttpAuthentication::Basic.encode_credentials("frodo", "thering") }
    visit imports_path
  end

  it "has the right title" do
    assert page.has_title?("Imports").must_equal true
  end
end
