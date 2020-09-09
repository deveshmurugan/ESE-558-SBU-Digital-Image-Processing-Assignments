%Zoom in & Zoom out - Part (c)

I1 = imread('food1.jpg'); %Original Image
[M, N, C] = size(I1);

I6 = double(I1)/255.0; 

I2 = rgb2gray(I1); %Grayscale Image

I7 = double(I2)/255.0;

theta=0.0;

%Affine matrix is changed to produce an image 1.2x larger

A = [ 3 * cosd(theta) -3 * sind(theta) 
      3 * sind(theta)  3 * cosd(theta) ];
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
        p = Ap * ( [ i j ]' - T );
        
        x0=p(1);
        y0=p(2);
        
        minx = floor(x0);
        maxx = ceil(x0);
        miny = floor(y0);
        maxy = ceil(y0);
        
        dx = x0 - minx;
        dy = y0 - miny;

        if( (1<=minx) && (minx<=M) && (1<=maxx) && (maxx<=M) && (1<=miny) && (miny<=N) && (1<=maxy) && (maxy<=N))
             
            x=round(i-xmin+1);
            y=round(j-ymin+1);            
            
            x_1 = (dx * I7(maxx, miny)) + ((1 - dx) * I7(minx, miny));
            x_2 = (dx * I7(maxx, maxy)) + ((1 - dx) * I7(minx, maxy));
            y_1 = (dy*x_2) + ((1-dy)*x_1);
            
            I8(x,y) = y_1;
                         
            x_1 = (dx * I6(maxx, miny,1)) + ((1 - dx) * I6(minx, miny,1));
            x_2 = (dx * I6(maxx, maxy,1)) + ((1 - dx) * I6(minx, maxy,1));
            y_1 = (dy*x_2) + ((1-dy)*x_1);
            
            I4(x,y,1) = y_1;
             
            x_1 = (dx * I6(maxx, miny,2)) + ((1 - dx) * I6(minx, miny,2));
            x_2 = (dx * I6(maxx, maxy,2)) + ((1 - dx) * I6(minx, maxy,2));
            y_1 = (dy*x_2) + ((1-dy)*x_1);
            
            I4(x,y,2) = y_1;
             
            x_1 = (dx * I6(maxx, miny,3)) + ((1 - dx) * I6(minx, miny,3));
            x_2 = (dx * I6(maxx, maxy,3)) + ((1 - dx) * I6(minx, maxy,3));
            y_1 = (dy*x_2) + ((1-dy)*x_1);
            
            I4(x,y,3) = y_1;
        
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
title("Zoomed original image");

subplot(2,2,4);
imshow(I8);
title("Zoomed grayscale image");

fprintf("Size of Original Image : ");
disp(size(I2));
fprintf("Size of Zoomed Image : ");
disp(size(I8));