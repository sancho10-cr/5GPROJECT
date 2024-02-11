function rate = simulateTransmissionRate(angularDegree, nAntennas,~)
    % logic here to calculate the transmission rate
    % based on spatial multiplexing and beamforming techniques
    
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
    
    % Sum up the effective transmission rates of all data streams
    rate = sum(effectiveRate);
end
