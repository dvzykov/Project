<?php require_once("DBHospital.php");?>
<html>
    <head>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	<script>
        $(document).ready(function(){
            $('#btn_submit').click(
				function(){
                // собираем данные с формы
                var FirstNameP    = $('#FirstNameP').val();
                var LastNameP   = $('#LastNameP').val();
                var OtchesNameP = $('#OtchesNameP').val();
				var PacEmail = $('#PacEmail').val();
				var RecData = $('#RecData').val();
				var RecTime = $('#RecTime').val();
				var FirstLastNameD = $('#FirstLastNameD').val();
                // отправляем данные
				
                $.ajax({
                    url: "Hos.php", // куда отправляем
                    type: "post", // метод передачи
                    dataType: "json", // тип передачи данных
                    data: { // что отправляем
                        "FirstNameP":    FirstNameP,
                        "LastNameP":   LastNameP,
                        "OtchesNameP": OtchesNameP,
						"PacEmail": PacEmail,
						"RecData": RecData,
						"RecTime": RecTime,
						"FirstLastNameD": FirstLastNameD
                    },
                    // после получения ответа сервера
                     success: function(data){
                        $('.messages').html(data.result);  // выводим ответ сервера
                     } 
                });
            });
        });
    </script>
	<title> Запись к врачу </title> 
    </head>
	<body>
	    <h1> Запись к врачу </h1>
		<h2> Укажите данные для записи </h2>
		 <form>
		Ваше Имя :<input type = "text" name = "FirstNameP" id="FirstNameP" required="required" value=""> <br>
		Ваше Фамилия: <input type ="text" name= "LastNameP" id= "LastNameP"required="required"><br>
		Ваше Отчество(при наличии):<input type = "text" name = "OtchesNameP" id = "OtchesNameP"> <br>
		Ваш E-mail:<input type = "email" required="required" name = "PacEmail"  id = "PacEmail"> <br>
		На какую дату :<input type = "date" name = "RecData" id = "RecData" required="required"> <br>
		На какое время :<select  name = "RecTime"  id = "RecTime" >
			<option> </option>
			<?php 
			$Htime=8;
			$Mtime=0;
			While( $Htime<=16){
				echo '<option>';
				$FTime=$Htime.':'.$Mtime.'0';
				echo $FTime;
				echo '</option>';
					if($Mtime == 0){
						$Mtime=$Mtime+3;
					}
					else
					{
						$Htime=$Htime+1;
						$Mtime=0;
					}
			}
			
		?>
		</select>		<br>
		ФИО врача:<select  name = "FirstLastNameD" required="required" id = "FirstLastNameD"> 
				<option></option>
				<?php 
				$query="SELECT * FROM doctors";
				$select_doctors=mysqli_query($link,$query);
				while ($doctors = mysqli_fetch_array($select_doctors))
				{
					echo '<option value="';
					echo $doctors['Id'].'">';
					echo $doctors['FirstNameDoctor'],'&nbsp',$doctors['LastNameDoctor'],'&nbsp',$doctors['OtchesNameDoctor'];
					echo '</option>';
					}?>
						 
					</select>
		<br>
		<input type= "button" id = "btn_submit" value = отправить>
		</form>
		<div class="messages"></div>
		
		
	
	</body>
	
	</html>	
	