% Parameters
nAntennas = 8;     % Number of antennas at the base station
nUsers = 8;        % Number of users in the system
angularDegree = 0:15:180;   % Angular degrees of users

% Energy harvesting parameters
totalPower = 1000;  % Total power budget at the base station
energyAvailability = 0.8;  % Current energy availability (e.g., 0.8 means 80% energy available)

transmissionRate = zeros(nUsers, length(angularDegree));  % Matrix to store transmission rates
energyEfficiency = zeros(nUsers, length(angularDegree));  % Matrix to store energy efficiency
residualEnergy = zeros(nUsers, length(angularDegree));  % Matrix to store residual energy

% Simulating transmission rates for different angular degrees
for user = 1:nUsers
    for angleIdx = 1:length(angularDegree)
        % Simulating transmission rate, energy efficiency, and residual energy based on angular degree
        [transmissionRate(user, angleIdx), ~, ~, ~, energyEfficiency(user, angleIdx), residualEnergy(user, angleIdx)] = simulateTransmissionRate5(angularDegree(angleIdx), nAntennas, energyAvailability, totalPower);
    end
end

% Plotting the graphs

% Plotting transmission rate vs. angular degree
figure;
for user = 1:nUsers
    plot(angularDegree, transmissionRate(user, :), 'o-', 'DisplayName', sprintf('User %d', user));
    hold on;
end
hold off;
title('Transmission Rate vs. Angular Degree');
xlabel('Angular Degree');
ylabel('Transmission Rate');
legend('Location', 'Best');

% Plotting transmission rate vs.meanAccuracy
meanAccuracy = mean(1 - residualEnergy, 1);

figure;
for antenae = 1:nAntennas
    plot(residualEnergy, transmissionRate(nAntennas, :), 'o-', 'DisplayName', sprintf('Antenna %d', antenae));
    hold on;
end
hold off;
title('Transmission Rate vs. meanAccuracy');
xlabel('meanAccuracy');
ylabel('Transmission Rate');
legend('Location', 'Best');

% Plotting energy efficiency vs. angular degree
figure;
meanEnergyEfficiency = mean(transmissionRate ./ nAntennas, 1);
plot(nAntennas, meanEnergyEfficiency, 'o-');
title('Energy Efficiency vs.n antenars');
xlabel('antenars');
ylabel('Energy Efficiency');

% Plotting residual energy vs. transmissionRate
figure;
meanResidualEnergy = mean(1 - residualEnergy, 1);
plot(transmissionRate, meanResidualEnergy, 'o-');
title('Residual Energy vs. transmissionRate');
xlabel('transmissionRate');
ylabel('Residual Energy');

% Plotting accuracy vs. energyEfficiency
figure;
plot(energyEfficiency, meanAccuracy, 'o-');
title('Accuracy vs. energyEfficiency');
xlabel('energyEfficiency');
ylabel('Accuracy');
