ii = 14;
p = 0.4;
B = 15;

N_trials = 1000;
wins = 0;
losses = 0;
for trial = 1:N_trials
    X = ii; % X is our position
    t = 0; % t is time
    while X(end) < B && X(end) > 0
        % fill in some code here
        % remember that rand < p is 1 with probability p and 0 with probability
        % q = 1 - p
        f = 2 * (rand < p) - 1; % f is +/- 1
        X = [X (X(end) + f)];
        t = t + 1;
    end
    if X(end) == 0
        losses = losses + 1;
    else
        wins = wins + 1;
    end
end

win_pct = 100 * wins / (wins + losses);
fprintf('Starting at %d / %d, with p = %4.2f, we won %f %% of the time\n', ii, B, p, win_pct)