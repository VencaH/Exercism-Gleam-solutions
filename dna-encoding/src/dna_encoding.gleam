import gleam/list
import gleam/result

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0
    Cytosine -> 1
    Guanine -> 2
    Thymine -> 3
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0 -> Ok(Adenine)
    1 -> Ok(Cytosine)
    2 -> Ok(Guanine)
    3 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  list.fold(dna, <<0:0>>, fn(acc, nuc) {
    <<acc:bits, encode_nucleotide(nuc):2>>
  })
}

fn decode_int(
  acc: Result(List(Nucleotide), Nil),
  dna: BitArray,
) -> Result(List(Nucleotide), Nil) {
  case acc {
    Error(_) -> Error(Nil)
    Ok(acc) -> {
      case dna {
        <<value:2, rest:bits>> -> {
          case decode_nucleotide(value) {
            Error(_) -> Error(Nil)
            Ok(decoded) ->
              Ok([decoded, ..acc])
              |> decode_int(<<rest:bits>>)
          }
        }
        <<0:0>> -> Ok(acc)
        _ -> Error(Nil)
      }
    }
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  decode_int(Ok([]), dna)
  |> result.try(fn(dna) { Ok(list.reverse(dna)) })
}
