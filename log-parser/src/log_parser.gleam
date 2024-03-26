import gleam/regex
import gleam/list
import gleam/option
import gleam/result

pub fn is_valid_line(line: String) -> Bool {
  regex.from_string("^\\[(DEBUG|INFO|WARNING|ERROR)\\]")
  |> result.then(fn(re) { Ok(regex.check(re, line)) })
  |> result.lazy_unwrap(fn() { False })
}

pub fn split_line(line: String) -> List(String) {
  regex.from_string("<[~*=-]*>")
  |> result.then(fn(re) { Ok(regex.split(re, line)) })
  |> result.lazy_unwrap(fn() { [line] })
}

pub fn tag_with_user_name(line: String) -> String {
  regex.from_string("User\\s+(\\S+)")
  |> result.map_error(fn(_) { Nil })
  |> result.then(fn(re) {
    regex.scan(re, line)
    |> list.at(0)
  })
  |> result.then(fn(match) {
    match.submatches
    |> list.at(0)
  })
  |> result.then(fn(user) { option.to_result(user, Nil) })
  |> result.then(fn(user) { Ok("[USER] " <> user <> " " <> line) })
  |> result.lazy_unwrap(fn() { line })
}
