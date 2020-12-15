%% 1

%% 1.1
e=[5 21 51];
w=2*pi*(0:.001:.5);
%movingfilter=ones(1,M)./M
% moving filter response h(n)= 1/M( u(n)-u(n*M))
% u(N) step signal;
Fs=1024;
n=-2*(e(1)):(1/Fs):2*e(1);
h=1/e(1)*(heaviside(n)-heaviside(n-e(1)));

figure(1);
i=0;
for M=e
i=i+1;
X(i,:)=fft(ones(1,M)./M,Fs);
f(i,:)=(0:Fs/2)/Fs;
Y=abs(X(i,:));
plot(f(i,:),Y(1:Fs/2+1),'LineWidth',1.2);
gtext([num2str(M)]);
hold on;
end
hold off
xlabel('Normalized frequency','Fontsize',12)
ylabel('Magnitude','FontSize',12)

grid on;
leg=legend('M=5','M=21','M=51');
leg.FontSize=12;