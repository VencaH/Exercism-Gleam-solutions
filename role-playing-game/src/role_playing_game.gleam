import gleam/option.{type Option, None, Some}
import gleam/int

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    None -> "Mighty Magician"
    Some(name) -> name
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    0 ->
      case player.level {
        x if x < 10 -> Some(Player(player.name, player.level, 100, None))
        _ -> Some(Player(player.name, player.level, 100, Some(100)))
      }
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    None -> #(
      Player(
        player.name,
        player.level,
        int.max(player.health - cost, 0),
        player.mana,
      ),
      0,
    )
    Some(x) if x < cost -> #(player, 0)
    Some(x) -> #(
      Player(player.name, player.level, player.health, Some(x - cost)),
      cost * 2,
    )
  }
}
