import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

fn change_player(game: Game) -> Game {
  let new_player = case game.player {
    White -> Black
    Black -> White
  }
  Game(
    game.white_captured_stones,
    game.black_captured_stones,
    new_player,
    game.error,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  let checked_game =
    rule1(game)
    |> result.try(fn(x) { Ok(rule2(x)) })
    |> result.try(rule3)
    |> result.try(rule4)
  case checked_game {
    Ok(game) -> change_player(game)
    Error(err_msg) ->
      Game(
        game.white_captured_stones,
        game.black_captured_stones,
        game.player,
        err_msg,
      )
  }
}
