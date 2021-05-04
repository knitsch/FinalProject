# FinalProject
3 Dimensional Vector Field Gui

This is a gui that takes in 3 functions of x,y,z for the i j and k components of a vector field,
and it plots the 3 dimensional vector field accordingly. Enter the functions in proper matlab
syntax, making sure to type 3*x or x*y instead of 3x or xy. Use the plot button to plot the current 
functions as a vector field. Use the clear button to clear the vector field plot. Use the slider to
adjust the zoom level, from the default 1x zoom to a maximum 5x zoom.

e^x or similar functions must be input as exp(x)

ln(x) is input as log(x), and log(x) is input as log(x)/log(10)


I noticed that git doesn't carry asterisks, but instead italicizes, so to type 3x as a function, type 3 asterisk x
to type yln(x)^2, type y asterisk log(x);

Capital X Y and Z will work fine, and other inputs such as m or n will not do anything. Invalid inputs like multiplication without an asterisk will not work.

trigonometric functions are input as they would be, as sin(x), tan(y), cos(x asterisk z), etc...