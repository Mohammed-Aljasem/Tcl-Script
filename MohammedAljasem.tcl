set input_file [open "input.txt" r]
set line_number 0
set count_integers 0
set count_strings 0 
set sum_integers 0
set count_odd_numbers 0
set count_even_numbers 0
set count_empty_lines 0

puts "0- print all lines with the length of each line. ";

#loop on each line in file 
while { [gets $input_file line] >= 0 } {
  incr line_number
  # check if line is integer and store it in array
  if {[expr {[string is integer $line] && ![regexp {^\s*$} $line]}]} {
    incr count_integers
    set line_integer($count_integers) $line
  }

  #check if line start with string characters
  if {[regexp {^[a-zA-Z]} $line]}  {
    incr count_strings;
    set line_strings($count_strings) $line
    if {[expr {$count_strings <= 3} ]} {
      append three_lines " " $line
    }
  }

  #print lines with length
  puts "$line  - length [string length $line]"

  #check if line are empty and store length 
  if {![regexp {^\s*$} $line]} {
    append length_lines " " [string length $line]
  } else {
    incr count_empty_lines
  }
}

close $input_file;

#math on integers found
foreach {key value} [array get line_integer] {
  #sum all integers in array
  set sum_integers [expr { $sum_integers + $value}]

  #check integer are odd or even and apply operation are requested 
  if {[expr {$value % 2 == 1} ]} {
    incr count_odd_numbers
    set odd_numbers($value) [expr {$value / 2}];
  } else {
    incr count_even_numbers
    set even_numbers($value) [expr {$value * 3.25}];
  }
}

puts "\n1- Print lines start with string characters."

foreach {key value} [array get line_strings] {
  puts $value;
}

puts "\n2- Print lines that present an odd integer value, divide the value with 2.";

foreach {key value} [array get odd_numbers] {
  puts "the number $key / 2:   $value";
}

puts "\n3- Print lines that present an even integer value, multiply the value with 3.25.";

foreach {key value} [array get even_numbers] {
  puts "the number $key x 3.25:   $value";
}

puts "\n4- print the summation of the first 2 integer values occurring in the file.";

puts [expr {$line_integer(1) + $line_integer(2)}]

puts "\n5- print the concatenation of the first 3 lines starting with the string characters.";

puts $three_lines

puts "\n6- print a maximum integer value found in the file.";

puts "numbers found in file: $count_integers the summation of numbers: $sum_integers "


puts "\n7- print the minimum length of \"non-empty string\" in the whole file.";

puts "minimum line length: [expr min([join $length_lines ","])] "  ; 


puts "\n\nFinal Report: \n"
puts "Number of lines: $line_number"
puts "Number lines are string: $count_strings"
puts "Number lines are odd integer: $count_odd_numbers"
puts "Number lines are even integer: $count_even_numbers"
puts "Number lines are empty: $count_even_numbers"



    