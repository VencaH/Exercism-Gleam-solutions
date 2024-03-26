pub type TreasureChest(treasure) {
  TreasureChest(pass: String, t: treasure)
}

pub type UnlockResult(treasure) {
  Unlocked(treasure)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case password == chest.pass {
    True -> Unlocked(chest.t)
    False -> WrongPassword
  }
}
