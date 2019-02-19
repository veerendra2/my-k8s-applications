<?php
$app_version="2.3";
$database = "employees";
$servername = gethostbyname(getenv("MYSQL_HOST"));
$username = getenv("USERNAME");
$password = getenv("PASSWORD");
$pod_name =  getenv("HOSTNAME");
$random_emp_id=rand(10002,499999);
$conn = mysqli_connect($servername, $username, $password, $database);
if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
}
$sql = "select employees.first_name, titles.title from employees,titles where employees.emp_no=".$random_emp_id." and titles.emp_no=".$random_emp_id;
$result = mysqli_query($conn, $sql);
$row=mysqli_fetch_assoc($result);
echo("Random Employee Name:".$row["first_name"].". Title".$row["title"]);
echo("\nApp Version:".$app_version.". Responce from the POD:".$pod_name);
?>
