require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :email }
end
