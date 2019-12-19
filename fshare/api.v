module fshare

import (
  conf
)

pub struct Client {
  conf     conf.FShare
pub mut:
  session  Session
}

pub struct Session {
  code       int
  msg        string
  token      string
  session_id string
}

pub struct Error {
  code string
  msg  string
}
