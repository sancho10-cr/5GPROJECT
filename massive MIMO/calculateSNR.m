
% Function to calculate SNR in dB
function snr = calculateSNR(transmissionRate)
    % Calculate SNR in dB based on transmission rate
    % Implement your logic here to calculate the SNR in dB
    % For example:
    noisePower = 1; % Assuming a noise power of 1
    snr = 10 * log10(transmissionRate ./ noisePower);
end