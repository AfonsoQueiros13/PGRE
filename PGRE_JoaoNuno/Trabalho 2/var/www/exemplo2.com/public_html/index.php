<html> 

<meta http-equiv="refresh" content="<?php 

	$hora=date("H"); 

	if($hora>8 && $hora<=18) { 

		echo rand(1,60); 

	} else if($hora>18 && $hora<=23) { 

		echo rand(60,120); 

	} else if($hora>23 && $hora<=8) { 

		echo rand(500,900); 

	} 

?>"> 



<body>

<?php 

	$output = shell_exec('netstat -n'); 

	echo "<pre>".$output."</pre>"; 

	$output = shell_exec('cat /proc/net/arp'); 

	echo "<pre>".$output."</pre>"; 

?> 

</body> 

</html> 
