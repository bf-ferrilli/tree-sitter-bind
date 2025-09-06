module.exports = grammar({
  name: "bind",
  extras: ($) => [/\s+/],
  rules: {
    source_file: ($) => repeat($._item),
    _item: ($) => choice(
      $.comment,
      $.directive,
      $.record,
      /.*/ // Fallback to match anything
    ),
    comment: ($) => /;[^\r\n]*/,
    directive: ($) => /\$[A-Z]+\s+\S+/,
    record: ($) => /\S+\s+(IN\s+)?(A|AAAA|CNAME|MX|NS|PTR|SOA|SRV|TXT|HINFO)\s+.*/
  }
});
