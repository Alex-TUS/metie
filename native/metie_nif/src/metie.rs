use itertools::Itertools;
use jiff::Unit;
use metie::{Data, Metie};

use crate::datatypes::*;

pub fn parse_forecasts(metie: Metie) -> Vec<Forecast> {
    let models = metie.meta.model;
    let forecasts = metie.product.time;

    forecasts
        .into_iter()
        .tuples()
        .map(move |(a, b)| {
            let mut w = Forecast::default();

            let model_a = models
                .iter()
                .find(|&m| a.start >= m.start && a.finish <= m.finish)
                .unwrap();

            let model_b = models
                .iter()
                .find(|&m| b.finish >= m.start && b.finish <= m.finish)
                .unwrap();

            assert_eq!(a.start, a.finish);
            assert_eq!(a.finish, b.finish);
            assert_eq!(model_a.name, model_b.name);

            w.timestamp = a.start.into();
            w.run_next = model_a.next_run.into();

            w.weather_model = model_a.name.into();

            w.run_start = model_a.run_start.into();
            w.run_finish = model_a.run_finish.into();

            assert_eq!(a.location(), b.location());

            let (altitude, latitude, longitude) = a.location();

            w.altitude = altitude;
            w.latitude = latitude;
            w.longitude = longitude;
            for data in a
                .location
                .data
                .into_iter()
                .chain(b.location.data.into_iter())
            {
                match data {
                    Data::Temperature { value, .. } => w.temperature = value,
                    Data::WindDirection { degrees, .. } => w.wind_direction = degrees,
                    Data::WindSpeed { mps, beaufort, .. } => {
                        w.wind_speed = mps * 3.6;
                        w.wind_beaufort = beaufort;
                    }
                    Data::WindGust { mps, .. } => w.wind_gust = mps * 3.6,
                    Data::GlobalRadiation { value, .. } => w.global_radiation = value,
                    Data::Humidity { value, .. } => w.humidity = value,
                    Data::Pressure { value, .. } => w.pressure = value,
                    Data::Cloudiness { percent, .. } => w.cloudiness = percent,
                    Data::LowClouds { percent, .. } => w.low_clouds = percent,
                    Data::MediumClouds { percent, .. } => w.medium_clouds = percent,
                    Data::HighClouds { percent, .. } => w.high_clouds = percent,
                    Data::DewpointTemperature { value, .. } => w.dewpoint_temperature = value,
                    Data::Precipitation {
                        mut value,
                        minvalue,
                        maxvalue,
                        probability_percent,
                        ..
                    } => {
                        w.precipitation = {
                            let hours = (b.finish - b.start).total(Unit::Hour).unwrap() as f64;

                            if hours > 1.0 {
                                value = value / hours;
                            }

                            value
                        };
                        w.precipitation_min = minvalue.unwrap_or_default();
                        w.precipitation_max = maxvalue.unwrap_or_default();
                        w.precipitation_probability = probability_percent.unwrap_or_default();
                    }
                    Data::Symbol { symbol, .. } => w.weather_symbol = symbol as i32,
                }
            }

            w
        })
        .collect()
}
