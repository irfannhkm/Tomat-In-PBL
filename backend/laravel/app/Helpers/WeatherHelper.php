<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Http;

class WeatherHelper
{
    public static function getWeatherData($latitude, $longitude)
    {
        $apiKey = config('services.openweather.key'); // Mengambil API key dari file .env
        $url = "https://api.openweathermap.org/data/2.5/forecast";

        try {
            // Mengirim permintaan ke API OpenWeather
            $response = Http::get($url, [
                'lat' => $latitude,
                'lon' => $longitude,
                'units' => 'metric', // Menggunakan metric (Celsius)
                'appid' => $apiKey,
            ]);

            // Mengecek apakah respons berhasil
            if ($response->successful()) {
                $data = $response->json();

                // Mengecek apakah data tersedia
                if (isset($data['list'][0]) && isset($data['city'])) {
                    $currentWeather = $data['list'][0];
                    $cityName = $data['city']['name'];

                    return [
                        'city_name' => $cityName,
                        'temperature' => $currentWeather['main']['temp'],
                        'weather' => ucfirst($currentWeather['weather'][0]['description']),
                        'humidity' => $currentWeather['main']['humidity'] . '%',
                        'wind_speed' => $currentWeather['wind']['speed'] . ' m/s',
                        'pressure' => $currentWeather['main']['pressure'] . ' hPa',
                        'forecast_time' => $currentWeather['dt_txt'], // Waktu prakiraan
                    ];
                } else {
                    return [
                        'error' => 'Weather data not available or incomplete.',
                    ];
                }
            } else {
                return [
                    'error' => 'Failed to retrieve weather data.',
                    'status' => $response->status(),
                    'body' => $response->body(),
                ];
            }
        } catch (\Exception $e) {
            return [
                'error' => 'Error retrieving weather data: ' . $e->getMessage(),
            ];
        }
    }
}
