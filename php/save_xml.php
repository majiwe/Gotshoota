<?php
if(isset($_POST['xmlString']) && 
	isset($_POST['id']) && 
	isset($_POST['time']) &&
	isset($_POST['gameData']) &&
	isset($_POST['punkte'])) {
	$hash = $_POST['id'];
	$time = $_POST['time'];
	$gameData = explode(",",$_POST['gameData']);
	$punkte = $_POST['punkte'];
	// 1. Stimmt die Punktzahl?
	if(count($gameData)*40 == $punkte && count($gameData) > 1) {
		$locHash = md5($gameData[0].$gameData[1].$time);
		// 2. Stimmt der Hashwert?
		if($locHash == $hash) {
			$meinXMLString = stripslashes($_POST['xmlString']);
			$fp=fopen("../xml/daten.xml","w");
			fputs($fp,$meinXMLString);
			fclose($fp);
			echo "loaded=1";
		} else {
			die();	
		}
	} else {
		die();	
	}
} else {
	die();	
}
?>











