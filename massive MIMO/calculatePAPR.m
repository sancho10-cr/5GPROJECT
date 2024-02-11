
% Function to calculate PAPR
function papr = calculatePAPR(transmissionRate)
    % Calculate PAPR based on transmission rate
    % Implement your logic here to calculate the PAPR
    % For example:
    maxPower = max(transmissionRate, [], 2);
    avgPower = mean(transmissionRate, 2);
    papr = maxPower ./ avgPower;
end
