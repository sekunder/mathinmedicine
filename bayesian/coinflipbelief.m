p_true = rand;

xs = linspace(0,1);
cur_belief = ones(size(xs));
hold on
xline(p_true)
hold off

figure;
plot(xs, cur_belief)

n_flips = input("How many times would you like to flip the coin?");
X = (rand(1,n_flips) < p_true);
flip_str = ["tails", "heads"];
fprintf("Press enter to flip the coin")
for flip_num = 1:n_flips
%     input("Press enter to flip the coin")
    input("")
    fprintf("You flipped %s\n", flip_str(X(flip_num) + 1))
    
    if X(flip_num)  %flipped heads
        cur_belief = cur_belief .* xs;
    else
        cur_belief = cur_belief .* (1 - xs);
    end
    cur_belief = cur_belief / trapz(xs, cur_belief);
    plot(xs, cur_belief)
    hold on
    xline(p_true)
    hold off
end