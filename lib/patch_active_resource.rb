# Use this for debugging AR:

# module ActiveResource
#   class Connection
#     private

#     alias_method :original_request, :request

#     def request(method, path, *arguments)
#       puts "#{method} request.  path = #{path}"
#       puts arguments.inspect
#       original_request(method, path, *arguments)
#     end

#     alias_method :original_handle_response, :handle_response

#     def handle_response(response)
#       puts "incoming request response = " + response.body.inspect
#       if (response.code.to_i == 422) and (!response.body.starts_with?('{errors'))
#         response.body = "{errors:#{response.body}}"
#         puts "outgoing request response = " + response.body.inspect
#       end
#       original_handle_response(response)
#     end
#   end
# end

# You can test with this:
# task = Quality::InspectionTask.status_open.last ; task.lighthouse_ticket.body = 'hello world' ; task.lighthouse_ticket.save

ActiveResource::Base.include_root_in_json = true
