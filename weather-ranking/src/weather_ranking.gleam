import gleam/order.{type Order}
import gleam/float
import gleam/list

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  case left, right {
    Celsius(left), Celsius(right) -> float.compare(left, right)
    Fahrenheit(left), right ->
      Celsius(fahrenheit_to_celsius(left))
      |> compare_temperature(right)
    left, Fahrenheit(right) ->
      Celsius(fahrenheit_to_celsius(right))
      |> compare_temperature(left, _)
  }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, fn(a, b) {
    compare_temperature(a.temperature, b.temperature)
  })
}
