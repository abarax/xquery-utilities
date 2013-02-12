declare function xf:change-element-ns-deep($nodes as node()*, $newns as xs:string) as node()* 
{     
	for $node in $nodes
  	return 
  		if ($node instance of element()) then 
  		(
	  		element {fn:QName ($newns, local-name($node))}
	  		{
	  		  for $attribute in $node/attribute() 
	  		  return
	  		     attribute {fn:QName ($newns, fn:local-name($attribute))} {data($attribute)} 
	  		
	  		
            ,xf:change-element-ns-deep($node/node(), $newns)}
    	)
    	else if ($node instance of document-node()) then 
    		xf:change-element-ns-deep($node/node(), $newns)
    	else 
    		$node
 };

