import gleam/string
import gleam/list
import gleam/result

pub fn message(log_line: String) -> String {
  string.split(log_line, ":")
  |> list.at(1)
  |> result.then(fn(str) { Ok(string.trim(str)) })
  |> result.lazy_unwrap(fn() { "" })
}

pub fn log_level(log_line: String) -> String {
  string.split(log_line, "[")
  |> list.at(1)
  |> result.then(fn(log_line) {
    string.split(log_line, "]")
    |> list.at(0)
  })
  |> result.then(fn(str) { Ok(string.lowercase(str)) })
  |> result.lazy_unwrap(fn() { "" })
}

pub fn reformat(log_line: String) -> String {
  string.append(" (", log_level(log_line))
  |> string.append(")")
  |> string.append(message(log_line), _)
}
