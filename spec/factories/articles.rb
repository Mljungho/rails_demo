FactoryBot.define do
  factory :article do
    title { 'Title' }
    content { 'changed to longer text for fun sake. This is a preset.' }
    after(:build) do |article|
      article.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'dummy_image.png')),
        filename: 'dummy_image.png',
        content_type: 'image/png'
      )
    end
  end
end
