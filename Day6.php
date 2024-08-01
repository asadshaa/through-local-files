⭐ variables are Created With ($) proceded With the name Ex. ~($a=10; , $b=5)~
A variable can have a short name (like $x and $y) or a more descriptive name ($age, $carname, $total_volume)

⭐Output Variables
The PHP echo statement is often used to output data to the screen
The echo statement can be used with or without parentheses: echo or echo()

⭐Variable Types
PHP has no command for declaring a variable, and the data type depends on the value of the variable.
To get the data type of a variable, use the (var_dump()) function. 

⭐Assign Multiple Values
You can assign the same value to multiple variables in one line:





<?php
// Creating Variables
$a = 10;  // Variable $a with value 10
$b = 5;   // Variable $b with value 5

// Variable names can be short or descriptive
$x = 1;           // Short name variable
$age = 25;        // Descriptive name variable
$carname = "BMW"; // Descriptive name variable with string value
$total_volume = 50.75; // Descriptive name variable with float value

// Output Variables
echo $a;          // Output the value of $a
echo "<br>";      // Line break for better readability in HTML output
echo $carname;    // Output the value of $carname

echo "<br>";      // Line break for better readability in HTML output

// Using echo with parentheses
echo($total_volume); 
echo "<br>";

// Variable Types
var_dump($x);     // Outputs: int(1)
echo "<br>";
var_dump($age);   // Outputs: int(25)
echo "<br>";
var_dump($carname); // Outputs: string(3) "BMW"
echo "<br>";
var_dump($total_volume); // Outputs: float(50.75)
echo "<br>";

// Assign Multiple Values
$var1 = $var2 = $var3 = 100; // Assigning value 100 to $var1, $var2, and $var3

echo $var1; // Outputs: 100
echo "<br>";
echo $var2; // Outputs: 100
echo "<br>";
echo $var3; // Outputs: 100
?>
