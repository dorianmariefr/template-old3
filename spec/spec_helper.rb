# typed: strict
require_relative "../lib/template"

RSpec.configure do |config|
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true
  config.default_formatter = "doc"
  config.order = :random
  Kernel.srand config.seed
end
