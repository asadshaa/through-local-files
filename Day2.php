<!-- //In PHP, variables are defined using the dollar sign 
 $ followed by the variable name. Variable names must start
  with a letter or an underscore,
  followed by any number of letters, numbers, or underscores -->


  <?php
// Defining variables
$name = "Asad";
$age = 25;
$is_student = true;
$gpa = 3.75;

// Outputting variables
echo "Name: " . $name . "<br>";  // Using concatenation with the dot (.) operator
echo "Age: $age<br>";  // Using double quotes for direct variable interpolation
echo "Is student: " . ($is_student ? 'Yes' : 'No') . "<br>";  // Ternary operator to output a boolean
echo "GPA: $gpa<br>";  // Direct interpolation within double quotes

// Using print statement
print "Name: " . $name . "<br>";
print "Age: $age<br>";
print "Is student: " . ($is_student ? 'Yes' : 'No') . "<br>";
print "GPA: $gpa<br>";

// Using single quotes (no variable interpolation)
echo 'Name: ' . $name . '<br>';
echo 'Age: ' . $age . '<br>';
echo 'Is student: ' . ($is_student ? 'Yes' : 'No') . '<br>';
echo 'GPA: ' . $gpa . '<br>';
?>