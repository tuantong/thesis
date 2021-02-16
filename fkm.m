function [Z,D,W,F]=fkm(Dulieu,alpha,k,n);

%Chon [Z] ban dau
R=randperm(n);%chon ra k vecto ngau nhien trong n vecto
for i=1:k
    Z(i,:)=Dulieu(R(i),:);
end

%Phan chinh cua chuong trinh
F=0;
for t=1:500
  
    %Tinh khoang cach Euclidean [D] tu [Dulieu] va [Z]
    D=[];
    for j=1:n
        for i=1:k
            D(j,i)=sqrt(sum(((Dulieu(j,:)-Z(i,:)).^2)'));
        end
    end
    
    %Tinh [W] tu [D]
    Wtam1=D.^(-2/(alpha-1));
    Wtam2=sum(Wtam1')';
    Wtam3=Wtam2(:,ones(k,1));
    W=Wtam1./Wtam3;
    for j=1:n
        for i=1:k
            if isnan(W(j,i))
               W(j,i)=1;
            end
        end
    end
                  
    %Tinh F tu [W] va [D], co kiem tra dieu kien stop
    Fluu=F;
    Ftam=(W.^alpha).*(D.*D);
    F=sum(sum(Ftam));
    if abs(F-Fluu)<0.00001
    break
    end

    %Tinh [Z] tu [Dulieu] va [W]
    W1=sum(W)';
    W2=W1(:,ones(n,1))';
    W3=W./W2;
    Z=((Dulieu')*W3)';
    
end