FactoryGirl.define do
  factory :asset do
    name "image.png"
    content_type "image/png"
    size 123
    path "value/to/some/path"
  end
end
