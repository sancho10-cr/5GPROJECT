% Parameters
nAntennas = 8;      % Number of antennas at the base station
nUsers = 4;         % Number of users in the system
angularDegree = 0:15:165;   % Angular degrees of users
transmissionRate = zeros(nUsers, length(angularDegree));  % Matrix to store transmission rates
signal = rand(nAntennas, 1);   % Random transmitted signal for testing


% Simulating transmission rates for different angular degrees
for user = 1:nUsers
    for angleIdx = 1:length(angularDegree)
        % Simulating transmission rate based on angular degree
        transmissionRate(user, angleIdx) = simulateTransmissionRate(angularDegree(angleIdx), nAntennas);
    end
end

% BER Calculation
ber = calculateBER(transmissionRate); % Calculate BER

% Plotting BER vs. angular degree for all users
figure;
for user = 1:nUsers
    plot(angularDegree, ber(user, :), 'o-','DisplayName', sprintf('User %d', user));
    hold on;
end
hold off;
title('BER vs. Angular Degree');
xlabel('Angular Degree');
ylabel('BER');
legend('User 1', 'User 2', 'User 3', 'User 4', 'Location', 'best');


% Simulating transmission rates for different angular degrees
transmissionRate = zeros(nUsers, length(angularDegree));  % Matrix to store transmission rates
for user = 1:nUsers
    for angleIdx = 1:length(angularDegree)
        % Simulating transmission rate based on angular degree
        transmissionRate(user, angleIdx) = simulateTransmissionRate(angularDegree(angleIdx), nAntennas);
    end
end

% ZF Precoding
transmittedSignalZF = zeros(nAntennas, nUsers, length(angularDegree)); % Initialize transmitted signal matrix for ZF
precodingMatrixZF = calculateZF(transmissionRate); % Calculate ZF precoding matrix

% Simulating transmission with ZF precoding
for angleIdx = 1:length(angularDegree)
    for user = 1:nUsers
        transmittedSignalZF(:, user, angleIdx) = precodingMatrixZF(:,:,angleIdx) * signal;
        % Additional code for transmission with ZF precoding
        % ... (you can add the rest of your code here for the transmission)
    end
end

% BER Calculation
ber = calculateBER(transmittedSignalZF); % Calculate BER

% Plotting BER vs. angular degree
subplot(2, 1, 1);
plot(angularDegree, ber, 'o-');
title('BER vs. Angular Degree');
xlabel('Angular Degree');
ylabel('BER');

% Plotting Transmitted Signals for all users
subplot(2, 1, 2);
hold on;
for user = 1:nUsers
    for angleIdx = 1:length(angularDegree)
        plot(angularDegree(angleIdx), transmittedSignalZF(:, user, angleIdx), 'o');
    end
end
hold off;
title('Transmitted Signals (ZF)');
xlabel('Angular Degree');
ylabel('Transmitted Signal');
legend('User 1', 'User 2', 'User 3', 'User 4');

