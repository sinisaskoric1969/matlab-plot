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

%% 1.6
% constant group delay means linear relation between phase delay and frequency. 
%% 2.1
figure(4)
h_n=[0.00506, 0, -0.04194, 0, 0.28848, 0.49679, 0.28848, 0, -0.04194, 0, 0.00506];
stem(0:10,h_n);
ylabel('Impulse response ')
xlabel('\bf \fontsize{12} n')
title('\bf Q(2.1)')
grid on;

%% 2.2
figure(5)

X2=fft(h_n,1024);
f2=(0:Fs/2)/Fs;
Y2=abs(X2);
phi=unwrap(angle(X2))/pi;
Y3=20*log10(abs(X2)./max(abs(X2)));
subplot(211)
plot(f2,Y3(1:Fs/2+1),'LineWidth',1.2);
xlabel('\bf Normalized frequency')
ylabel('\bf \fontsize{12}Impulse response h')
title('\bf Frequency Response Q(2.2)')

grid on;
subplot(212)
plot(f2,phi(1:Fs/2+1),'LineWidth',1.2);
grid on;
figure(6)
g = grpdelay(h_n, 1, 1024, 'whole');
plot(f2,g(1:Fs/2+1));
ylabel("\bf Group Delay (Samples)")
xlabel("\bf Normalized Frequency")
title('\bf Group Delay Q(2.2)')
p=6;