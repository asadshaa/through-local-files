<?php

echo '<h1>'." Task 1 ". '<h1>';

$num1 = 5;
$num2 = 10;

$a= "The First Number Is ".+ $num1 ;
$b = " The second Number Is ".+ $num2 ;
$sum = " The Total Is " .+ $num1 + $num2;
echo $a . $b . $sum ;
 

echo "<br>";


echo '<h1>'."Task 2".'<h1>';

function oddevenfunction ($number){
    if ($number % 2 == 0){
        echo " even ";
    }
    else
    echo " Odd ";
}

$TestNumber = 5; //we can enter any number here to find out if it is even or odd
oddevenfunction($TestNumber);


echo "<br>";
echo '<h1>'."Task 3".'<h1>';


function calculator($num1, $num2, $sign) {
    if ($sign == "+") {
        return $num1 + $num2;
    } elseif ($sign == "-") {
        return $num1 - $num2;
    } elseif ($sign == "*") {
        return $num1 * $num2;
    } elseif ($sign == "/") {
        if ($num2 != 0) {
            return $num1 / $num2;
        } else {
            return "Error: Division by zero";
        }
    } else {
        return "Error: Invalid operator";
    }
}

// Test the function
$num1 = 10;
$num2 = 5;

echo "10 + 5 = " . calculator($num1, $num2, "+") . "<br>";
echo "10 - 5 = " . calculator($num1, $num2, "-") . "<br>";
echo "10 * 5 = " . calculator($num1, $num2, "*") . "<br>";
echo "10 / 5 = " . calculator($num1, $num2, "/") . "<br>";
echo "10 / 0 = " . calculator($num1, 0, "/") . "<br>";
echo "10 & 5 = " . calculator($num1, $num2, "&") . "<br>";

echo '<h1>'."Task 4".'<h1>';

function getGrade($score) {
    if ($score >= 90 && $score <= 100) {
        return "A";
    } elseif ($score >= 80 && $score < 90) {
        return "B";
    } elseif ($score >= 70 && $score < 80) {
        return "C";
    } elseif ($score >= 60 && $score < 70) {
        return "D";
    } else {
        return "F";
    }
}

// Test the function with different scores
$scores = [95, 85, 75, 65, 55];
foreach ($scores as $score) {
    echo "The grade for a score of $score is " . getGrade($score) . "<br>";
}

echo '<h1>'."Checking LeapYear".'<h1>';

function isLeapYear($year) {
    if (($year % 4 == 0 && $year % 100 != 0) || ($year % 400 == 0)) {
        return "Leap year";
    } else {
        return "Not a leap year";
    }
}

$year = 2024;
echo "The year $year is " . isLeapYear($year) . "<br>";

function getMonthName($month) {
    switch ($month) {
        case 1:
            return "January";
        case 2:
            return "February";
        case 3:
            return "March";
        case 4:
            return "April";
        case 5:
            return "May";
        case 6:
            return "June";
        case 7:
            return "July";
        case 8:
            return "August";
        case 9:
            return "September";
        case 10:
            return "October";
        case 11:
            return "November";
        case 12:
            return "December";
        default:
            return "Invalid month";
    }
}

// Test the function
$month = 7;
echo "The month $month is " . getMonthName($month) . "<br>";



echo '<h1>'."Factorial".'<h1>';
function factorial($number) {
    if ($number <= 1) {
        return 1;
    } else {
        return $number * factorial($number - 1);
    }
}

// Test the function
$number = 5;
echo "The factorial of $number is " . factorial($number) . "<br>";


echo '<h1>'."Checking Temperature".'<h1>';
function convertTemperature($temperature, $unit) {
    if ($unit == "F") {
        // Convert Fahrenheit to Celsius
        return ($temperature - 32) * 5 / 9;
    } elseif ($unit == "C") {
        // Convert Celsius to Fahrenheit
        return ($temperature * 9 / 5) + 32;
    } else {
        return "Invalid unit";
    }
}

// Test the function
$temperature = 100;
$unit = "F";
echo "$temperature°F is " . convertTemperature($temperature, $unit) . "°C<br>";

$temperature = 37.5;
$unit = "C";
echo "$temperature°C is " . convertTemperature($temperature, $unit) . "°F<br>";



echo '<h1>'."Finding The Largest Number".'<h1>';
function largestNumber($num1, $num2, $num3) {
    if ($num1 >= $num2 && $num1 >= $num3) {
        return $num1;
    } elseif ($num2 >= $num1 && $num2 >= $num3) {
        return $num2;
    } else {
        return $num3;
    }
}

// Test the function
$num1 = 10;
$num2 = 20;
$num3 = 15;
echo "The largest number among $num1, $num2, and $num3 is " . largestNumber($num1, $num2, $num3) . "<br>";



echo '<h1>'."Checking Day Of The Week".'<h1>';

function getDayOfWeek($day) {
    switch ($day) {
        case 1:
            return "Monday";
        case 2:
            return "Tuesday";
        case 3:
            return "Wednesday";
        case 4:
            return "Thursday";
        case 5:
            return "Friday";
        case 6:
            return "Saturday";
        case 7:
            return "Sunday";
        default:
            return "Invalid day";
    }
}

// Test the function
$day = 5;
echo "The day $day corresponds to " . getDayOfWeek($day) . "<br>";
?>