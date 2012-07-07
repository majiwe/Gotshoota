<?php
if(isset($_POST['xmlString'])) {
	$meinXMLString = stripslashes($_POST['xmlString']);
	$fp=fopen("../xml/highscore.xml","w");
	fputs($fp,$meinXMLString);
	fclose($fp);
	echo "loaded=1";
}
?>











