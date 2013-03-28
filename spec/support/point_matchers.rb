require 'rspec'

RSpec::Matchers.define :have_checkers do |color, checker_count| 
  match do |actual|
    actual.color.try(:to_sym) == color && actual.checker_count == checker_count
  end
end

RSpec::Matchers.define :have_no_checkers do 
  match do |actual|
    actual.color.nil? && !!actual.checker_count
  end
end

