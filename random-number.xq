declare function xf:rand-lcg($seed as xs:integer) as xs:integer {
  (: Java LCG :)
  let $a := 25214903917     (: 0x5DEECE66DL  :)
  let $c := 11              (: 0xBL :)
  let $m := 281474976710656 (: 2 pow 48 :)
  let $result := ($a * $seed + $c) mod $m
  return
    $result idiv 16
};

