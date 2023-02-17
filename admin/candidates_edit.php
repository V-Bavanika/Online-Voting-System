<?php
	include 'includes/session.php';

	if(isset($_POST['edit'])){
		$id = $_POST['id'];
		$firstname = $_POST['firstname'];
		$lastname = $_POST['lastname'];
		$position = $_POST['position'];
		$platform = $_POST['platform'];
		$dob = $_POST['dob'];
		$email = $_POST['email'];
		$phone = $_POST['phone'];
		$gender = $_POST['gender'];
		
		$sql = "UPDATE candidates SET firstname = '$firstname', lastname = '$lastname', position_id = '$position', platform = '$platform', dob='$dob',email='$email', phone_no = '$phone', gender='$gender' WHERE id = '$id'";
		if($conn->query($sql)){
			$_SESSION['success'] = 'Candidate updated successfully';
		}
		else{
			$_SESSION['error'] = $conn->error;
		}
	}
	else{
		$_SESSION['error'] = 'Fill up edit form first';
	}

	header('location: candidates.php');

?>