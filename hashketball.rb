
require "pry"
def game_hash () 
hash = {
  :home => {:team_name => "Brooklyn Nets",
  :colors => ["Black", "White"],
  :players =>[{"Alan Anderson" => {:number => 0, :shoe => 16, :points => 22, :rebounds => 12, :assists => 12, :steals => 3, :blocks => 1, :slam_dunks => 1}},{"Reggie Evans" => {:number => 30, :shoe => 14, :points => 12, :rebounds => 12, :assists => 12, :steals => 12, :blocks => 12, :slam_dunks => 7}}, {"Brook Lopez" => {:number => 11, :shoe => 17, :points => 17, :rebounds => 19, :assists => 10, :steals => 3, :blocks => 1, :slam_dunks => 15}},{"Mason Plumlee" => {:number => 1, :shoe => 19, :points => 26, :rebounds => 11, :assists => 6, :steals => 3, :blocks => 8, :slam_dunks => 5}},{"Jason Terry" => {:number => 31, :shoe => 15, :points => 19, :rebounds => 2, :assists => 2, :steals => 4, :blocks => 11, :slam_dunks => 1}}]
    
  },
  :away =>  {:team_name => "Charlotte Hornets",
  :colors => ["Turquoise", "Purple"] ,
  :players => [{"Jeff Adrien" => {:number => 4, :shoe => 18, :points => 10, :rebounds => 1, :assists => 1, :steals => 2, :blocks => 7, :slam_dunks => 2}},{"Bismack Biyombo" => {:number => 0, :shoe => 16, :points => 12, :rebounds => 4, :assists => 7, :steals => 22, :blocks => 15, :slam_dunks => 10}},{"DeSagna Diop" => {:number => 2, :shoe => 14, :points => 24, :rebounds => 12, :assists => 12, :steals => 4, :blocks => 5, :slam_dunks => 5}},{"Ben Gordon" => {:number => 8, :shoe => 15, :points => 33, :rebounds => 3, :assists => 2, :steals => 1, :blocks => 1, :slam_dunks => 0}},{"Kemba Walker"=>{:number => 33, :shoe => 15, :points => 6, :rebounds => 12, :assists => 12, :steals => 7, :blocks => 5, :slam_dunks => 12}}]
    
  }
}

end

def num_points_scored (player)
  hash = game_hash()
  index = 0
  while index < hash[:home][:players].length
    if hash[:home][:players][index][player]
      return hash[:home][:players][index][player][:points]
    elsif hash[:away][:players][index][player]
     return hash[:away][:players][index][player][:points]
    end
    index+=1
  end
end

def shoe_size (player)
  hash = game_hash()
  index = 0
  #binding.pry
  while index < hash[:home][:players].length
    if hash[:home][:players][index][player]
      return hash[:home][:players][index][player][:shoe]
    elsif hash[:away][:players][index][player]
     return hash[:away][:players][index][player][:shoe]
    end
    index+=1
  end
end

def team_colors(team)
  hash = game_hash()
  if hash[:home][:team_name]==team 
    return hash[:home][:colors]
  else 
    return hash[:away][:colors]
  end
end

def team_names ()
  hash = game_hash()
  hash.reduce([]) do |teams, (home_or_away, stats)|
    teams << hash[home_or_away][:team_name]
    teams
  end
end

def player_numbers (team)
  hash = game_hash()
  hash.reduce([]) do |numbers, (home_or_away, stats)|
    if hash[home_or_away][:team_name] == team
      hash[home_or_away][:players].each do |player|
      numbers << player.values[0][:number]
      end
    end
  numbers
  end
end

def player_stats(player)
  hash = game_hash()
  hash.reduce(nil) do |player_stats, (home_or_away, stats)|
   index = 0 
   while index < hash[home_or_away][:players].length
   if hash[home_or_away][:players][index][player]
    return player_stats = hash[home_or_away][:players][index][player]
    end
   index +=1
   end
  end
end

def big_shoe_rebounds()
  hash = game_hash()
  rebounds = hash.reduce(nil) do |rebounds, (home_or_away, stats)|
  index = 0
  rebounds = stats[:players][index].values[0][:rebounds] if !rebounds
  player = stats[:players][index].keys[0]
  biggest_shoe = stats[:players][index].values[0][:shoe]
  while index < stats[:players].length
    if stats[:players][index].values[0][:shoe] > biggest_shoe
      biggest_shoe = stats[:players][index].values[0][:shoe]
      player = stats[:players][index].keys[0]
      rebounds = stats[:players][index].values[0][:rebounds]
    end
    index += 1
  end
  rebounds
  end 
end

def most_points_scored ()
  hash = game_hash()
  hash.reduce(nil) do |player, (home_or_away, stats)|
    player = stats[:players].max do |player1, player2|
    player1.values[0][:points] <=> player2.values[0][:points] 
    end
    player.keys[0]
  end
end

def winning_team()
  hash = game_hash()
    home_points = 0
    away_points = 0
    hash[:home][:players].each do |player|
      home_points += player.values[0][:points]
    end
    hash[:away][:players].each do |player|
      away_points += player.values[0][:points]
    end
    home_points > away_points ? hash[:home][:team_name] : hash[:away][:team_name]
end

def player_with_longest_name ()
  hash = game_hash()
  hash.reduce(nil) do |name, (home_or_away, stats)|
    player = stats[:players].max do |player1, player2|
      player1.keys[0].length <=> player2.keys[0].length
    end
    player.keys[0]
  end
end
      
def long_name_steals_a_ton? ()
  hash = game_hash()
  long_name = player_with_longest_name()
  hash.reduce(true) do |true_or_false, (home_or_away, stats)|
    most_steals = player_stats(long_name)[:steals]
    stats[:players].each do |player|
    if player.values[0][:steals] > most_steals
      true_or_false = false 
    end
  end
  true_or_false
end
end