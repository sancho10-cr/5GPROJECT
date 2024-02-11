

% Function to calculate QoS
function qos = calculateQoS(transmissionRate)
    % Calculate QoS based on transmission rate
    % Implement your logic here to calculate the QoS
    qos = transmissionRate ./ max(transmissionRate, [], 2);
end
