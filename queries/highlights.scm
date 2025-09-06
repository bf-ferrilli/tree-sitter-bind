; Comments
(comment) @comment

; Directives
["" "" ""] @keyword.directive

; Resource record fields with MUCH more distinct highlighting
(resource_record
  name: (domain_name) @entity.name.function
  ttl: (time_value) @markup.italic
  class: (record_class) @constant.builtin
  type: (record_type) @type.builtin
  data: (_) @string.special)

; Directive time values - make them stand out more
(ttl_directive
  (time_value) @markup.bold)

; Record types and classes
(record_type) @type.builtin
(record_class) @constant.builtin

; Domain names with MUCH better differentiation
; Record names (left column) - make them standout entities
(resource_record name: (domain_name) @entity.name.function)

; Special @ symbol
(domain_name "@") @keyword.operator

; Domain names in record data - target destinations
(mx_data (domain_name) @string.regexp)
(srv_data (domain_name) @string.regexp)
(soa_data (domain_name) @string.regexp (domain_name) @string.regexp)
(generic_data (domain_name) @string.regexp)

; All other domain names fallback
(domain_name) @variable.other.member

; Punctuation
["@" "(" ")"] @punctuation.special

; Numbers with AGGRESSIVE differentiation by context
; MX priorities - make them pop
(mx_data
  (number) @markup.underline.priority)

; SRV numbers - each gets different treatment  
(srv_data
  (number) @markup.underline.priority
  (number) @variable.parameter.weight
  (number) @constant.character.port)

; SOA numbers - serial vs times
(soa_data
  (number) @constant.numeric.hex
  (time_value) @markup.italic
  (time_value) @markup.italic
  (time_value) @markup.italic
  (time_value) @markup.italic)

; IP addresses - make them REALLY stand out
(ipv4_address) @string.escape
(ipv6_address) @string.escape

; TTL values in records - different from directive TTL
(resource_record ttl: (time_value) @markup.italic)

; Generic fallbacks
(number) @number
(time_value) @markup.italic

; Strings
(quoted_string) @string
(file_path) @string.special.path

; TXT record content - make quoted strings more obvious
(txt_data
  (quoted_string) @string.quoted.double)
