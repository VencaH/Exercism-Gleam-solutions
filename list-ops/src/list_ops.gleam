pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  append_acc(reverse(first), second)
}

fn append_acc(first: List(a), second: List(a)) -> List(a) {
  case first {
    [] -> second
    [head, ..rest] ->
      [head, ..second]
      |> append_acc(rest, _)
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  concat_acc([], lists)
}

fn concat_acc(acc: List(a), lists: List(List(a))) -> List(a) {
  case lists {
    [] -> acc
    [head, ..rest] ->
      append(acc, head)
      |> concat_acc(rest)
  }
}

pub fn filter(list: List(a), function: fn(a) -> Bool) -> List(a) {
  filter_acc([], list, function)
}

fn filter_acc(acc: List(a), list: List(a), function: fn(a) -> Bool) -> List(a) {
  case list {
    [] -> acc
    [head, ..rest] ->
      case function(head) {
        True -> append(acc, [head])
        False -> acc
      }
      |> filter_acc(rest, function)
  }
}

pub fn length(list: List(a)) -> Int {
  length_acc(0, list)
}

fn length_acc(acc: Int, list: List(a)) -> Int {
  case list {
    [] -> acc
    [_, ..rest] ->
      acc + 1
      |> length_acc(rest)
  }
}

pub fn map(list: List(a), function: fn(a) -> b) -> List(b) {
  map_acc([], list, function)
}

fn map_acc(acc: List(b), list: List(a), function: fn(a) -> b) -> List(b) {
  case list {
    [] -> acc
    [head, ..rest] ->
      [function(head)]
      |> append(acc, _)
      |> map_acc(rest, function)
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [head, ..rest] ->
      function(initial, head)
      |> foldl(rest, _, function)
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with function: fn(b, a) -> b,
) -> b {
  reverse(list)
  |> foldl(initial, function)
}

pub fn reverse(list: List(a)) -> List(a) {
  let result = reverse_acc([], list)
  result
}

fn reverse_acc(acc: List(a), list: List(a)) -> List(a) {
  case list {
    [] -> acc
    [head, ..rest] ->
      [head, ..acc]
      |> reverse_acc(rest)
  }
}
