<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Location;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Helpers\WeatherHelper;

class LocationController extends Controller
{
    /**
     * List all locations for the authenticated user.
     */
    public function index()
    {
        $locations = Location::where('user_id', Auth::id())
            ->select('id', 'location_name', 'latitude', 'longitude', 'created_at', 'updated_at')
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Lokasi berhasil ditemukan.',
            'data' => $locations,
        ]);
    }

    /**
     * Show a specific location along with current weather data.
     */
    public function show($id)
    {
        $location = Location::where('user_id', Auth::id())->find($id);

        if (!$location) {
            return response()->json([
                'success' => false,
                'message' => 'Lokasi tidak ditemukan.',
            ], 404);
        }

        // Mengambil data cuaca
        $weatherData = WeatherHelper::getWeatherData($location->latitude, $location->longitude);

        if (isset($weatherData['error'])) {
            return response()->json([
                'success' => false,
                'message' => $weatherData['error'],
            ], 400);
        }

        return response()->json([
            'success' => true,
            'message' => 'Lokasi berhasil ditemukan.',
            'location' => $location,
            'weather' => $weatherData,
        ]);
    }

    /**
     * Store a new location along with its weather data.
     */
    public function store(Request $request)
    {
        $request->validate([
            'location_name' => 'required|string',
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
        ]);

        $location = new Location();
        $location->user_id = Auth::id();
        $location->location_name = $request->location_name;
        $location->latitude = $request->latitude;
        $location->longitude = $request->longitude;
        $location->save();

        $weatherData = WeatherHelper::getWeatherData($location->latitude, $location->longitude);

        return response()->json([
            'success' => true,
            'message' => 'Lokasi berhasil ditambahkan.',
            'location' => $location,
            'weather' => $weatherData,
        ], 201);
    }

    /**
     * Update an existing location and retrieve updated weather data.
     */
    public function update(Request $request, $id)
    {
        $location = Location::where('user_id', Auth::id())->find($id);

        if (!$location) {
            return response()->json([
                'success' => false,
                'message' => 'Lokasi tidak ditemukan.',
            ], 404);
        }

        $request->validate([
            'location_name' => 'required|string|max:100',
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
        ]);

        $location->update([
            'location_name' => $request->location_name,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
        ]);

        $weatherData = WeatherHelper::getWeatherData($location->latitude, $location->longitude);

        return response()->json([
            'success' => true,
            'message' => 'Lokasi berhasil diperbarui.',
            'location' => $location,
            'weather' => $weatherData,
        ]);
    }

    /**
     * Delete a location.
     */
    public function destroy($id)
    {
        $location = Location::where('user_id', Auth::id())->find($id);

        if (!$location) {
            return response()->json([
                'success' => false,
                'message' => 'Lokasi tidak ditemukan.',
            ], 404);
        }

        $location->delete();

        return response()->json([
            'success' => true,
            'message' => 'Lokasi berhasil dihapus.',
        ]);
    }
}
