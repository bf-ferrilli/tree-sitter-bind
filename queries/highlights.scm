; Comments
(comment) @comment

; Directives
(ttl_directive) @keyword.directive
(origin_directive) @keyword.directive 
(include_directive) @keyword.directive

; Resource record types with categorization
(record_type "SOA") @type.builtin.zone
(record_type "NS") @type.builtin.zone
(record_type "MX") @type.builtin.mail
(record_type "A") @type.builtin.address
(record_type "AAAA") @type.builtin.address
(record_type "CNAME") @type.builtin.alias
(record_type "PTR") @type.builtin.alias
(record_type "TXT") @type.builtin.text
(record_type "SRV") @type.builtin.service
(record_type) @type.builtin

; Record classes
(record_class) @constant.builtin

; Domain names with context-aware highlighting
(resource_record name: (domain_name) @entity.name.function)

; Special @ symbol for zone root
(domain_name "@") @keyword.operator

; Domain names in record data
(soa_data (domain_name) @string.special)
(mx_data (domain_name) @string.special)
(srv_data (domain_name) @string.special)
(generic_data (domain_name) @variable.other)

; Other domain names
(domain_name) @variable.other.member

; Punctuation
["(" ")"] @punctuation.bracket

; Numbers with context-specific highlighting
(mx_data (number) @number.priority)
(srv_data (number) @number.priority (number) @number.weight (number) @number.port)
(soa_data (number) @number.serial)

; IP addresses
(ipv4_address) @string.special.address
(ipv6_address) @string.special.address

; Time values
(time_value) @number.time

; Generic numbers
(number) @number

; Strings
(quoted_string) @string.quoted.double
(file_path) @string.special.path
