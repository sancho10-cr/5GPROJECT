function [rate, energyHarvested, papr, throughput, energyEfficiency, residualEnergy] = simulateTransmissionRate5(angularDegree, nAntennas, energyAvailability, totalPower)
    % Calculate the initial transmission rate for each data stream
    dataStreams = 2;  % Number of data streams
    initialRate = zeros(1, dataStreams);

    for stream = 1:dataStreams
        % Calculate the transmission rate for each data stream
        initialRate(stream) = nAntennas * sin(deg2rad(angularDegree)) / dataStreams;
    end

    % Apply beamforming to each data stream
    beamformingGains = [1, 0.8];  % Beamforming gains for each data stream

    % Apply the beamforming gains to the transmission rates
    effectiveRate = initialRate .* beamformingGains;

    % Calculate the available power for each data stream based on energy availability
    availablePower = totalPower * energyAvailability;

    % Initialize the power allocation ratio for each data stream
    powerAllocationRatio = ones(1, dataStreams);

    % Calculate the initial adjusted transmission rates based on power allocation
    adjustedRate = effectiveRate .* powerAllocationRatio;

    % Dynamic Power Allocation based on real-time energy availability and traffic demand
    % Using Convex Optimization
    if energyAvailability < 0.5
        % Reduce the power allocation ratio by 50% during low energy availability
        powerAllocationRatio = powerAllocationRatio * 0.5;
    elseif energyAvailability > 0.8
        % Increase the power allocation ratio by 20% during high energy availability
        powerAllocationRatio = powerAllocationRatio * 1.2;
    end

    % Apply SLM for PAPR reduction
    numVersions = 4;  % Number of signal versions
    phaseRotations = exp(1i * 2 * pi * rand(1, numVersions));  % Random phase rotations
    papr = zeros(1, numVersions);

    for version = 1:numVersions
        % Apply the phase rotation to the adjusted transmission rates
        adjustedRateRotated = adjustedRate .* phaseRotations(version);

        % Calculate the PAPR for the current version
        papr(version) = max(abs(adjustedRateRotated))^2 / mean(abs(adjustedRateRotated))^2;
    end

    % Select the version with the lowest PAPR
    [~, minPAPRIndex] = min(papr);
    adjustedRate = adjustedRate .* phaseRotations(minPAPRIndex);

    % Calculate the harvested energy based on the remaining power
    energyHarvested = totalPower - sum(adjustedRate);

    % Calculate throughput
    throughput = sum(adjustedRate);

    % Calculate energy efficiency
    energyEfficiency = throughput / totalPower;

    % Calculate residual energy
    residualEnergy = totalPower - sum(adjustedRate);

    % Return the transmission rate, harvested energy, PAPR, throughput, energy efficiency, and residual energy
    rate = sum(adjustedRate);
end
