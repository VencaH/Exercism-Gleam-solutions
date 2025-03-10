import gleam/dict.{type Dict}
import gleam/option
import gleam/result

pub type ScoreBoard =
  Dict(String, Int)

pub fn create_score_board() -> ScoreBoard {
  dict.from_list([#("The Best Ever", 1_000_000)])
}

pub fn add_player(
  score_board: ScoreBoard,
  player: String,
  score: Int,
) -> ScoreBoard {
  dict.insert(score_board, player, score)
}

pub fn remove_player(score_board: ScoreBoard, player: String) -> ScoreBoard {
  dict.delete(score_board, player)
}

pub fn update_score(
  score_board: ScoreBoard,
  player: String,
  points: Int,
) -> ScoreBoard {
  dict.get(score_board, player)
  |> result.then(fn(_) {
    Ok(
      fn(x) { option.lazy_unwrap(x, fn() { 0 }) + points }
      |> dict.update(score_board, player, _),
    )
  })
  |> result.lazy_unwrap(fn() { score_board })
}

pub fn apply_monday_bonus(score_board: ScoreBoard) -> ScoreBoard {
  dict.map_values(score_board, fn(_, value) { value + 100 })
}
