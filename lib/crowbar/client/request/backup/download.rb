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

require "easy_diff"

module Crowbar
  module Client
    module Request
      module Backup
        #
        # Implementation for the backup download request
        #
        class Download < Base
          def headers
            super.easy_merge!(
              Crowbar::Client::Util::ApiVersion.new(Config.apiversion).headers
            )
          end

          #
          # HTTP method that gets used by the request
          #
          # @return [Symbol] the method for the request
          #
          def method
            :get
          end

          #
          # Path to the API endpoint for the request
          #
          # @return [String] path to the API endpoint
          #
          def url
            case Config.apiversion
            when 1.0
              [
                "utils",
                "backups",
                attrs.name,
                "download"
              ]
            when 2.0
              [
                "api",
                "crowbar",
                "backups",
                attrs.name,
                "download"
              ]
            end.join("/")
          end
        end
      end
    end
  end
end
