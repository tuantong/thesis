%XAC DINH TAI DAI DIEN DUA TREN GIAI THUAT FKM VA CAC TIEU CHUAN PHAN NHOM MO

clc;
disp('========================================================================================');
disp('XAC DINH TAI DAI DIEN DUA TREN GIAI THUAT FKM VA CAC TIEU CHUAN PHAN NHOM MO');
disp('========================================================================================');
disp(' ');
clear all;

%--------------------------------------------------------------------------
v=cputime;
%--------------------------------------------------------------------------

%NHAP CAC GIA TRI DAU VAO TRUOC KHI FKM

%Chuyen du lieu tu HCM2005.xls vao
   %Du lieu ngay
   Dulieungay=xlsread('E:\Cong-Tuan\HCM05.xls',1,'A3:A367');
   Dulieungay=Dulieungay+693960;
   

   %Du lieu phu tai
   Dulieuphutai=xlsread('E:\Cong-Tuan\HCM05.xls',1,'B3:Y367');
   [n,m]=size(Dulieuphutai);

%Tinh Dulieuphutai thanh dvtd1, dvtd2 va ma tran 4 he so
[Dulieudvtd1,Dulieudvtd2,Dulieu4heso]=docdulieu(Dulieuphutai,n,m);

%Tach Dulieuphutai thanh ngay thuong va ngay nghi
   %Locngay3 xet den ngay le am lich va cac ngay nghi bu cho tat ca cac ngay le
      Locngay3=xlsread('E:\Cong-Tuan\HCM05.xls',2,'A3:A367');
[Dulieuphutaingaythuong,Dulieungaythuong,Dulieuphutaingaynghi,Dulieungaynghi]=tachngay(Dulieuphutai,Dulieungay,n,Locngay3);

kmax=input('Nhap so phan nhom toi da kmax = ');
disp(' ');
disp('Lua chon du lieu dau vao');
disp('1)He co ten ca nam');
disp('2)He dvtd1 ca nam (chia cho max nhat cua toan ma tran)');
disp('3)He dvtd2 ca nam (chia cho max cua tung ngay)');
disp('4)He co ten ngay thuong');
disp('5)He co ten ngay nghi');
disp('6)He dvtd1 ngay thuong');
disp('7)He dvtd2 ngay thuong');
disp('8)He dvtd1 ngay nghi');
disp('9)He dvtd2 ngay nghi');
disp('10)Du lieu 4 he so cua he co ten ca nam');
input_num=input('Chon: ');
disp(' ');
disp('Lua chon toi uu giua cac tieu chuan');
disp('1)Theo nguyen tac Bellmand-Zadeh');
disp('2)Theo phuong phap muc tieu toan cuc');
input_toiuu=input('Chon: ');
disp(' ');

switch input_num
    case 1
        Dulieu=Dulieuphutai;
        Ngay=Dulieungay;
    case 2
        Dulieu=Dulieudvtd1;
        Ngay=Dulieungay;
    case 3
        Dulieu=Dulieudvtd2;
        Ngay=Dulieungay;
    case 4
        Dulieu=Dulieuphutaingaythuong;
        Ngay=Dulieungaythuong;
    case 5
        Dulieu=Dulieuphutaingaynghi;
        Ngay=Dulieungaynghi;
    case 6
        Dulieu=Dulieuphutaingaythuong;
        Dulieu=Dulieu./max(max(Dulieu));
        Ngay=Dulieungaythuong;
    case 7
        Dulieu=Dulieuphutaingaythuong;
        Dulieu=Dulieu./repmat((max(Dulieu'))',1,size(Dulieu,2));
        Ngay=Dulieungaythuong;
    case 8
        Dulieu=Dulieuphutaingaynghi;
        Dulieu=Dulieu./max(max(Dulieu));
        Ngay=Dulieungaynghi;
    case 9
        Dulieu=Dulieuphutaingaynghi;
        Dulieu=Dulieu./repmat((max(Dulieu'))',1,size(Dulieu,2));
        Ngay=Dulieungaynghi;
    case 10
        Dulieu=Dulieu4heso;
        Ngay=Dulieungay;
    otherwise
        Dulieu=Dulieuphutai;
        Ngay=Dulieungay;
end   
[n,m]=size(Dulieu);        
disp('----------------------------------------------------------------------------------------');
disp(' ');
disp('Chuong trinh dang tinh......');

%Tao ra [AlphaK_dau] gom alpha=1.1~2.0 va k=2~kmax
Alpha=[];%tao ra ma tran [Alpha]
for q=1:(kmax-1):(19*(kmax-1)-kmax+2)
    alpha=0.05*q/(kmax-1)+1.1-0.05/(kmax-1);
    for c=0:(kmax-2);
        Alpha(q+c,1)=alpha;
    end
end
K=2:kmax;%tao ra ma tran [K]
K=(repmat(K,1,19))';
AlphaK_dau=[Alpha K];%ghep 2 ma tran [Alpha] [K]

%--------------------------------------------------------------------------

%CHAY FKM VOI DAU VAO LA MA TRAN [AlphaK_dau] DAU RA LA [Tieuchuan] 

Tieuchuan=[];
AlphaK=AlphaK_dau;
gmax=size(AlphaK,1);
for g=1:gmax
    alpha=AlphaK(g,1);
    k=AlphaK(g,2);
        
    %Chay chuong trinh con fkm tinh ra [Z], [D], [W] cho alpha-k tren
    [Z,D,W,F]=fkm(Dulieu,alpha,k,n);
        
    %Tao ra ma tran [Tieuchuan] gom alpha, k, v_PC, v_PE, v_MPC, v_XB, v_K, v_PBMF, v_W

     %Tinh tieu chuan v_PC
      v_PC=1/n*sum(sum(W.*W));

     %Tinh tieu chuan v_PE
      v_PE=-1/n*sum(sum(W.*log(W))); %chon loga la log co so 10

     %Tinh tieu chuan v_MPC
      v_MPC=1-k/(k-1)*(1-v_PC);

     %Tinh tieu chuan v_XB
      Dhi=[];
      for h=1:k
           for i=1:k
                Dhi(h,i)=sqrt(sum(((Z(h,:)-Z(i,:)).^2)'));
           end
      end
      maxdhi=2*max(max(Dhi));%tao ra so nay de bo di nhung vi tri h=i
      Dhitam=Dhi+maxdhi*eye(k,k);
      sep=min(min(Dhitam))+eps;
      v_XB=F/n/(sep*sep);

     %Tinh tieu chuan v_PBMF
      Dulieutb=1/n*sum(Dulieu);
      Dulieutb=repmat(Dulieutb,n,1);
      E1=Dulieu-Dulieutb;
      E1=((sum((E1.*E1)'))').^0.5;
      E1=sum(E1);
      Dc=max(max(Dhi));   %dung Dhi trong v_XB
      Jm=(W.^alpha).*D;
      Jm=sum(sum(Jm));
      v_PBMF=(1/k*E1*Dc/Jm)^2;	

     %Tinh tieu chuan v_W
      Wxoay=[W(:,2:k) W(:,1)];
      Septam=[];
      for j=1:n
          for i=1:k
              Septam(j,i)=min(W(j,i),Wxoay(j,i));
         end
      end
      sepw=1-max(max(Septam));
      betaw=1/n*sum(Dulieu);
      betaw=repmat(betaw,n,1);
      betaw=Dulieu-betaw;
      betaw=sum((betaw.*betaw)');
      betaw=(1/n*sum(betaw))^-1;
      Dw=(ones(n,k)-exp(-1*betaw*(D.*D))).^0.5;
      Ni=W;%tinh so phan tu trong k nhom
      for j=1:n
          for i=1:k
               if Ni(j,i)==max(Ni(j,:))
                  Ni(j,i)=1;
                  Ni(j,(i+1):end)=0;
              end
              if Ni(j,i)~=max(Ni(j,:))
                Ni(j,i)=0;
              end
         end
     end
     Ni=sum(Ni)+eps;
     varw=(sum((sum(W.*(Dw.*Dw)))./Ni))*sqrt((k+1)/(k-1));
     v_W=varw/sepw;

     %tao ra [Tieuchuan]
     Tieuchuan(g,1)=alpha;
     Tieuchuan(g,2)=k;
     Tieuchuan(g,3)=v_PC;
     Tieuchuan(g,4)=v_PE;
     Tieuchuan(g,5)=v_MPC;
     Tieuchuan(g,6)=v_XB;
     Tieuchuan(g,7)=v_PBMF;
     Tieuchuan(g,8)=v_W;

end

%--------------------------------------------------------------------------

%CHAY CHUONG TRINH CON alphak_sau hay alphak_saumax TINH [AlphaK_sau] TU [Tieuchuan]

%Dau tien: ung voi 1 alpha chon ra 1 k  thoa man v_XBalpha min
%Sau do: chi chon duy nhat 1 k xuat hien nhieu nhat (on dinh)
%nhu vay di kem voi k duy nhat do la 1 day alpha tuong ung
if input_toiuu==2
  [AlphaK_sau,Thamkhao]=alphak_sau(Tieuchuan,kmax);
else
  [AlphaK_sau,Thamkhao]=alphak_saumax(Tieuchuan,kmax);
end

%--------------------------------------------------------------------------

%CHAY TINH RA [Zrep] VOI DAU VAO LA [AlphaK_rep]

%Lay ra min va max cua alpha trong [AlphaK_sau] ta duoc [AlphaK_rep]
AlphaK_rep=[AlphaK_sau(1,:); AlphaK_sau(size(AlphaK_sau,1),:)];

%Chay FKM cho 2 cap alpha-k tren (k bang nhau)
AlphaK=AlphaK_rep;%nhap thong so dau vao cho [AlphaK]
gmax=size(AlphaK,1);
for g=1:gmax
    alpha=AlphaK(g,1);
    k=AlphaK(g,2);
    
    %chay chuong trinh con fkm tinh ra Z, D, W cho alpha-k tren
    [Z,D,W,F]=fkm(Dulieu,alpha,k,n);
    Zreptam=Z;
    Wreptam=W;
    
    %chay chuong trinh con phantram tinh ra [Phantram]
    [Phantram,LocZ,Ntam]=phantram(W,k,n);%phan tram cua so phan tu thuoc k nhom 
    Phantramreptam=Phantram;
    LocZreptam=LocZ;
    Nreptam=Ntam;    

    %tinh [Zrep] tu [Zreptam], [Phantramreptam] va LocZreptam
    y=max(Phantramreptam);
    if y>66.67
       Zrep=sum(diag(LocZreptam)*Zreptam);
       alpharep=alpha;
       break
    else
       Zrep=sum(diag(1/100*Phantramreptam)*Zreptam);
       alpharep=alpha;
    end
    
end
krep=AlphaK_rep(1,2);
Wrep=Wreptam;
Phantramrep=Phantramreptam;
Nrep=Nreptam;

%--------------------------------------------------------------------------

%CHUONG TRINH VE CAC HINH SAU:
%DO THI PHU TAI 3D LUC DAU
%DO THI PHU TAI 3D LUC SAU DUA VAO Nrep
%[Zreptam]: VE Z CUA TUNG NHOM VA VE DONG THOI CAC Z
%[Zrep]
k=krep;
Gio=1:24;
[i]=ve(Zreptam,Zrep,k,m,Nrep,Gio,Dulieu,n);

%--------------------------------------------------------------------------
disp(' ');
%Cac ket qua
disp('Cac ket qua:');
Dai_dien=Zrep
So_nhom=krep
Do_mo=alpharep
Cac_tam=Zreptam
for i=1:k
    chunhom=num2str(i);
    chunhom1=['Nhom ' chunhom ' gom'];
    disp(chunhom1);
    Cac_ngay=diag(Nrep(:,i))*Ngay;
    Cac_ngay=sortrows(Cac_ngay,1);
    demkhaczero=0;
    for j=1:n
        if Cac_ngay(j)~=0
            demkhaczero=demkhaczero+1;
        end
    end
    Cac_ngay(1:(n-demkhaczero),:)=[];
    Cac_ngay=(datestr(Cac_ngay))
end

%--------------------------------------------------------------------------

%Ve do thi so sanh giua trung binh va dai dien
for i=1:n
    plot(1:m,Dulieu(i,:));
    hold on;
end
Ztb=mean(Dulieu);
plot(1:m,Ztb,'-*M','LineWidth',2);
set(gca,'XTick',0:2:(n+2));
plot(1:m,Zrep,'-*g','LineWidth',2,'MarkerEdgeColor','r');
set(gca,'XTick',0:2:(n+2));
grid on;

%--------------------------------------------------------------------------

Zreptren=Zrep+10/100*Zrep;
Zreptrenmat=repmat(Zreptren,n,1);
Zrepduoi=Zrep-10/100*Zrep;
Zrepduoimat=repmat(Zrepduoi,n,1);

Ztbtren=mean(Dulieu)+10/100*mean(Dulieu);
Ztbtrenmat=repmat(Ztbtren,n,1);
Ztbduoi=mean(Dulieu)-10/100*mean(Dulieu);
Ztbduoimat=repmat(Ztbduoi,n,1);
SSrep1=Zreptrenmat-Dulieu;
SSrep2=Dulieu-Zrepduoimat;
SStb1=Ztbtrenmat-Dulieu;
SStb2=Dulieu-Ztbduoimat;
SSrep=[];
for j=1:n
    if (SSrep1(j,:)>=0)&(SSrep2(j,:)>=0)
       SSrep(j,:)=1;
    else
       SSrep(j,:)=0;
    end
end

SStb=[];
for j=1:n
    if (SStb1(j,:)>0)&(SStb2(j,:)>0)
       SStb(j,:)=1;
    else
       SStb(j,:)=0;
    end
end
So_sanh_Dai_dien_va_TBC= [sum(SSrep) sum(SStb)]

%--------------------------------------------------------------------------

ngaunhien=randperm(n);
ngaunhien=ngaunhien(1);
Daidien_Ngaunhien=[Zrep; Dulieu(ngaunhien,:)];
Q1(1)=mean(Daidien_Ngaunhien(1,:))/max(Daidien_Ngaunhien(1,:));
Q1(2)=mean(Daidien_Ngaunhien(2,:))/max(Daidien_Ngaunhien(2,:));
Dulieuhesophutai=Q1';

Q2tam=Daidien_Ngaunhien(1,:)*Daidien_Ngaunhien(1,:)';
Q2tam=Daidien_Ngaunhien(2,:)*Daidien_Ngaunhien(2,:)';
Q2(1)=sqrt(Q2tam/24)/mean(Daidien_Ngaunhien(1,:));
Q2(2)=sqrt(Q2tam/24)/mean(Daidien_Ngaunhien(2,:));
Dulieuhesohinhdang=Q2';

Q3(1)=min(Daidien_Ngaunhien(1,:))/max(Daidien_Ngaunhien(1,:));
Q3(2)=min(Daidien_Ngaunhien(2,:))/max(Daidien_Ngaunhien(2,:));
DulieuhesoPminchiaPmax=Q3';

Q4(1)=mean(Daidien_Ngaunhien(1,:))/min(Daidien_Ngaunhien(1,:));
Q4(2)=mean(Daidien_Ngaunhien(2,:))/min(Daidien_Ngaunhien(2,:));
DulieuhesoPtbchiaPmin=Q4';

Dulieu4heso_Daidien_va_Ngaunhien=[Dulieuhesophutai Dulieuhesohinhdang DulieuhesoPminchiaPmax DulieuhesoPtbchiaPmin]

%--------------------------------------------------------------------------

CPUtime=cputime-v;
save Luutru


    
    
    
    
    
    
