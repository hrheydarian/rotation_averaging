function [R,RR,I] = RandomSO3Graph(N,Completeness,Sigma,Outlier)
% [RR] = function RandomSO3Graph(N)
% INPUT  : N            = Number of nodes or View Points or Observation Points
%          Completeness = Fraction [0,1] of edges that will have Rij edges
%          Sigma        = Noise added to Relative Rotations in degree
%          Outlier      = Fraction of Outliers
% OUTPUT : R            = Absolute Rotations. R(:,:,1)=eye(3);
%          RR,I         = Relative Rotation Matrices and the Indices. RR(:,:,i) is
%                         the relative rotation between the nodes I(1,i) and I(2,i)
%                         RR(:,:,i) = R(:,:,I(2,i))*R(:,:,I(1,i))' 
Sigma=Sigma*pi/180/sqrt(3);
Outlier=round(N*(N-1)*Completeness*Outlier);
R=zeros(3,3,N);
R(:,:,1)=eye(3);
for i=2:N
    w=randn(3,1);w=w/norm(w)*pi*rand(1);
    R(:,:,i)=w2R(w);
end
I=zeros(2,N*(N-1)/2);RR=zeros(3,3,N*(N-1)/2);
k=1;
for i=1:N-1
    for j=i+1:N
        I(:,k)=[i;j];
        RR(:,:,k)=R(:,:,j)*R(:,:,i)';
        k=k+1;
    end
end
if(nargin>1&&Completeness~=1)
    G=zeros(N,N);d=zeros(1,size(I,2));
    k=1;
    for i=1:N-1
        for j=i+1:N
            G(j,i)=acos((trace(RR(:,:,k))-1)/2);
            d(1,k)=G(i,j);
            k=k+1;
        end
    end
    [MST ~]=graphminspantree(sparse(G));
    k= false(1,size(I,2));
    for i=1:size(I,2)
        if(MST(I(2,i),I(1,i))~=0);    k(i)=1;     d(i)=inf;    end;
    end
    e=ceil(Completeness*size(I,2));
    if(e>N-1);    [~,d]=sort(d);    k(d(1:e-N+1))=1;    end;
    I=I(:,k);    RR=RR(:,:,k);
end
if(nargin>2)
    for i=1:size(RR,3)
        RR(:,:,i)=RR(:,:,i)*w2R(Sigma*randn(1,3));
    end
end
if(nargin>3)
    [~,i]=sort(rand(size(RR,3),1));i=i(1:Outlier);
    for j=1:size(i,1)
        RR(:,:,i(j))=w2R(100*pi*randn(1,3));
    end
end
end