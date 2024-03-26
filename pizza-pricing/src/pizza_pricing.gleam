pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

fn pizza_price_calc(price: Int, pizza: Pizza) -> Int {
  case pizza {
    Margherita -> price + 7
    Caprese -> price + 9
    Formaggio -> price + 10
    ExtraSauce(pizza) -> pizza_price_calc(price + 1, pizza)
    ExtraToppings(pizza) -> pizza_price_calc(price + 2, pizza)
  }
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_price_calc(0, pizza)
}

pub fn order_price(order: List(Pizza)) -> Int {
  order_calc(order, 0, 0)
}

fn order_calc(order: List(Pizza), price: Int, amount: Int) -> Int {
  case order {
    [] ->
      case amount {
        1 -> price + 3
        2 -> price + 2
        _ -> price
      }
    [pizza, ..rest] -> order_calc(rest, price + pizza_price(pizza), amount + 1)
  }
}
