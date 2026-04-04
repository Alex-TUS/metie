mod datatypes;
mod error;
mod metie;

use ::metie::Metie;
use datatypes::Forecast;
use error::MetieError;
use metie::parse_forecasts;

#[rustler::nif(schedule = "DirtyCpu")]
pub fn parse(binary: rustler::Binary) -> Result<Vec<Forecast>, MetieError> {
    let utf8 = std::str::from_utf8(binary.as_slice())?;
    let metie = Metie::from_xml(utf8.as_bytes())?;
    Ok(parse_forecasts(metie))
}

mod atoms {
    rustler::atoms! {
        calendar_iso_module = "Elixir.Calendar.ISO",
        harmonie,
        ecmwf1,
        ecmwf2,
        ecmwf3,
        unknown,
    }
}

rustler::init!("Elixir.Metie.Native");
