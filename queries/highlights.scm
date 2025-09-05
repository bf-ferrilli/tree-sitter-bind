; NOTE: add highlight queries here
; Comments
(comment) @comment

; Directives
["$TTL" "$ORIGIN" "$INCLUDE"] @keyword.directive

; Record types
(record_type) @type

; Record classes
(record_class) @constant.builtin

; Special symbols
["@" "(" ")"] @punctuation.special

; Numbers and time values
(number) @number
(time_value) @number

; IP addresses
(ipv4_address) @string.special
(ipv6_address) @string.special

; Domain names
(domain_name) @variable

; Strings
(quoted_string) @string

; File paths
(file_path) @string.special.path
