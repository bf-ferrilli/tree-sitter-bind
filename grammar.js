/**
 * @file Bind grammar for tree-sitter
 * @author Brandon Froehlich
 * @license MIT
 */

/// <reference types="tree-sitter-cli/dsl" />
// @ts-check

module.exports = grammar({
  name: "bind",

  conflicts: ($) => [[$.txt_data, $.generic_data]],

  extras: ($) => [
    /[ \t]/, // Only horizontal whitespace, not newlines
    $.comment,
  ],

  rules: {
    source_file: ($) => repeat($._line),

    _line: ($) => choice(seq(optional($._statement), $._newline)),

    _statement: ($) => choice($.directive, $.resource_record),

    _newline: ($) => /\r?\n/,

    comment: ($) =>
      token(
        choice(
          seq(";", /.*/),
          seq("//", /.*/),
          seq("/*", /[^*]*\*+([^/*][^*]*\*+)*/, "/"),
        ),
      ),

    directive: ($) =>
      choice($.ttl_directive, $.origin_directive, $.include_directive),

    ttl_directive: ($) => seq("$TTL", $.time_value),

    origin_directive: ($) => seq("$ORIGIN", $.domain_name),

    // Remove the optional domain_name to avoid conflict
    include_directive: ($) => seq("$INCLUDE", $.file_path),

    resource_record: ($) =>
      seq(
        field("name", $.domain_name),
        optional(field("ttl", $.time_value)),
        optional(field("class", $.record_class)),
        field("type", $.record_type),
        field("data", $.record_data),
      ),

    domain_name: ($) =>
      choice(
        "@",
        token(
          prec(
            2, // Higher precedence than number to avoid splitting
            // Domain names can start with digits but must contain letters or dots
            /[a-zA-Z0-9_*][a-zA-Z0-9\-_*]*(\.[a-zA-Z0-9_*][a-zA-Z0-9\-_*]*)*\.?/,
          ),
        ),
      ),

    time_value: ($) => /\d+[smhdw]?/,

    record_class: ($) => choice("IN", "CS", "CH", "HS"),

    record_type: ($) =>
      choice(
        "A",
        "AAAA",
        "AFSDB",
        "APL",
        "CAA",
        "CDNSKEY",
        "CDS",
        "CERT",
        "CNAME",
        "CSYNC",
        "DHCID",
        "DLV",
        "DNAME",
        "DNSKEY",
        "DS",
        "EUI48",
        "EUI64",
        "HINFO",
        "HIP",
        "HTTPS",
        "IPSECKEY",
        "KEY",
        "KX",
        "LOC",
        "MX",
        "NAPTR",
        "NS",
        "NSEC",
        "NSEC3",
        "NSEC3PARAM",
        "OPENPGPKEY",
        "PTR",
        "RRSIG",
        "RP",
        "SIG",
        "SMIMEA",
        "SOA",
        "SPF",
        "SRV",
        "SSHFP",
        "SVCB",
        "TA",
        "TKEY",
        "TLSA",
        "TSIG",
        "TXT",
        "URI",
        "ZONEMD",
      ),

    record_data: ($) =>
      choice($.soa_data, $.mx_data, $.srv_data, $.txt_data, $.generic_data),

    soa_data: ($) =>
      prec(
        2,
        seq(
          $.domain_name, // MNAME
          $.domain_name, // RNAME
          "(",
          // Allow any content between parentheses, but only capture the structured data
          optional(repeat(choice($._newline, /[ \t]+/))),
          $.number, // serial
          optional(repeat(choice($._newline, /[ \t]+/))),
          $.time_value, // refresh
          optional(repeat(choice($._newline, /[ \t]+/))),
          $.time_value, // retry
          optional(repeat(choice($._newline, /[ \t]+/))),
          $.time_value, // expire
          optional(repeat(choice($._newline, /[ \t]+/))),
          $.time_value, // minimum
          optional(repeat(choice($._newline, /[ \t]+/))),
          ")",
        ),
      ),

    mx_data: ($) =>
      prec(
        2,
        seq(
          $.number, // priority
          $.domain_name, // exchange
        ),
      ),

    srv_data: ($) =>
      prec(
        2,
        seq(
          $.number, // priority
          $.number, // weight
          $.number, // port
          $.domain_name, // target
        ),
      ),

    txt_data: ($) => repeat1($.quoted_string),

    generic_data: ($) =>
      prec(
        -1,
        repeat1(
          choice(
            prec(2, $.ipv4_address),
            prec(2, $.ipv6_address),
            $.number,
            $.quoted_string,
            $.domain_name,
          ),
        ),
      ),

    ipv4_address: ($) => token(prec(3, /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)),

    ipv6_address: ($) => /([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}/,

    number: ($) => /\d+/,

    quoted_string: ($) => seq('"', repeat(choice(/[^"\\]+/, /\\./)), '"'),

    // More restrictive file path that won't consume following tokens
    file_path: ($) => /[^\s;]+/,
  },
});
