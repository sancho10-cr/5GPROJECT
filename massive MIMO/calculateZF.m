function precodingMatrixZF = calculateZF(transmissionRate)
    % Calculate ZF precoding matrix based on transmission rate
    % logic to calculate the ZF precoding matrix
    
    % Get the number of users and angular degrees
    [nUsers, nAngles] = size(transmissionRate);
    
    % Initialize the precoding matrix
    precodingMatrixZF = zeros(nUsers, nUsers, nAngles);
    
    % Calculate ZF precoding matrix for each angular degree
    for angleIdx = 1:nAngles
        H = sqrt(transmissionRate(:, angleIdx)) * transpose(sqrt(transmissionRate(:, angleIdx)));
        H_inv = pinv(H); % Calculate the pseudo-inverse of H
        
        % Zero-Forcing precoding matrix
        precodingMatrixZF(:, :, angleIdx) = H_inv;
    end
end
