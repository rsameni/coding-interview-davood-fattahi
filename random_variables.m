clear
close all
clc




%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2-a
n=1000;
X={0; 1};
% X={0; "a"};



%%%%%%%%%%%
% 2-b
X=string(X);
m=length(X);
Y = X(randi(m, [n,1]));
Z = [length(Y(Y==X{1})), length(Y(Y==X(2)))];


%%%%%%%
% 2-c
% binomial test
p0=0.5*ones(size(Z));
pval=myBinomTest(Z,n,p0);
% pval = nchoosek(n,Z(1)).*(p0(1).^Z(1)).*(1-p0(1)).^(n-Z(1))

%%%%%%%%%%%
% alternative binomial test --> Pearson chi2 test 
% chi2gof(W(:,1));


%%%%%%%%%%%%%
% 2-d
W = zeros(1000,2);
for r=1:1000
    n=1000;
    X={0; 1};
    X=string(X);
    m=length(X);


    Y = X(randi(m, [n,1]));
    Z = [length(Y(Y==X{1})), length(Y(Y==X(2)))];

    p0=0.5*ones(size(Z));
    W(r,:)=myBinomTest(Z(:),n,p0(:));
%     W(r,1) = nchoosek(n,Z(1)).*(p0(1).^Z(1)).*(1-p0(1)).^(n-Z(1));
end
figure
histogram(sum(W,2))

savefig('hist_pval.fig')

[h, pval2] = chi2gof(W(:,1));


%%%%%%




