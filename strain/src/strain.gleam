import gleam/list

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  keep_acc([], list, predicate)
}

fn keep_acc(acc: List(t), list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> acc
    [head, ..tail] ->
      case predicate(head) {
        True -> list.append(acc, [head])
        False -> acc
      }
      |> keep_acc(tail, predicate)
  }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  discard_acc([], list, predicate)
}

fn discard_acc(acc: List(t), list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> acc
    [head, ..tail] ->
      case predicate(head) {
        True -> acc
        False -> list.append(acc, [head])
      }
      |> discard_acc(tail, predicate)
  }
}
