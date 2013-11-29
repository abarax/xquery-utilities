 declare function xf:left-pad-string-to-length
  ( $stringToPad as xs:string? ,
    $padChar as xs:string ,
    $length as xs:integer )  as xs:string {
       
   substring(
     string-join (
       (for $i in (1 to $length - string-length($stringToPad)) return $padChar, $stringToPad)
       ,'')
    ,1,$length)
 } ;
