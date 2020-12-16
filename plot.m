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

%% 1.2) 
% 
% As M increases these frequencies are attenuated further. This is the
% behaviour of a low pass filter
%
%  
% The zero frequency amplitude is unchanged. It signifies that
% sum  of the signal values in the window of the average moving filter.
% From the mathematical point of view it is the fourrier transformation of the
% response at null frequency

%% 1.3
% 
figure(2)
phi=angle(X)/pi;
for n=1:i
plot(f(n,:),phi(n,1:Fs/2+1),'LineWidth',1.2);
hold on;
end
xlabel('Normalized frequency','Fontsize',12);
ylabel('Phase angle','FontSize',12);
grid on;
leg=legend('M=5','M=21','M=51');
leg.FontSize=12;
hold off

%% 1.4
% The amplitude frequency response consist of several periodic peaks.
% Meaning that the phase angle are periodic with respect to frequency.
% The moving filter is an average of a signal over a given window of size M the size of that window is the size  

%% 1.5
i=0;
figure(3)
for M=e
    
i=i+1;
g = grpdelay(ones(1,M)./M, 1, 1024, 'whole');
plot(f(i,:),g(1:Fs/2+1));
axis([0 0.5 0 30])
gtext([num2str(M)]);
hold on;
end
grid on;
ylabel("\bf Group Delay (Samples)")
xlabel("\bf Normalized Frequency")
hold off