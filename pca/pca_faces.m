clear all
close all
clc

load facesData.mat
k=15;
l=11;
m=8;
n=k*l;
mean_face=mean(faces,1);
imshow(reshape(uint8(mean_face),[32 32]));
X_faces=faces-mean_face;
autocorellation=X_faces'*X_faces/n;
[base_faces_dim,D]=eig(autocorellation);

%choose the first m eigen vectors:
new_base=base_faces_dim(:,end-m+1:end);
%create presentation for faces in projected dim
coefficients=zeros(n,m);
downsampled_faces=zeros(size(X_faces));
for pic=1:n
   %calc coefficient
    coefficients(pic,:)=X_faces(pic,:)*new_base;
    downsampled_faces(pic,:)=mean_face+(new_base*coefficients(pic,:)')';
    subplot(2,3,1)
    imshow(reshape(uint8(faces(pic,:)),[32 32]));
    subplot(2,3,2)
    imshow(reshape(uint8(X_faces(pic,:)),[32 32]));
    subplot(2,3,3)
    imshow(reshape(uint8(downsampled_faces(pic,:)),[32 32]));
end



