<?php

namespace App\Livewire;

use App\Models\Location;
use App\Helpers\WeatherHelper;
use Livewire\Component;

class Map extends Component
{
    public $locations;

    public function loadLocationsWithWeather()
    {
        $locations = Location::with('appUser')->get();

        $this->locations = $locations->map(function ($location) {
            $weatherData = WeatherHelper::getWeatherData($location->latitude, $location->longitude);

            return [
                'latitude' => $location->latitude,
                'longitude' => $location->longitude,
                'location_name' => $location->location_name,
                'app_user' => [
                    'name' => $location->appUser->name,
                    'email' => $location->appUser->email,
                    'username' => $location->appUser->username
                ],
                'weather' => $weatherData, // Tambahkan data cuaca
            ];
        })->toArray();
    }

    public function render()
    {
        $this->loadLocationsWithWeather();

        return view('livewire.map');
    }
}