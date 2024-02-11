
% Function to calculate BER
function ber = calculateBER(transmissionRate)
    % Calculate BER based on transmission rate
    ber = 1 ./ transmissionRate;
end