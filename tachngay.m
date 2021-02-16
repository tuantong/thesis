function [Dulieuphutaingaythuong,Dulieungaythuong,Dulieuphutaingaynghi,Dulieungaynghi]=tachngay(Dulieuphutai,Dulieungay,n,Locngay3);

%Locngay1 xet nhung ngay chu nhat
Locngay1tam=mod(Dulieungay+6,7);
Locngay1=[];
for j=1:n
    if Locngay1tam(j)==1 
       Locngay1(j)=0;
    else
       Locngay1(j)=1;
    end
end
Locngay1=Locngay1';

%Locngay2 xet nhung ngay le duong lich
Ngaychu=datestr(Dulieungay);
Matranngay=datevec(Ngaychu);
Locngay2=[];
for j=1:n
    if ((Matranngay(j,3)==30)&(Matranngay(j,2)==04))|((Matranngay(j,3)==01)&(Matranngay(j,2)==05))|((Matranngay(j,3)==02)&(Matranngay(j,2)==09))|((Matranngay(j,3)==01)&(Matranngay(j,2)==01))
       Locngay2(j)=0;
    else
       Locngay2(j)=1;
    end
end
Locngay2=Locngay2';

%Locngay3 xet den ngay le am lich va cac ngay nghi bu cho tat ca cac ngay le

%Locngay xet tat ca cac ngay nghi
Locngay=(Locngay1.*Locngay2).*Locngay3;

Dulieuphutaingaythuong=diag(Locngay)*Dulieuphutai;
Dulieungaythuong=diag(Locngay)*Dulieungay;
Dulieuphutaingaythuongtam=[];
Dulieungaythuongtam=[];
for p=1:n
    if Dulieuphutaingaythuong(p,:)~=0
       Dulieuphutaingaythuongtam=[Dulieuphutaingaythuongtam;Dulieuphutaingaythuong(p,:)];
       Dulieungaythuongtam=[Dulieungaythuongtam;Dulieungaythuong(p,:)];
    end
end
Dulieuphutaingaythuong=Dulieuphutaingaythuongtam;
Dulieungaythuong=Dulieungaythuongtam;

Dulieuphutaingaynghi=diag(1-Locngay)*Dulieuphutai;
Dulieungaynghi=diag(1-Locngay)*Dulieungay;
Dulieuphutaingaynghitam=[];
Dulieungaynghitam=[];
for p=1:n
    if Dulieuphutaingaynghi(p,:)~=0
       Dulieuphutaingaynghitam=[Dulieuphutaingaynghitam;Dulieuphutaingaynghi(p,:)];
       Dulieungaynghitam=[Dulieungaynghitam;Dulieungaynghi(p,:)];
    end
end
Dulieuphutaingaynghi=Dulieuphutaingaynghitam;
Dulieungaynghi=Dulieungaynghitam;