
%% Lab 1 Assignment: KEY
% 
% The following questions are designed to test your comphrension of the
% tutorials. Create a new script in the Editor window and save it as
% Lab1YourLastName.m . Cut and paste the following questions into your
% script. In the space under the question, type in the commands that will
% produce the answers. You can test your code by "running your script" -
% which means the computer will do all the commands in the code and
% hopefully your answers will pop up on the screen! (Click on the green Run
% arrow at the top of the editor window.) 

%%
% *Q1*. Make a row vector |x| that has the first 10 positive integers.
% 
x=[1:10]
x=[1:1:10] ;% another option
x=1:10 ; % note - the brackets aren't strictly necessary, but I find it easier to have them. 
x=[1 2 3 4 5 6 7 8 9 10] ;  % this is technically correct, but slow. Why not harvest the power of MATLAB?

%%
% *Q2*. Now make |x| into a column vector using the transpose operator (but don't change its name).
%
x=x'    %OR
x=transpose(x)   %notice that we've overwritten the old value of x (it doesn't exist anymore)

%%
% *Q3*. Add 2 to each element in this vector |x| and call the resulting vector |newx|
%
newx=x+2  

%%
% *Q4*. Make a column vector |y| that has every third integer from 1 to 30.
%
y = [1:3:30]'  % yes, this only goes to 28!
y = transpose(1:3:30)
% see that you can transpose in one step - don't need two lines. 

y = [1;4;7;10;13;16;19;22;25;28;] % technically right, but faster to use the colons...

%%
% *Q5*. Make a matrix, |A|, whose first column is |x|, and whose second
% column is |x+2|. (Use the x from Q2)
%
A = [x, x+2]
A = [x x+2] % note this also works - you don't need the comma

%%
% *Q6*. Make a second matrix |B| whose first two rows contain the values of |A'|, and
% whose last two rows contain the values of two times |A'|. |B| has a |size| of (4,10).
%
B = [A' ; 2.*A']  % see that the ; puts the second part UNDER the first part (that is, a new row)

%%
% *Q7*. Make a column vector |z| that is each element of |x| times
% the corresponding element of |y|.
%
z = x.*y   % must use the dot product
%%
% *Q8*. What is the square of each element of |z|? Make a new variable
% |zsq| containing the answer.
%
zsq=z.^2   % note that an exponent is a multiplication... need the dot. 
%%
% *Q9*. What is the sine of each element of |z|? Make a new variable |sinz|
% containing the answer.
%
sinz=sin(z)   % here you are using the function sin  (try help sin to learn more)

%%
% *Q10*. What do you type to find the 6th element of |z|?
%
z(6)
%%
% *Q11*. What do you type to find the value that is in the second row and
% third column of |B|?
%
B(2,3)
%%
% *Q12*. Make a column vector |depth| that gives depth values from 0 to
% 100m in 10m increments. 
%
depth=[0:10:100]' ;
%%
% *Q13*. Make a column vector |temperature| that gives temperature values from 0 to
% 100m in 10m increments. Use the values written on the white board. 
%
temperature=[16 15 14 13 10 9 8 7 7.3 6 6] ; % Obviously, use the values put on the whiteboard in 2018!
%%
% *Q14*. Make a graph that presents temperature vs depth, putting depth on
% the x axis and temperature on the y axis.
plot(depth, temperature)
%%
% SAVE your script. 
%%
%% NOTE:
% You will be marked on 1) your answers to the questions; 2) your ability
% to follow directions; and 3) the elegance of your code. Keep things neat
% and organized. Use % to make comment lines to explain what you are doing.
% Use the semicolon ; after commands to supress unnecessary output. Make
% sure you follow the file name conventions I've asked for. 
%
% You need to hand in 1 file: 
%
% * |Lab1CodeYourlastname.m| with your code that answers questions Q1-Q14. I
% will run your code to generate your answers. 
%
% You may hand it in on the class USB Memory stick, or via email to
% karinag@uvic.ca with the subject: *314 Lab1 LastName*
%%
% .
% .
% .
% .
% .
% .
% .
% .
% .
%%
% Last compiled on: 
datestr(now)





