; Comments
(comment) @comment

; Directives
["" "" ""] @keyword.directive

; Resource record fields with proper context-based highlighting
(resource_record
  name: (domain_name) @variable.parameter
  ttl: (time_value) @number.time
  class: (record_class) @constant.builtin
  type: (record_type) @type.builtin
  data: (_) @string.special)

; Directive time values (different from record TTL)
(ttl_directive
  (time_value) @number.time)

; Record types and classes (when not in field context)
(record_type) @type.builtin
(record_class) @constant.builtin

; Special domain references
(domain_name) @variable
(domain_name "@") @variable.special

; Special symbols and punctuation
["@" "(" ")"] @punctuation.special

; Numbers in different contexts
(mx_data
  (number) @number.priority
  (domain_name) @string.special)

(srv_data
  (number) @number.priority
  (number) @number.weight  
  (number) @number.port
  (domain_name) @string.special)

(soa_data
  (domain_name) @string.special
  (domain_name) @string.special
  (number) @number.serial
  (time_value) @number.time
  (time_value) @number.time
  (time_value) @number.time
  (time_value) @number.time)

; IP addresses get special treatment
(ipv4_address) @constant.numeric
(ipv6_address) @constant.numeric

; Generic numbers and time values (fallback)
(number) @number
(time_value) @number.time

; Strings and paths
(quoted_string) @string
(file_path) @string.special.path

; TXT record data
(txt_data
  (quoted_string) @string)

; Generic data fallback
(generic_data
  (domain_name) @string.special
  (ipv4_address) @constant.numeric
  (ipv6_address) @constant.numeric
  (number) @number
  (quoted_string) @string)
