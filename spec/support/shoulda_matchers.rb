Shoulda::Matchers.configure do |config|
    config.integrate do |with|
        with.test_framework :RSpec
        with.library :Rails
    end
end