#
# Copyright 2015, SUSE Linux GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "simplecov"

if ENV["CODECLIMATE_REPO_TOKEN"]
  require "coveralls"
  require "codeclimate-test-reporter"

  Coveralls.wear!

  SimpleCov.start do
    add_filter "/spec"

    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      CodeClimate::TestReporter::Formatter
    ]
  end
else
  SimpleCov.start do
    add_filter "/spec"
  end
end

require "crowbar/client"
require "rspec"
require "webmock/rspec"

WebMock.disable_net_connect!(
  allow: "codeclimate.com"
)

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each do |f|
  require f
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"

  config.include HelperMethods
end
