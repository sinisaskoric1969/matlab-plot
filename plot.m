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

%% 2.3
% This is a low pass filter
% cut off frequency =0.2099Hz
%% 2.4
% group delay is a constant 5 samples
%%  2.5
p=p+1;
figure(p);
k=(-1).^(0:length(h_n)-1);
h2=k.*h_n;
X2=fft(h2,1024);
f2=(0:Fs/2)/Fs;
Y2=abs(X2);
phi=unwrap(angle(X2))/pi;
Y3=20*log10(abs(X2)./max(abs(X2)));
subplot(211)
plot(f2,Y3(1:Fs/2+1),'LineWidth',1.2);
xlabel('\bf Normalized frequency')
ylabel('\bf \fontsize{12}Impulse response h')
title('\bf Frequency Response Q(2.5)')

grid on;
subplot(212)
plot(f2,phi(1:Fs/2+1),'LineWidth',1.2);
grid on;
xlabel('\bf Normalized frequency')
ylabel('\bf \fontsize{12}Phase delay[rads]')

p=p+1;
figure(p);
g = grpdelay(h2, 1, 1024, 'whole');
plot(f2,g(1:Fs/2+1));
ylabel("\bf Group Delay (Samples)");
xlabel("\bf Normalized Frequency");
title('\bf Group Delay Q(2.5)');

%% 2.6 
% This is a high pass filter
%
% cut off frequency is 2.9Hz
%
% Group delay is unchanged to five samples
%% 3.1 
% 
b=[0.206572 0.413144 0.206572];
a=[0.369527 -0.195816];
h31=filter(b,a,[1 zeros(1,15)]);
p=p+1;
figure(p);
stem(0:15,h31);
xlabel('\bf n')
ylabel('\bf impulse response h')
grid on;
title('\bf Impulse response Q3.1')

%% 3.2
[X2,w2]=freqz(b,a,1024);
f2=(0:Fs/2)/Fs;
Y2=abs(X2);
phi=unwrap(angle(X2))/pi;
Y3=20*log10(abs(X2)./max(abs(X2)));
p=p+1;
figure(p);

subplot(211)
plot(f2,Y3(1:Fs/2+1),'LineWidth',1.2);
xlabel('\bf Normalized frequency')
ylabel('\bf \fontsize{12}Amplitude[dB]')
title('\bf Frequency Response Q3.2')
grid on;
subplot(212)
plot(f2,phi(1:Fs/2+1),'LineWidth',1.2);
grid on;

xlabel('\bf Normalized frequency')
ylabel('\bf \fontsize{12}Phase delay[rads]')
p=p+1;
figure(p);
g = grpdelay(h31, 1, 1024, 'whole');
plot(f2,g(1:Fs/2+1));
ylabel("\bf Group Delay (Samples)");
xlabel("\bf Normalized Frequency");
title('\bf Group Delay Q3.2');

%% 3.3 
% This IIR is a low pass filter and has lower cutoff frequency at .17Hz
% The group delay is also reduced however it is no longer constant. The
% amplitude response no longer have minor peaks. The attenuation is havier. 
%% 3.4
alpha=-.9
b=[alpha,1];
a=[1,alpha];
h34=filter(b,a,[1,zeros(1,15)]);
[X2,w2]=freqz(b,a,1024);
f2=(0:Fs/2)/Fs;
Y2=abs(X2);
phi=unwrap(angle(X2))/pi;
Y3=20*log10(abs(X2)./max(abs(X2)));
p=p+1;
figure(p);
subplot(211)
plot(f2,abs(X2(1:Fs/2+1)),'LineWidth',1.2);
grid on;
xlabel('\bf Normalized Frequency')
ylabel('\bf Amplitude ')
title('\bf Q3.4')
subplot(212)
plot(f2,phi(1:Fs/2+1),'LineWidth',1.2);
xlabel('\bf Normalized Frequency')
ylabel('\bf Phase angle [radian]')
grid on;

%
%The amplitude response is a constant 1 meaning all frequency are allowed to pass thus an all pass filter.  
% however the delays present do modify the input signal.
p=p+1;
figure(p);
g = grpdelay(h34, 1, 1024, 'whole');
plot(f2,g(1:Fs/2+1));
ylabel("\bf Group Delay (Samples)");
xlabel("\bf Normalized Frequency");
title('\bf Group Delay Q(3.4) ');

%% 3.5
alpha=-.15;
b1=[alpha,1];
a1=[1,alpha];
a2=[1,1];
b2=[1,1];
h35=0.5*(filter(b1,a1,[1,zeros(1,15)])+filter(b2,a2,[1,zeros(1,15)]));
[A1,w1]=freqz(b1,a1,1024);
[A2,w2]=freqz(b2,a2,1024);
X2=0.5*(A1+A2);
f2=(0:Fs/2)/Fs;
Y1=abs(X2);
phi=unwrap(angle(X2))/pi;
Y3=20*log10(abs(X2)./max(abs(X2)));
p=p+1;
figure(p);
subplot(211)
plot(f2,(Y3(1:Fs/2+1)),'LineWidth',1.2);
grid on;
xlabel('\bf Normalized Frequency')
ylabel('\bf Amplitude [dB]')
title('\bf{}')
subplot(212)
plot(f2,phi(1:Fs/2+1),'LineWidth',1.2);
xlabel('\bf Normalized Frequency')
ylabel('\bf Phase angle [radian]')
grid on;
p=p+1;
figure(p);
g = grpdelay(h35, 1, 1024, 'whole');
plot(f2,g(1:Fs/2+1));
ylabel("\bf Group Delay (Samples)");
xlabel("\bf Normalized Frequency");
title('\bf Group Delay Q3.5');
axis([0  .5 -1 5])