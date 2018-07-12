%Face recognition using SVD

clc;
clear all;

cd 'D:\College\Sem-6\DIP\yalefaces'; %set current folder
imagefiles = dir('D:\College\Sem-6\DIP\yalefaces');   
nfiles = length(imagefiles);    % Number of files found

for l=1:nfiles-2
    for j = 1:6768  
        L(j,l)=0;
    end
end

k=1;
for ii=3:nfiles
   currentfilename = imagefiles(ii).name;
   currentimage = imread(currentfilename);
   currentimage = imresize(currentimage,[72 94]);   %resize big image into 72*94 size image
   nraw = length(currentimage(:,1));
   ncol = length(currentimage(1,:));
   cnt=1;
   for j=1:ncol
       for i = 1:nraw
           f(cnt) =  currentimage(i,j);
           cnt = cnt+1;
       end
   end
   f_t = transpose(f);
   L(:,k) = f_t(:);
   k = k+1;
 end

[U,S,V]=svd(L);

% input Image name
imagefiles = 'subject01.gif';      
currentimage = imread(imagefiles);
currentimage = imresize(currentimage,[72 94]);
nraw = length(currentimage(:,1));
ncol = length(currentimage(1,:));
cnt=1;
for j=1:ncol
       for i = 1:nraw
           f(cnt) =  currentimage(i,j);
           cnt = cnt+1;
       end
end
g = transpose(f);
for i=1:ncol
    gu(:,i)=double(g).*double(U(:,i));
end 

imagefiles = dir('D:\College\Sem-6\DIP\yalefaces');
for ii=3:nfiles
    for i = 1:ncol
         fu(:,i)= double(L(:,ii-2)).*double(U(:,i));   
    end
    x  = fu-gu;
    nx(ii-2)=norm(x);

end
mi=nx(1);
for i=1:length(nx)
    if(nx(i)<=mi)
        mi=nx(i);
        j=i;
    end
end
fprintf('new face is like %s',imagefiles(j+2).name);
