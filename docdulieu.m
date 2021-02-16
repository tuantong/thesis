function [Dulieudvtd1,Dulieudvtd2,Dulieu4heso]=docdulieu(Dulieuphutai,n,m);

%Du lieu phu tai trong don vi tuong doi dang 1
for j=1:n
    for l=1:m
        Dulieudvtd1(j,l)=Dulieuphutai(j,l)/max(max(Dulieuphutai));
    end   
end

%Du lieu phu tai trong don vi tuong doi dang 2
for j=1:n
    for l=1:m
        Dulieudvtd2(j,l)=Dulieuphutai(j,l)/max(Dulieuphutai(j,:));
    end
end

%Du lieu he so phu tai
for j=1:n
    Q1(j)=mean(Dulieuphutai(j,:))/max(Dulieuphutai(j,:));
end
Dulieuhesophutai=Q1';

%Du lieu he so hinh dang
for j=1:n
    Q2tam=Dulieuphutai(j,:)*Dulieuphutai(j,:)';
    Q2(j)=sqrt(Q2tam/24)/mean(Dulieuphutai(j,:));
end
Dulieuhesohinhdang=Q2';

%Du lieu he so Pmin/Pmax
for j=1:n
    Q3(j)=min(Dulieuphutai(j,:))/max(Dulieuphutai(j,:));
end
DulieuhesoPminchiaPmax=Q3';

%Du lieu he so Ptb/Pmin
for j=1:n
    Q4(j)=mean(Dulieuphutai(j,:))/min(Dulieuphutai(j,:));
end
DulieuhesoPtbchiaPmin=Q4';


Dulieu4heso=[Dulieuhesophutai Dulieuhesohinhdang DulieuhesoPminchiaPmax DulieuhesoPtbchiaPmin];

