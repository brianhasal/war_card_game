require 'io/console'  

def deck_maker(suit_number, value_number)
  deck_array = []

  suit_number.times do
    deck_array << [*1..value_number]
  end

  f_deck_array = deck_array.flatten(1)

  puts "The dealer shuffles the deck..."

  return f_deck_array.shuffle
end








def enter_next_round()
  puts "Press any key to continue: "
  STDIN.getch
end







def init_dealer(array)
  array_a = []
  array_b = []
  i = 0
  array.each do |card|
    if i % 2 == 0
      array_a << card
    else
      array_b << card
    end
    i += 1
  end
  return [array_a, array_b]
end







def killswitch?(array_a, array_b)
  if array_a.length == 0 || array_b.length == 0
    return true
  else
    return false
  end
end








def top_card(array, player) 
  p_card = array.shift
  puts "Player #{player}: #{p_card}"
  return [p_card, array]
end






def round(array_a, array_b)
  round_win = false

  pa = top_card(array_a, "A")
  pa_card = pa[0]
  player_a = pa[1]
  pb = top_card(array_b, "B")
  pb_card = pb[0]
  player_b = pb[1]

  if pa_card > pb_card
    puts "Player A wins that round!"
    player_a << pa_card
    player_a << pb_card
    round_win = true
  elsif pb_card > pa_card
    puts "Player B wins that round!"
    player_b << pb_card
    player_b << pa_card
    round_win = true
  elsif pa_card == pb_card
    war_result = war(player_a, player_b)
    player_a = war_result[0]
    player_b = war_result[1]
    round_win = true
  end

  return [player_a, player_b]

end








def war(array_a, array_b)
  warbool = false
  multi_war = []

  while warbool == false
    warbool = true
    first_a = array_a.shift
    second_a = array_a.shift
    third_a = array_a.shift
    pa_card = array_a.shift
    first_b = array_b.shift
    second_b = array_b.shift
    third_b = array_b.shift
    pb_card = array_b.shift
    if killswitch?(array_a, array_b)
      return [array_a, array_b]
    end

    puts "Player A puts face down: #{first_a}, #{second_a}, #{third_a}. And the face up card is: #{pa_card}"
    puts "Player B puts face down: #{first_b}, #{second_b}, #{third_b}. And the face up card is: #{pb_card}"

    if pa_card > pb_card
      if multi_war.length > 0
        multi_war.each do |card|
          array_a << card
        end
      end
      array_a << first_a
      array_a << second_a
      array_a << third_a
      array_a << first_b
      array_a << second_b
      array_a << third_b 
      array_a << pa_card
      array_a << pb_card
      puts "Player A wins that round!"
    elsif pb_card > pa_card
      if multi_war.length > 0
        multi_war.each do |card|
          array_b << card
        end
      end
      array_b << first_a
      array_b << second_a
      array_b << third_a
      array_b << first_b
      array_b << second_b
      array_b << third_b 
      array_b << pb_card
      array_b << pa_card
      puts "Player B wins that round!"
    elsif pa_card == pb_card
      multi_war << pa_card
      multi_war << pb_card
      multi_war << first_a
      multi_war << second_a
      multi_war << third_a
      multi_war << first_b
      multi_war << second_b
      multi_war << third_b
      puts "WE'RE GOING BACK INTO WAR!"
      warbool = false
    end

  end

  return [array_a, array_b]

end









def start_game()
  counter = 0
  finished = false
  deck = deck_maker(4, 13)
  two_decks = init_dealer(deck)
  player_a = two_decks[0]
  player_b = two_decks[1]

  while finished == false
    # enter_next_round()
    round(player_a, player_b)
    finished = killswitch?(player_a, player_b)
    counter += 1
  end

  if player_a.length == 0
    puts "Player A has run out of cards"
    puts "Player B has won the game in #{counter} moves!"
    return finished = true
  elsif player_b.length == 0
    puts "Player B has run out of cards"
    puts "Player A has won the game in #{counter} moves!"
    return finished = true
  end

end



start_game()