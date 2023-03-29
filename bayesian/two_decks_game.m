n_cards = 100; % how many cards in each deck
n_draws = 10; % number of draws you will take, in total
good_p = 0.55; % the probability of drawing + from the good deck
bad_p = 0.45; % the probability of drawing + from the bad deck
card_value = 5; % how much each card is worth

gooddeck = (2 * (rand(n_cards,1) < good_p) - 1) * card_value;
baddeck = (2 * (rand(n_cards,1) < bad_p) - 1) * card_value;

which_is_good = rand < 0.5; % randomly order the decks
if which_is_good
    decks = {gooddeck, baddeck};
else
    decks = {baddeck, gooddeck};
end

num_draws = 0; % how many cards you've drawn
running_total = 0; % your current score
pointers = [0,0]; % which card in each deck
fprintf('There are two decks in front of you, deck 1 and deck 2. Both are made of cards that say +%d and -%d\n',card_value, card_value)
fprintf('One is roughly %2.0f%% positive cards, and the other is roughly %2.0f%% good cards.\n', 100 * good_p, 100 * bad_p)
fprintf('You can draw from either deck, until you draw a total of %d cards\n', n_draws)
while num_draws < n_draws
    deck_choice = input("Choose deck 1 or deck 2 (type 1 or 2): ");
    pointers(deck_choice) = pointers(deck_choice) + 1;
    chosen_deck = decks{deck_choice};
    next_card = chosen_deck(pointers(deck_choice));
    running_total = running_total + next_card;
    fprintf("Current score: %4d. You chose deck %d and flipped %d\n", running_total, deck_choice, next_card)
    num_draws = num_draws + 1;
end
fprintf('Final score: %d\n', running_total)
fprintf('The "good" deck was deck %d.\n', which_is_good + 1)