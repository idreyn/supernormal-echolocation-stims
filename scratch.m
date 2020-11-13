% Estimation of Impulse response of an LTI system 
% https://www.gaussianwaves.com 
% License:Creative Commons: CC-BY-NC-SA
clear;
clc;
Fs=1000; %Sampling Frequency
Fc=400; %Cut-off Frequency

w = Fc/(Fs/2); %Normalized frequency
%Design a low pass fitler with above mentioned specifications
[b,a]=butter(5,w,'low'); %5th order butterworth LPF
[h,w]=freqz(b,a,1024); %Frequency response of the filter

figure;
plot(w/pi*Fs/2,abs(h));
title('Frequency Response of a 5th Order Butterworth LPF');
xlabel('Frequency (Hz)')
ylabel('Magnitude');
grid;

%Finding the Actual Impulse response of the LPF by applying a %generated impulse
N=128;
impulse=[1,zeros(1,N)]; %Defining an impulse
h=filter(b,a,impulse); %Apply the generated impulse at the filter's %input

figure;
subplot(2,1,1);
plot(h/max(h)); % Plot the normalized impulse response
title('Actual impulse response');
grid;

% Using Cross-Correlation to find the impluse response of the %LPF . Here the impulse response of the LPF is pretended to be %unknown and we are trying to estimate the impluse response %by cross-correlating the  output of the filter with AWGN input. %Verify the result by comparing actual response and the %estimated response

for i=1: 128 % Run Simulation for 128 times
    x=randn(1,N); % AWGN samples
    y=filter(b,a,x); % Drive the filter with the AWGN samples 

    rxy=xcorr(x,y); % Cross correlation of the AWGN and the filter output
    Ryx=fliplr(rxy(1:N)); % Flip the correlation result and take the first N samples (Ryx(t) = Rxy(-t)

    %or replace the last two lines with this
    %ryx=xcorr(y,x);
    %Ryx=ryx(N:end)

    PA(:,i)=Ryx'; %Store the results in an array
end;
clear Ryx; 

Ryx=sum(PA')/128; % Average the values got during all the simulation runs

subplot(2,1,2);
plot(Ryx/max(Ryx)); % Plot the estimated impulse response
title('Estimated Impulse Response');
grid;