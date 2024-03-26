import gleam/string
import gleam/result
import gleam/list

pub fn first_letter(name: String) {
  string.trim(name)
  |> string.first
  |> result.lazy_unwrap(fn() { "" })
}

pub fn initial(name: String) {
  first_letter(name)
  |> string.capitalise
  |> string.append(".")
}

pub fn initials(full_name: String) {
  string.split(full_name, " ")
  |> list.map(initial)
  |> list.fold("", fn(acc, x) {
    case acc {
      "" -> acc
      _ -> string.append(acc, " ")
    }
    |> string.append(x)
  })
}

pub fn pair(full_name1: String, full_name2: String) {
  let initials1 = initials(full_name1)
  let initials2 = initials(full_name2)
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     " <> initials1 <> "  +  " <> initials2 <> "     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
