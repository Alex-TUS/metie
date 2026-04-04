use std::io;

use rustler::{Encoder, Env, Term};
use thiserror::Error;

#[derive(Error, Debug)]
pub enum MetieError {
    #[error("IO Error: {0}")]
    Io(#[from] io::Error),
    #[error("Utf8 Conversion Error: {0}")]
    Utf8(#[from] std::str::Utf8Error),
}

impl Encoder for MetieError {
    fn encode<'b>(&self, env: Env<'b>) -> Term<'b> {
        format!("{self}").encode(env)
    }
}

impl std::panic::RefUnwindSafe for MetieError {}
