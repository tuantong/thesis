function [i]=ve(Zreptam,Zrep,k,m,Nrep,Gio,Dulieu,n);

%Do thi phu tai Tp HCM 2005 luc dau
Mau=0:(1/(n-1)):1;
Mau=Mau';
Mau=Mau(:,ones(m,1));
surf(Gio,(1:n),Dulieu,Mau);
set(gca,'XTick',0:2:(m+2),'YTick',0:30:(n+30));
title('Do Thi Phu Tai 3D Ca Nam Cua Tp HCM 2005 Luc Dau');
xlabel('Gio (h)');
ylabel('Ngay');
zlabel('Cong Suat (MW)');
figure;

%Do thi phu tai Tp HCM luc da phan nhom
Locmau=0:(1/(k-1)):1;
Mausau=Nrep*diag(Locmau);
Mausau=(sum(Mausau'))';
Mausau=Mausau(:,ones(m,1));
surf(Gio,(1:n),Dulieu,Mausau);
set(gca,'XTick',0:2:(m+2),'YTick',0:30:(n+30));
title('Do Thi Phu Tai 3D Ca Nam Cua Tp HCM 2005 Luc Da Phan Nhom');
xlabel('Gio (h)');
ylabel('Ngay');
zlabel('Cong Suat (MW)');
figure;

%Ve [Zreptam] va Zrep ket qua
for i=1:k
    plot(1:m,Zreptam(i,:));
    set(gca,'XTick',0:2:(m+2));
    chuso=num2str(i);
    chu1=['Do Thi Phu Tai Center Nhom ' chuso ' Cua Tp HCM 2005'];
    title(chu1);
    xlabel('Gio (h)');
    ylabel('Cong Suat (MW)');
    grid on;
    figure;
end

for i=1:k
    plot(1:m,Zreptam(i,:));
    set(gca,'XTick',0:2:(m+2));
    grid on;
    hold on;
end
    chu2=['Do Thi Phu Tai ' chuso ' Center Cua Tp HCM 2005']; 
    title(chu2);
    xlabel('Gio (h)');
    ylabel('Cong Suat (MW)');
figure;

plot(1:m,Zrep,'-*g','LineWidth',2,'MarkerEdgeColor','r');
set(gca,'XTick',0:2:(n+2));
title('Do Thi Tai Dai Dien Cua Tp HCM 2005');
xlabel('Gio (h)');
ylabel('Cong Suat (MW)');
grid on;
