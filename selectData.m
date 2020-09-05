function [selectD] = selectData(transData)
    a = transData(1, :);
    b = [];

    for i = 0:24
        b = [b, a((868 * i * 512 + 1):(868 * i + 360) * 512), a((868 * i * 512 + 434 * 512 + 1):(868 * i + 434 + 360) * 512)];
    end

    c = reshape(b, 512, 50 * 360);
    d = [];

    for i = 1:50
        d(:, i, :) = c(:, ((i - 1) * 360 + 1):i * 360);
    end

    selectD = d;
