clc
close all

% Length of inpulse response for the channel connecting the loudspeaker and the microphone
n = 2;
m = 2;

% To make the matrix G a square matrix 
i = n-1;
j = m-1;

% L = m+i = n+j
L = m+n-1; 
 
% Randomly generating the the impulse responses of length m+1 and n+1
% respectively
% Displaying the above generated impulse responses
disp("The room acoustic filter response are:");
g1 = floor(rand(m+1,1)*1000)
g2 = floor(rand(n+1,1)*1000)

% Concatinating zeros and circularly shifting the matrix to generate
% matrices G1 and G2
g11 = [g1', zeros(1,i)]';
g21 = [g2', zeros(1,j)]';
 
G1 = g11;
G2 = g21;
 
for nn=1:i
    G1 = [G1, circshift(g11,nn)];
end
 
for nn=1:j
    G2 = [G2, circshift(g21,nn)];
end
 
% Generating the matrix G (which is a square matrix) from the above found
% G1 and G2 matrices for which the inverse is to be calculated. 

G = [G1 G2]

% Defining D such that H = G^-1*D 
D = [1,zeros(1,L)]';

% Finding the inverse and calculating the inverse matrix
Ginv = inv(G)
 
H = Ginv*D

% Extacting the impulse responses of each of the inverse filters to be
% constructed from matrix H.
% Printing the impulse responses of the realised inverse filters
disp("The exact inverse for acoustic filter responses are respectively:");
h1 = H(1:n)
h2 = H(n+1:n+m)



% *********************************************************************

fileName = "sp.wav";
[y,fs] = audioread(fileName);
%y is the samples, sampled at frequency fs
sound(y,fs);

pause(2);

output1 = conv(y,g1);
output2 = conv(y,g2);
final_output_without_inversing = output1 + output2;

sound(final_output_without_inversing,fs);

pause(2);

output11 = conv(y,h1);
output12 = conv(y,h2);

output1 = conv(output11,g1);
output2 = conv(output12,g2);

final_output_after_inversing = output1 + output2;

sound(final_output_after_inversing,fs);
pause(2);

load train
sound(y,Fs);

pause(5);

output1 = conv(y,g1);
output2 = conv(y,g2);
final_output_without_inversing = output1 + output2;

sound(final_output_without_inversing,fs);

pause(5);

output11 = conv(y,h1);
output12 = conv(y,h2);

output1 = conv(output11,g1);
output2 = conv(output12,g2);

final_output_after_inversing = output1 + output2;

sound(final_output_after_inversing,fs);