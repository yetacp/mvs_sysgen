# Full Screen Interface

Author: Tommy Sprinkle
Homepage: http://tommysprinkle.com/mvs/fss/index.html

Version 1 - Release 2

Full Screen Interface (FSI) is a programming library modeled after SPF that supports full screen 3270 programming.  To use FSI, one more more application panels are coded and stored in the Panel Library or PLIB data set.  The application program uses a Display function call to display the panel.  Input / output variables are used to allow the application to display dynamic content to the screen and allow the application program to retrieve input data from the terminal.

FSI uses an execution environment that the application program must run underneath.  To run a FSI application, the FSI environment must first be created using the FSISTART command specifying the application name as a parameter.  The FSISTART command will load the FSI environment and then attach the application program.

Standard Disclaimer

FSI is a part-time fun project that I started working on while traveling.  I found myself killing a lot of time in airports and fired up MVS 3.8 under Hercules on my laptop.  The code "mostly works" at this point.  There is a lot of need for improvement.  Error handling is almost non-existent.  I diagnose errors using the TSO TEST command since the code produces very few error messages.

There is a lot of room for enhancement and improvement if you would like to help take this project forward.  When I get more spare time I may try to improve upon what I have here.

This is by far not the best code I have ever written in my life but it just evolved a few lines at a time.  Since I was traveling, I did not have access to any of my reference materials.  A lot of the original code was written to try something out and see what happened.  When I get the right results, I added more code and attempted something else.  If you look at the code it will pretty much look as though is was written that way.  There was no overall plan or design I was working from.
Using FSI