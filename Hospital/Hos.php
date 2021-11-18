<?php
	require_once("DBHospital.php");
	
	$FirstNameP = $_POST['FirstNameP'];
	$LastNameP = $_POST['LastNameP'];
	$OtchesNameP=$_POST['OtchesNameP'];
	$PacEmail = $_POST['PacEmail'];
	$RecData = $_POST['RecData'];
	$RecTime = $_POST['RecTime'];
	$FirstLastNameD = $_POST['FirstLastNameD'];
	
	
	
	$select_Dnote=mysqli_query($link,"Select idP,receptionData,receptiomTime,idD FROM pacient WHERE idD='$FirstLastNameD' AND
																										receptionData='$RecData' AND
																								receptiomTime='$RecTime'");
	$s=mysqli_fetch_array($select_Dnote);
	if($s)
	{
		
		$alert="На данное время &nbsp $RecData &nbsp занято";
		echo json_encode(array('result' => $alert));
	}
	else{
		
		$note="INSERT INTO pacient(idP,FirstNamePacient,LastNamePacient,OtchesNamePacient,receptionData,receptiomTime,EmailPacient,idD)
								VALUES(NULL,'$FirstNameP','$LastNameP','$OtchesNameP','$RecData','$RecTime','$PacEmail','$FirstLastNameD')";
			$result=mysqli_query($link,$note);
			$alert="Запись прошла успешно и отправлена на почту";
			echo json_encode(array('result' => $alert));
			$message="Здравствуйе".' '.$LastNameP.' '.$OtchesNameP.' '."вы записаны к врачу".' '.$RecData.' '."на".' '.$RecTime;
			
				$mail_to=$PacEmail;
				$subject="Запись к врачу";
				$message = wordwrap($message, 70, "\r\n");
				mail($mail_to,$subject,$message);
			
    
			
			
	}
	
    ?>