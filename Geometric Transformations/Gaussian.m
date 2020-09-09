%Interpolation using a filter - Part (b)

I1 = imread('food1.jpg'); %Original Image
[M, N, C] = size(I1);

I6 = double(I1)/255.0;

I2 = rgb2gray(I1); %Grayscale Image

I7 = double(I2)/255.0;

I9 = zeros(M+4,N+4); 
I9(3:M+2, 3:N+2) = I7;

I10 = zeros(M+4,N+4);
I10(3:M+2, 3:N+2,1:3) = I6;

%Gaussian Filter 5x5

sd = 1;
for x = -2 : 2
    for y = -2 : 2
        h(x+3,y+3) = (1/(2*pi*sd^2)) * exp(-(x^2 + y^2)/(2*sd^2));
    end
end

theta=90.0;
A = [ 0.5 * cosd(theta) -sind(theta)
      sind(theta)  cosd(theta) ];
T= [ 10 5 ]'; 

p = A * [ 1 1 ]' + T;
x1=p(1);
y1=p(2);
p= A * [ 1 N ]' + T; 
x2=p(1);
y2=p(2);
p= A * [ M 1 ]' + T; 
x3=p(1);
y3=p(2);
p= A * [ M N ]' + T; 
x4=p(1);
y4=p(2);

xmin = floor( min( [ x1 x2 x3 x4 ] ));
xmax = ceil( max( [ x1 x2 x3 x4 ] ));
ymin = floor(min( [ y1 y2 y3 y4 ] ));
ymax = ceil(max( [ y1 y2 y3 y4 ] ));
Mp=ceil(xmax-xmin)+1;
Np=ceil(ymax-ymin)+1;

I8=zeros(Mp,Np);
I4=zeros(Mp,Np,3);

Ap = inv(A); 
 
for i = xmin : xmax
    for j = ymin : ymax
        p = Ap * ( [ i j ]' -T );
        
        x0=p(1);
        y0=p(2);
        
        xn = floor(x0);
        yn = floor(y0);
        
        if((3<=xn) && (xn<=M-2) && (3<=yn) && (yn<=N-2))
            
            x=round(i-xmin+1);
            y=round(j-ymin+1);
            
            list1 = double(I9(xn-2:xn+2,yn-2:yn+2));
            I8(x,y) = sum(sum(list1.*h));
            
            list1 = double(I10(xn-2:xn+2,yn-2:yn+2,1));
            I4(x,y,1) = sum(sum(list1.*h));
            
            list1 = double(I10(xn-2:xn+2,yn-2:yn+2,2));
            I4(x,y,2) = sum(sum(list1.*h));
            
            list1 = double(I10(xn-2:xn+2,yn-2:yn+2,3));
            I4(x,y,3) = sum(sum(list1.*h));
            
        end
    end
end

figure;
subplot(2,2,1);
imshow(I1);
title("Original Image");

subplot(2,2,2);
imshow(I2);
title("Grayscale Image");

subplot(2,2,3);
imshow(I4);
title("Gaussian filter Interpolation of Original Image");

subplot(2,2,4);
imshow(I8);
title("Gaussian filter Interpolation of Grayscale Image");