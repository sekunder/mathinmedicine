function X = randomwalk1d(N, p)
%RANDOMWALK1D Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    p = 0.5;
end
if numel(N) < 2
    N = [1 N];
end

steps = 2 * (rand(N) < p) - 1;
X = [zeros(N(1), 1) cumsum(steps, 2)];

end

