function [convolution] = myConv1(x1, x2)
Np1 = length(x1);
Mp2 = length(x2);
Tconv = Np1+Mp2-1;
p01 = [x1,zeros(1,Tconv-Np1)];

counter = 0;
z = zeros(1,Tconv);
k11 = p01;
counter = 0;
while (counter<Mp2)
    z1 = x2(counter+1)*k11;
    w11 = [0,k11(1:end-1)];
    k11 = w11;
    z = z+z1;
    counter = counter+1;
end
convolution = z;
end