; Comments - subdued
(comment) @comment

; Directives - prominent keywords  
(ttl_directive) @keyword.directive
(origin_directive) @keyword.directive
(include_directive) @keyword.directive

; Record types - very prominent, colored by category
(record_type "SOA") @keyword.control
(record_type "NS") @keyword.control
(record_type "MX") @type.builtin
(record_type "A") @type
(record_type "AAAA") @type
(record_type "CNAME") @function.builtin
(record_type "PTR") @function.builtin
(record_type "TXT") @string.special.symbol
(record_type "SRV") @variable.builtin
(record_type) @type.builtin

; Record classes - distinct from types
(record_class "IN") @constant
(record_class) @constant

; TTL values - make them stand out from regular numbers
(resource_record ttl: (time_value) @number.float)
(ttl_directive (time_value) @number.float)

; Domain names - context-aware coloring
(resource_record name: (domain_name) @variable.other.member)
(domain_name "@") @operator
(soa_data (domain_name) @string.regexp)
(mx_data (domain_name) @string.regexp)
(srv_data (domain_name) @string.regexp)
(generic_data (domain_name) @string.regexp)
(domain_name) @variable

; IP addresses - network literals
(ipv4_address) @number.hex
(ipv6_address) @number.hex

; Numbers in different contexts
(mx_data (number) @number.integer)
(srv_data (number) @number.integer (number) @number.integer (number) @number.integer)
(soa_data (number) @number.integer)
(number) @number
(time_value) @number

; String content
(quoted_string) @string
(txt_data (quoted_string) @string)
(file_path) @string.special.path

; Punctuation
["(" ")"] @punctuation.bracket
