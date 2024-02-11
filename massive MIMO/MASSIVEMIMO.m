% Parameters
nAntennas = 8;      % Number of antennas at the base station
nUsers = 4;         % Number of users in the system
angularDegree = 0:15:165;   % Angular degrees of users
transmissionRate = zeros(nUsers, length(angularDegree));  % Matrix to store transmission rates

% Simulating transmission rates for different angular degrees
for user = 1:nUsers
    for angleIdx = 1:length(angularDegree)
        % Simulating transmission rate based on angular degree
        transmissionRate(user, angleIdx) = simulateTransmissionRate(angularDegree(angleIdx), nAntennas);
    end
end

% BER Calculation4
ber = calculateBER(transmissionRate); % Calculate BER
disp(ber);
% Energy Efficiency Calculation
energyEfficiency = calculateEnergyEfficiency(transmissionRate); % Calculate energy efficiency
% SNR Calculation
snr = calculateSNR(transmissionRate); % Calculate SNR in dB
% Quality of Service (QoS) Calculation
qos = calculateQoS(transmissionRate); % Calculate QoS
% Plotting BER vs. energyEfficiency
figure;
plot(energyEfficiency, ber, 'o-');
title('BER vs. energyEfficiency');
xlabel('energyEfficiency');
ylabel('BER');
% Energy Efficiency Calculation
energyEfficiency = calculateEnergyEfficiency(transmissionRate); % Calculate energy efficiency

% Plotting energy efficiency vs.ber
figure;
plot(snr, energyEfficiency, 'o-');
title('Energy Efficiency vs. snr');
xlabel('ber');
ylabel('Energy Efficiency');

% BER Calculation for different users
figure;
for user = 1:nUsers
    ber = calculateBER(transmissionRate(user, :)); % Calculate BER for a specific user
    subplot(2, 2, user); % Create a subplot for each user
    plot(qos, ber, 'o-');
    title(['User ', num2str(user)]);
    xlabel('qos');
    ylabel('BER');
end

% Plotting SNR vs. angular degree
figure;
plot(ber, snr, 'o-');
title('SNR vs.ber');
xlabel('Angular Degree');
ylabel('SNR (dB)');

% ZF Precoding
%transmittedSignalZF = zeros(nAntennas, length(angularDegree)); % Initialize transmitted signal matrix for ZF
precodingMatrixZF = calculateZF3(transmissionRate); % Calculate ZF precoding matrix

% Simulating transmission with ZF precoding
%for angleIdx = 1:length(angularDegree)
%    transmittedSignalZF(:, angleIdx) = precodingMatrixZF(:,:,angleIdx) * signal
%end

% Simulating transmission with ZF precoding
transmittedSignalZF = zeros(nAntennas, size(transmissionRate, 2));
signal = rand(4, 1); % Generate a random signal with 4 rows and 1 column

%for angleIdx = 1:size(transmissionRate, 2)
   % % Multiply the ZF precoding matrix with the signal vector for each angle
    %transmittedSignalZF(:, angleIdx) = precodingMatrixZF(:,:,angleIdx) .* signal;
%end


% Plotting QoS vs. transmissionRate
figure;
plot(transmissionRate, qos, 'o-');
title('QoS vs. transmissionRate');
xlabel('throughput');
ylabel('QoS');

% Throughput Calculation
throughput = calculateThroughput(transmissionRate); % Calculate throughput

% Plotting throughput vs. transmissionRate
figure;
plot(transmissionRate, throughput, 'o-');
title('Throughput vs. Angular Degree');
xlabel('transmissionRate');
ylabel('Throughput');




% PAPR Calculation
papr = calculatePAPR(transmissionRate); % Calculate PAPR

% Plotting PAPR vs. angular degree
figure;
plot(signal, papr, 'o-');
title('PAPR vs. signal');
xlabel('signal');
ylabel('PAPR');

% Precoding Techniques
transmittedSignal = zeros(nAntennas, length(angularDegree)); % Initialize transmitted signal matrix
precodingMatrix = calculatePrecodingMatrix(transmissionRate); % Calculate precoding matrix



