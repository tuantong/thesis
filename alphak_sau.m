function [AlphaK_sau,Thamkhao]=alphak_sau(Tieuchuan,kmax);

%Tao ra [Tieuchuan_loc]: ung voi 1 alpha chon ra 1 k tu [Tieuchuan], thoa
%dieu kien v_XB min
Tieuchuan_loc=[];
A=[];
for p=1:19
    e1=(kmax-1)*p-(kmax-2);
    e2=(kmax-1)*p;
    A=Tieuchuan(e1:e2,:);
    for i=3:8
        A(:,i)=A(:,i)./max(A(:,i));
    end
    Tam=[max(A(:,3)) min(A(:,4)) max(A(:,5)) min(A(:,6)) max(A(:,7)) min(A(:,8))];
    Tam=repmat(Tam,(kmax-1),1);
    GC=(Tam-A(:,3:8))./Tam;
    GC=sum((GC.*GC)');
    GC=GC';
    A=[A GC];
    A=sortrows(A,9);
    Tieuchuan_loc(p,:)=A(1,:);
end
Tieuchuan_loc=sortrows(Tieuchuan_loc,2);
Thamkhao=Tieuchuan_loc;
Tieuchuan_loc(:,3:end)=[];

%Tao ra [AlphaK_sau], chi chon k xuat hien nhieu nhat (on dinh) trong
%[Tieuchuan_loc]
B=[];
for p=1:19
    for c=1:(kmax-1)
        knhom=c+1;
        if Tieuchuan_loc(p,2)==knhom
            B(p,c)=1;
        else
            B(p,c)=0;
        end
    end
end
C=sum(B);
x=max(C);
E=[];
for c=1:(kmax-1)
    if C(c)==x
       E(c)=1;
    else
       E(c)=0;
    end
end
G=(sum((B*diag(E))'))';
AlphaK_sau=diag(G)*Tieuchuan_loc;
AlphaK_sau=sortrows(AlphaK_sau,-2);
AlphaK_sau((x+1):19,:)=[];
AlphaK_sau=sortrows(AlphaK_sau,1);