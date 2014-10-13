<!--
 * CO226: Lab 04
 * Web page could be used to order T-shirts online. (server side handle)
 *
 * Author : Marasinghe, M.M.D.B. (E/11/258) dhammikammdb123@gmail.com
 * Date : 2014/07/30
-->

<html>
	<body>
		<h1>Your Information System</h1>
		<?php
			$size = $_GET["size"];
			$colour = $_GET["colour"];
			$first_name = $_GET["first_name"];
			$last_name = $_GET["last_name"];
			$address1 = $_GET["address1"];
			$address2 = $_GET["address2"];
			$address3 = $_GET["address3"];
			$comments = $_GET["comments"];
		?>
		Thank you, <?php echo $first_name ?> for your purchase from our web site. </br></br>
		your item colour is: <?php echo $colour ?> & T-shirt size: <?php echo $size ?> </br></br>
		Selected items/item are: </br></br>
		<?php 
		if (!empty($_GET["cap"])){
			echo "* Cap </br>";
		}
		if (!empty($_GET["wrist_band"])){
			echo "* Wrist Band</br>";
		}
		?> </br>
		your items will be sent to: </br></br>
		<i><?php echo $first_name ." ". $last_name . ", </br>" . 
			$address1 . ", </br>" . 
			$address2 .", </br>" . 
			$address3 ?> </i></br></br>
		Thank you for submitting your comments. We appreciate it. You said. </br></br>
		<i><?php echo $comments ?></i>
	</body>
</html>