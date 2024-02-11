function zf_precoding_massive_mimo()
    % Parameters
    num_antennas_bs = 64;    % Number of base station antennas
    num_antennas_user = 1;   % Number of user antennas
    num_samples = 1000;      % Number of channel realizations
    snr_dB = 20;             % Signal-to-noise ratio (in dB)
    
    % Generate random channel matrix H (complex Gaussian)
    H = (randn(num_antennas_bs, num_antennas_user, num_samples) + ...
         1i * randn(num_antennas_bs, num_antennas_user, num_samples)) / sqrt(2);
    
    % Generate random data symbols for the user
    data_symbols = randi([0, 1], num_antennas_user, num_samples);
    
    % Apply ZF precoding to obtain transmit signals
    precoding_matrix = 1./H;  % ZF precoding matrix
    transmit_symbols = precoding_matrix .* data_symbols;
    
    % Add complex Gaussian noise to the received signals
    snr = 10^(snr_dB/10);  % Convert SNR from dB to linear scale
    noise_power = 1 / snr;
    noise = sqrt(noise_power/2) * (randn(num_antennas_bs, num_samples) + ...
                                   1i * randn(num_antennas_bs, num_samples));
    received_symbols = H .* transmit_symbols + noise;
    disp(size(received_symbols));
    disp(size(noise_power));
    disp(size(pagetranspose(H)));

    
    % Calculate the received SINR (Signal-to-Interference-plus-Noise Ratio)
    SINR = abs(pagetranspose(H) .* (1./(H .* pagetranspose(H)) .* received_symbols)).^2 ./ noise_power;
    
    % Plot the results
    figure;
    plot(10*log10(SINR), 'b', 'LineWidth', 2);
    xlabel('Channel Realization');
    ylabel('SINR (dB)');
    title('Zero-Forcing Precoding in Massive MIMO');
    grid on;
end
