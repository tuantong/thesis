function [Phantram,LocZ,Ntam]=phantram(W,k,n);

%Tinh [N]
Ntam=W;%tinh so phan tu trong k nhom
for j=1:n
    for i=1:k
        if Ntam(j,i)==max(Ntam(j,:))
           Ntam(j,i)=1;
           Ntam(j,(i+1):end)=0;
        end
        if Ntam(j,i)~=max(Ntam(j,:))
          Ntam(j,i)=0;
        end
    end
end
N=(sum(Ntam))';

%Tinh [Phantram]
Phantram=[];
for i=1:k
    Phantram(i)=N(i)/sum(N)*100;
end
Phantram=Phantram';

LocZ=[];
for i=1:k
    if Phantram(i)==max(Phantram);
       LocZ(i)=1;
    else
       LocZ(i)=0;
    end
end
LocZ=LocZ';