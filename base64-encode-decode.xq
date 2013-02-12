declare function xf:base64-encode($b as xs:integer*) as xs:integer* {
    
    let $table := ( 65 to  90,  (: A-Z :)
                    97 to 122,  (: a-z :)
                    48 to  57,  (: 0-9 :)
                    43, 47 )    (: + / :)
                    
    for $byte0 at $p in $b
    where $p mod 3 = 1
    return
      let $byte1 as xs:integer? := $b[$p + 1]
      let $byte2 as xs:integer? := $b[$p + 2]

      (: Convert the three bytes into four characters :)
      let $c0 := $table[$byte0 idiv 4 +1]
      let $c1 := $table[sum((($byte0 mod 4)*16, $byte1 idiv 16)) +1]
      let $c2 := if (empty($byte1)) then 61 (: pad with = :)
                 else $table[sum((($byte1 mod 16)*4, $byte2 idiv 64)) + 1]
      let $c3 := if (empty($byte2)) then 61 (: pad with = :)
                 else $table[$byte2 mod 64 + 1]
      return ($c0, $c1, $c2, $c3)
  
};


declare function xf:base64-decode($b as xs:string) as xs:integer* {
    let $codepoints :=  string-to-codepoints($b) 
    let $table := ( 65 to  90,  (: A-Z :)
                    97 to 122,  (: a-z :)
                    48 to  57,  (: 0-9 :)
                    43, 47 )    (: + / :)
    return
    for $ch at $p in $codepoints
    where $p mod 4 = 1
    return
      let $c0 as xs:integer? := (index-of($table, $ch) - 1)
      let $c1 as xs:integer? := (index-of($table, $codepoints[$p + 1]) - 1)
      let $c2 as xs:integer? := (index-of($table, $codepoints[$p + 2]) - 1)
      let $c3 as xs:integer? := (index-of($table, $codepoints[$p + 3]) - 1)
      
      (: Convert the three bytes into four characters :)
      let $byte0 := ($c0 * 4) + ($c1 idiv 16)
      
      let $byte1 := (($c1 mod 16) * 16) +  ($c2 idiv 4)  
      
      let $byte2 := ($c2 mod 4) * 64 + ($c3 mod 64)
                 
      return ($byte0, $byte1, $byte2)

};

