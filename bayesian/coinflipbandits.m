n_bandits = input("Enter a number of bandits (default is 2): ");
if isempty(n_bandits) || n_bandits < 0
    n_bandits = 2;
end

reward = 1;
cost = 1;
PH = rand(1,n_bandits);
xs = linspace(0,1);

beliefs = ones(n_bandits, length(xs));

fprintf("There are %d slot machines in front of you.\n", n_bandits)
fprintf("Each one has some probability of giving you a prize.\n")
fprintf("It costs you $%d to place a bet.\n", cost)
fprintf("If you win, you get back your bet plus a reward of $%d.\n", reward)
fprintf("Otherwise, you lose your bet.\n")
fprintf("Try to maximize your score!\n")

cur_score = 0;
action = 0;
a_t = [];
while action >= 0
    action = input(sprintf("Choose a machine, 1-%d (default 1). Enter -1 to quit.",n_bandits));
    if action < 0
        break
    end
    if isempty(action) || action < 1 || action > n_bandits
        action = 1;
    end

    a_t = [a_t action];

    if rand < PH(action(end))
        cur_score = [cur_score (cur_score(end) + reward)];
        beliefs(action, :) = beliefs(action, :) .* xs;
        fprintf("You won! ")
    else
        cur_score = [cur_score (cur_score(end) - cost)];
        beliefs(action, :) = beliefs(action, :) .* (1 - xs);
        fprintf("You lost. ")
    end
%     beliefs(action, :) = beliefs(action, :) / trapz(xs, beliefs(action,:));
    beliefs(action, :) = beliefs(action, :) / max(beliefs(action, :));
    fprintf("Your current score is %d\n", cur_score(end))

    imagesc(beliefs)
    c = colorbar;
    c.Label.String = "Belief";
    title("Current Normalized Beliefs")
    ylabel("Bandit")
    xlabel("Probability of Reward")
    xticklabels(xs(xticks))
end

fprintf("Your final score was %d\n", cur_score(end))

colors = rand(n_bandits, 3);
figure
hold on
for bandit = 1:n_bandits
    beliefs(bandit, :) = beliefs(bandit, :) / trapz(xs, beliefs(bandit,:));
    plot(xs, beliefs(bandit, :), 'Color', colors(bandit, :), 'DisplayName', sprintf('Bandit %d', bandit))
    xline(PH(bandit), 'color', colors(bandit, :), 'HandleVisibility','off');
end
legend
title("Final Beliefs")
xlabel("Probability of Reward")
ylabel("Probability Density")
hold off

figure
hold on
plot(0:length(a_t), cur_score)
scatter(1:length(a_t), cur_score(2:end), [], a_t, 'filled')
xlabel("Timestep")
ylabel("Score")
yline(0, 'Color', '#808080')
c = colorbar('Ticks', 1:n_bandits);
c.Label.String = "Action Taken";
hold off
