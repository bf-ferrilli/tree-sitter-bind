; Comments
(comment) @comment

; Directives
["" "" ""] @keyword.directive

; Resource record fields with proper context-based highlighting
(resource_record
  name: (domain_name) @entity.name.tag
  ttl: (time_value) @constant.numeric.time
  class: (record_class) @constant.builtin
  type: (record_type) @type.builtin
  data: (_) @string.special)

; Directive time values (different from record TTL)  
(ttl_directive
  (time_value) @constant.numeric.time)

; Record types and classes (when not in field context)
(record_type) @type.builtin
(record_class) @constant.builtin

; Domain names in different contexts
; Record names (left side) - entity names
(resource_record name: (domain_name) @entity.name.tag)
; Domain names in data (right side) - strings
(domain_name) @variable.other

; Special domain references
(domain_name "@") @constant.builtin.special

; Special symbols and punctuation
["@" "(" ")"] @punctuation.special

; Numbers in different contexts - using different highlight categories
(mx_data
  (number) @variable.parameter.priority
  (domain_name) @string.other.target)

(srv_data
  (number) @variable.parameter.priority
  (number) @variable.parameter.weight  
  (number) @variable.parameter.port
  (domain_name) @string.other.target)

(soa_data
  (domain_name) @string.other.server
  (domain_name) @string.other.email
  (number) @constant.numeric.serial
  (time_value) @constant.numeric.time
  (time_value) @constant.numeric.time
  (time_value) @constant.numeric.time
  (time_value) @constant.numeric.time)

; IP addresses get special treatment - more distinct
(ipv4_address) @constant.numeric.address
(ipv6_address) @constant.numeric.address

; Generic numbers and time values (fallback)
(number) @number
(time_value) @constant.numeric.time

; Strings and paths
(quoted_string) @string
(file_path) @string.special.path

; TXT record data
(txt_data
  (quoted_string) @string)

; Generic data fallback with more specific targeting
(generic_data
  (domain_name) @string.other.target
  (ipv4_address) @constant.numeric.address
  (ipv6_address) @constant.numeric.address
  (number) @number
  (quoted_string) @string)
