 

<html> 

<meta http-equiv="refresh" content="<?php 

	$hora = date("H"); 

	if ($hora > 9 && $hora < 12) 

		echo rand(1, 5); 

	elseif ($hora >= 12 && $hora < 14) 

		echo rand(20, 240); 

	elseif ($hora >= 14 && $hora < 18) 

		echo rand(1, 4); 

	elseif ($hora >= 18 && $hora < 20) 

		echo rand(60, 480); 

	else 

		echo rand(2000, 4000); 

?>"> 



<body> 

<?php 

	$f = fopen("/proc/net/netstat", 'r'); 

	while (!feof($f)) { 

		echo "<pre>" . fgets($f) . "</pre>"; 

	} 

	fclose($f); 

?> 

</body> 

</html> 	   

	 
