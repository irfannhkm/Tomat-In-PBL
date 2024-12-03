<div class="grid grid-cols-1 dark:bg-gray-900 md:grid-cols-12 gap-4" wire:ignore>

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>

    <div class="md:col-span-2 bg-white dark:bg-gray-800 shadow-md rounded-lg p-6">
        <div id="map" class="w-full" style="height: 75vh;"></div>
    </div>

    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

    <script>
        document.addEventListener('livewire:initialized', function() {
            component = @this;

            let map = L.map('map').setView([-0.089275, 121.921327], 4.5);

            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }).addTo(map);

            const locations = @json($this->locations);
            console.log(locations);

            locations.forEach(location => {
                const weather = location.weather || {};
                const popupContent = `
                    <div class="popup-content">
                        <h2>${location.app_user?.name  || 'N/A'}</h2>

                        <p><b>Email:</b> ${location.app_user?.email || 'N/A'}<br>
                        <b>Username:</b> ${location.app_user?.username || 'N/A'}<br>
                        <b>Koordinat:</b> ${location.latitude || 'N/A'}, ${location.longitude || 'N/A'}</p>
                        
                        <p><b>Nama Kota:</b> ${weather.city_name || 'N/A'}<br>
                        <b>Cuaca:</b> ${weather.weather || 'N/A'}<br>
                        <b>Suhu:</b> ${weather.temperature || 'N/A'} °C<br>
                        <b>Kelembapan:</b> ${weather.humidity || 'N/A'}<br>
                        <b>Kecepatan Angin:</b> ${weather.wind_speed || 'N/A'}<br>
                        <b>Tekanan Udara:</b> ${weather.pressure || 'N/A'}<br>
                        <b>Waktu:</b> ${weather.forecast_time || 'N/A'}</p>
                        <p><b>Keterangan Lokasia:</b> ${location.location_name || 'N/A'}<br>
                    </div>
                `;
                L.marker([location.latitude, location.longitude])
                    .addTo(map)
                    .bindPopup(popupContent);
                });

        });
    </script>
</div>

<style>
    .popup-content {
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

    .popup-content h2 {
        font-size: 18px;
        margin-bottom: 10px;
    }

    .popup-content p {
        font-size: 14px;
        margin-bottom: 10px;
    }

    .popup-content h3 {
        font-size: 16px;
        margin-top: 10px;
    }
</style>

