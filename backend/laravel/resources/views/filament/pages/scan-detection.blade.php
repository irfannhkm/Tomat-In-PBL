    <x-filament::page>
        <form wire:submit.prevent="detect" class="space-y-6">
            <!-- Section Upload Image -->
            <div>
                <label for="image" class="block font-medium text-sm text-gray-500">
                    Unggah Gambar Daun untuk Deteksi
                </label>
                <div class="text-center">
                    <input type="file" 
                        wire:model="image" 
                        id="image" 
                        accept="image/*" 
                        class="block mt-2 w-full cursor-pointer border rounded-lg p-2 text-gray-700 focus:ring focus:ring-blue-300" 
                    />
                    <p class="mt-2 text-sm text-gray-400">Unggah file gambar untuk proses deteksi.</p>
                </div>
                @error('image') 
                    <span class="text-red-500 text-sm">{{ $message }}</span> 
                @enderror
            </div>

            <!-- Submit Button -->
            <div class="flex justify-center">
                <x-filament::button type="submit" color="success">
                    <x-heroicon-o-camera class="w-2 h-2 mr-2" />
                    Deteksi Sekarang 2x
                </x-filament::button>
            </div>
        </form>

        <!-- Display Uploaded Image -->
        @if ($image)
            <div class="mt-6 text-center">
                <h3 class="text-lg font-medium">Gambar yang Diunggah:</h3>
                <img src="{{ $image->temporaryUrl() }}" alt="Uploaded image" class="w-full max-w-md mx-auto rounded-lg shadow-md">
            </div>
        @endif

        <!-- Display Detection Result -->
        @if ($result)
            <div class="mt-6 text-center">
                <h3 class="text-lg font-medium">Hasil Deteksi:</h3>
                @if (isset($result['error']))
                    <p class="text-red-500">{{ $result['error'] }}</p>
                @else
                    <p><strong>Label:</strong> {{ $result['top1_label'] }}</p>
                    <p><strong>Akurasi:</strong> {{ number_format($result['top1_confidence'], 2) }}%</p>
                    <h4 class="mt-4 font-semibold">Prediksi Top-5:</h4>
                    <ul>
                        @foreach ($result['top5'] as $classification)
                            <li>{{ $classification['label'] }} - {{ number_format($classification['confidence'], 2) }}%</li>
                        @endforeach
                    </ul>
                @endif
            </div>
        @endif
    </x-filament::page>
