use jiff::tz::Offset;
use rustler::{Atom, NifStruct, NifTaggedEnum};

use crate::atoms::*;

#[derive(NifStruct, Copy, Clone, Debug)]
#[module = "NaiveDateTime"]
pub struct ExNaiveDateTime {
    pub calendar: Atom,
    pub day: u32,
    pub hour: u32,
    pub microsecond: (u32, u32),
    pub minute: u32,
    pub month: u32,
    pub second: u32,
    pub year: i32,
}

#[derive(Default, Debug, NifTaggedEnum)]
pub enum WeatherModel {
    Harmonie,
    Ecmwf1,
    Ecmwf2,
    Ecmwf3,
    #[default]
    Unknown,
}

#[derive(Default, Debug, NifStruct)]
#[module = "Metie.Client.Forecast"]
pub struct Forecast {
    pub timestamp: ExNaiveDateTime,
    pub run_start: ExNaiveDateTime,
    pub run_finish: ExNaiveDateTime,
    pub run_next: ExNaiveDateTime,
    pub weather_model: WeatherModel,
    pub altitude: u64,
    pub latitude: f64,
    pub longitude: f64,
    pub temperature: f64,
    pub dewpoint_temperature: f64,
    pub weather_symbol: i32,
    pub wind_direction: f64,
    pub wind_speed: f64, // in kmph
    pub wind_beaufort: u64,
    pub wind_gust: f64, // in kmph
    pub humidity: f64,  // percent
    pub pressure: f64,  // hPa,
    pub cloudiness: f64,
    pub low_clouds: f64,
    pub medium_clouds: f64,
    pub high_clouds: f64,
    pub global_radiation: f64, // W/m^2
    pub precipitation: f64,    // mm
    pub precipitation_min: f64,
    pub precipitation_max: f64,
    pub precipitation_probability: f64,
}

impl From<jiff::Timestamp> for ExNaiveDateTime {
    fn from(value: jiff::Timestamp) -> Self {
        let dt = Offset::UTC.to_datetime(value);

        Self {
            calendar: calendar_iso_module(),
            day: dt.day() as _,
            hour: dt.hour() as _,
            microsecond: (dt.microsecond() as _, 6),
            minute: dt.minute() as _,
            month: dt.month() as _,
            second: dt.second() as _,
            year: dt.year() as _,
        }
    }
}

impl Default for ExNaiveDateTime {
    fn default() -> Self {
        Self {
            calendar: calendar_iso_module(),
            day: 0,
            hour: 0,
            microsecond: (0, 0),
            minute: 0,
            month: 0,
            second: 0,
            year: 0,
        }
    }
}

impl From<metie::ModelName> for WeatherModel {
    fn from(model: metie::ModelName) -> Self {
        match model {
            metie::ModelName::Harmonie => Self::Harmonie,
            metie::ModelName::Ecmwf1 => Self::Ecmwf1,
            metie::ModelName::Ecmwf2 => Self::Ecmwf2,
            metie::ModelName::Ecmwf3 => Self::Ecmwf3,
            _ => Self::Unknown,
        }
    }
}
