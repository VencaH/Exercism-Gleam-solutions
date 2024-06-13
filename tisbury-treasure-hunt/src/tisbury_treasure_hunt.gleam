import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(row, col) = place_location
  #(col, row)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  treasure_location == place_location_to_treasure_location(place_location)
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  list.filter(treasures, fn(x) {
    treasure_location_matches_place_location(place.1, x.1)
  })
  |> list.length
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case #(found_treasure.1, place.1, desired_treasure.1) {
    #(#(4, "B"), #("B", 4), _) -> True
    #(#(1, "F"), #("B", 5), #(6, "A")) -> True
    #(#(1, "F"), #("B", 5), #(6, "D")) -> True
    #(#(7, "E"), #("A", 8), #(8, "A")) -> True
    #(#(7, "E"), #("A", 8), #(3, "D")) -> True
    _ -> False
  }
}
