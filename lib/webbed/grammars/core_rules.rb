require "parslet"

module Webbed
  module Grammars
    module CoreRules
      include Parslet

      rule(:alpha) { match["A-Za-z"] }
      rule(:bit) { match["01"] }
      rule(:char) { match["\x01-\x7F"] }
      rule(:cr) { str("\x0D") }
      rule(:crlf) { cr >> lf }
      rule(:ctl) { match["\x00-\x1F\x7F"] }
      rule(:digit) { match["0-9"] }
      rule(:dquote) { str('"') }
      rule(:hexdig) { digit || match["A-F"] }
      rule(:htab) { str("\x09") }
      rule(:lf) { str("\x0A") }
      rule(:lwsp) { (wsp | crlf >> wsp).repeat }
      rule(:octet) { match["\x00-\xFF"] }
      rule(:sp) { str(" ") }
      rule(:vchar) { match["\x21-\x7E"] }
      rule(:wsp) { sp | htab }

      rule(:ows) { wsp.repeat }
      rule(:rws) { wsp.repeat(1) }
      rule(:bws) { ows }
      rule(:word) { token | quoted_string }
      rule(:token) { tchar.repeat(1) }
      rule(:tchar) { match["!\#$%&'*+\\-.^_`|~"] | digit | alpha }
      rule(:special) { match["()<>@,;:\\\\\"\\/\\[\\]?={}"] }
      rule(:quoted_string) { dquote >> (qdtext | quoted_pair).repeat >> dquote }
      rule(:qdtext) { ows | match["\x21\x23-\x5B\x5D-\x7E"] | obs_text }
      rule(:obs_text) { match["\x80-\xFF"] }
      rule(:quoted_pair) { str("\\") >> (wsp | vchar | obs_text) }
      rule(:comment) { str("(") >> (ctext | quoted_cpair | comment).repeat >> str(")") }
      rule(:ctext) { ows | match["\x21-\x27\x2A-\x5B\x5D-\x7E"] | obs_text }
      rule(:quoted_cpair) { quoted_pair }
    end
  end
end
