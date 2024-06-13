import gleam/string

pub fn extract_error(problem: Result(a, b)) -> b {
  let assert Error(err) = problem
  err
}

pub fn remove_team_prefix(team: String) -> String {
  let assert [_, tail] = string.split(team, " ")
  tail
}

pub fn split_region_and_team(combined: String) -> #(String, String) {
  let assert [head, tail] = string.split(combined, ",")
  let tail = remove_team_prefix(tail)
  #(head, tail)
}
