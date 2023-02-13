T = input('Enter number of steps: ');
N = input('Enter number of particles: ');
p = input('Enter probability of heads: ');

X = rand(T, N);
steps = 2 * (X < p) - 1;
walk = [zeros(1, N); cumsum(steps, 1)];

plot(0:T, walk)
xlabel('step')
ylabel('position')