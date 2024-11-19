<x-filament::page>
    <form wire:submit.prevent="detect" class="space-y-6">
        <!-- Section Upload Image -->
        <div>
            <label for="image" class="block font-medium text-sm text-gray-500">
                Ambil Gambar Daun Menggunakan Kamera
            </label>
            <div class="text-center">
                <input type="file" 
                    wire:model="image" 
                    id="image" 
                    accept="image/*" 
                    capture="environment" 
                    class="block mt-2 w-full cursor-pointer border rounded-lg p-2 text-gray-700 focus:ring focus:ring-blue-300" 
                />
                <p class="mt-2 text-sm text-gray-400">Gunakan kamera untuk mengambil gambar langsung.</p>
            </div>
            @error('image') 
                <span class="text-red-500 text-sm">{{ $message }}</span> 
            @enderror
        </div>

        <!-- Submit Button -->
        <div class="flex justify-center">
            <x-filament::button type="submit" color="success">
                <x-heroicon-o-camera class="w-5 h-5 mr-2" />
                Deteksi Daun Sekarang (Klik 2x)
            </x-filament::button>
        </div>
    </form>

    <!-- Display Uploaded Image -->
    @if ($image)
        <div class="mt-6 text-center">
            <h3 class="text-lg font-medium">Gambar yang Diunggah:</h3>
            <img src="{{ $image->temporaryUrl() }}" alt="Uploaded image" class="w-full max-w-md mx-auto rounded-lg shadow-md">
            <p class="mt-2 text-sm text-gray-500"><strong>Path Gambar:</strong> {{ $image->getRealPath() ?? 'Tidak tersedia' }}</p>
        </div>
    @endif

    <!-- Display Detection Result -->
    @if ($result)
        <div class="mt-6 text-center">
            <h3 class="text-lg font-medium">Hasil Deteksi:</h3>
            @if (isset($result['error']))
                <p class="text-red-500">{{ $result['error'] }}</p>
            @else
                <p><strong>Label:</strong> {{ $result['label'] }}</p>
                <p><strong>Akurasi:</strong> {{ number_format($result['confidence'] * 100, 2) }}%</p>
            @endif
        </div>
    @endif
</x-filament::page>
