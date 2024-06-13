import simplifile
import gleam/string
import gleam/list
import gleam/result

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  simplifile.read(path)
  |> result.try(fn(x) { Ok(string.split(x, "\n")) })
  |> result.try(fn(x) { Ok(list.filter(x, fn(item) { item != "" })) })
  |> result.nil_error()
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  simplifile.create_file(path)
  |> result.nil_error()
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  simplifile.append(path, email)
  |> result.try(fn(_) { simplifile.append(path, "\n") })
  |> result.nil_error()
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  let _ = create_log_file(log_path)
  let _ =
    read_emails(emails_path)
    |> result.try(fn(mail_list) {
      Ok(
        list.map(mail_list, fn(mail) {
          send_email(mail)
          |> result.try(fn(_) { log_sent_email(log_path, mail) })
        }),
      )
    })
  Ok(Nil)
}
