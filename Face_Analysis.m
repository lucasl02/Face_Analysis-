clear all; close all; clc;

load yalefaces.mat;
% a) correlation matrix of first 100 images
C = X(:,1:100);
A1 = (C')*(C);
%disp(size(A1));


% b) two most highly correlated images
A2 = [1,2];
highestCorr = 0;
for j=1:100
    for k= j+1:100
        valueAtIndex = A1(j,k);
        if (valueAtIndex > highestCorr)
            highestCorr = valueAtIndex;
            A2(1,1) = j;
            A2(1,2) = k;
        end
    end
end
%disp(A2);


% most uncorrelated images 
A3 = [1,2];
smallestCorr = 100;
for j=1:100
    for k=j+1:100
        valueAtIndex = A1(j,k);
        if (valueAtIndex < smallestCorr)
            smallestCorr = valueAtIndex;
            A3(1,1) = j;
            A3(1,2) = k;
        end
    end
end
%disp(A3);

% c) correlation matrix of only 10 images 
pick = [1,313,512,5,2400,113,1024,87,314,2005];
A4 = X(:,pick);
A4 = A4' * A4;
disp(A4);

% d) V = eigenVectors D = eigenValues
Y = X * X';
[V,D] = eigs(Y,6,'lm');
A5 =abs(V);
disp(A5);

% e) svd, u matrix important to find patterns
[u,s,v] = svd(X);
A6 = u(:,1:6);
%disp(size(A6));

% 6 images are each an eigenvector of the 10 images 
for j = 1:6
    subplot(3,3,j);
    imagesc(reshape(A6(:,j),32,32)');
end


% f)
A7 = norm(abs(A5(:,1))-abs(A6(:,1)));
%disp(A7);

% g) finding variance, s matrix - variance of svd modes  
A8 = [];
total = 0;
for j=1:1024
    total = total + s(j,j);
end
%disp(s(1:6,1:6));
%disp(total);
for j=1:6
    A8 = [A8,(s(j,j)/total)*100];
end
%disp(A8);