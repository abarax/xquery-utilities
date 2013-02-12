declare function local:remove-duplicates($list) {
  if (fn:empty($list)) then ()
  else 
    let $head := $list[1]
    let $tail := $list[position() > 1]
    return
      if ($head = $tail) then local:remove-duplicates($tail)
      else ($head, local:remove-duplicates($tail))
};

