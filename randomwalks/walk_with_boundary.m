close all
ii = 10;
p = 0.55;
B = 20;

N_trials = 1000;
wins = 0;
losses = 0;
win_times = [];
loss_times = [];
win_time_counts = [];
loss_time_counts = [];
figure
hold on
for trial = 1:N_trials
    X = ii; % X is our position
    t = 0; % t is time
    win_times = [];
    loss_times = [];
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
        loss_times = [loss_times t];
        plot(0:t, X, 'color','red')
        if length(loss_time_counts) < t
            loss_time_counts(t) = 1;
        else
            loss_time_counts(t) = loss_time_counts(t) + 1;
        end
    else
        wins = wins + 1;
        win_times = [win_times t];
        plot(0:t, X, 'color', 'blue')
        if length(win_time_counts) < t
            win_time_counts(t) = 1;
        else
            win_time_counts(t) = win_time_counts(t) + 1;
        end
    end
end
ylim([0, B])
title(sprintf("%d Random Walks starting at %d, p = %4.3f", N_trials, ii, p))
ylabel("Position")
xlabel("Time")
hold off

figure
hold on
if numel(win_time_counts) > 0
    bar(win_time_counts, 1, "stacked", "blue")
end
if numel(loss_time_counts) > 0
    bar(-loss_time_counts, 1, "stacked", "red")
end
title("End time distribution")
xlabel("Game end")
ylabel("Frequency")
hold off

win_pct = 100 * wins / (wins + losses);
rho = (1 - p) / p;
predict_win_pct = 100 * sum(rho .^ (1:ii)) / sum(rho .^ (1:B));
fprintf('Starting at %d / %d, with p = %4.2f, we won %4.2f %% of the time. Predicted %4.2f %%\n', ii, B, p, win_pct, predict_win_pct)
