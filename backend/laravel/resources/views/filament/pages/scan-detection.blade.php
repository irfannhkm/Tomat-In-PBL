<x-filament::page>
    <form wire:submit.prevent="detect" class="max-w-md mx-auto p-6 bg-white dark:bg-gray-800 rounded-lg shadow-md">
        <!-- Title -->
        <h2 class="text-lg font-medium text-center text-green-500 dark:text-green-300 mb-2">
            <span class="bg-green-100 dark:bg-green-700 py-1 px-2 rounded-full text-green-800 dark:text-green-200">
              Deteksi Penyakit Daun Tomat
            </span>
        </h2>

        <!-- Image Upload Section -->
        <div class="mb-6">
            <label for="image" class="block font-medium text-lg text-gray-800 dark:text-gray-100 mb-2">Unggah Gambar Daun</label>
            <input type="file" 
                wire:model="image" 
                id="image" 
                accept="image/*" 
                class="block w-full cursor-pointer border rounded-lg p-3 text-gray-800 dark:text-gray-200 bg-white dark:bg-gray-700 focus:ring focus:ring-blue-500"
            />
            @error('image') 
                <span class="text-red-500 dark:text-red-400 text-sm">{{ $message }}</span> 
            @enderror

            <!-- Preview Uploaded Image -->
            @if ($image)
                <img src="{{ $image->temporaryUrl() }}" alt="Uploaded image" class="w-full max-w-md mx-auto rounded-lg shadow-md my-4">
            @endif
        </div>

        <!-- Detect Button -->
        <div class="w-full flex justify-center">
            <x-filament::button type="submit" color="danger" class="px-4 py-2 text-lg font-medium">
                <x-heroicon-o-camera class="w-8 h-8 mr-2 align-middle" />
                <span>Deteksi</span>
            </x-filament::button>
        </div>
    </form>

    <!-- Detection Result -->
    @if ($result)
        <div class="mt-6 bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
            <h2 class="text-lg font-medium text-center text-green-500 dark:text-green-300 mb-2">
                <span class="bg-green-100 dark:bg-green-700 py-1 px-2 rounded-full text-green-800 dark:text-green-200">
                  Hasil Deteksi:
                </span>
            </h2>

            <!-- Display Error if any -->
            @if (isset($result['error']))
                <p class="text-red-500 dark:text-red-400 text-center mt-4">{{ $result['error'] }}</p>
            @else
                @if (isset($result['image_with_bounding_box']))
                    <div class="mt-6">
                        <p class="text-center font-medium text-gray-800 dark:text-gray-200 mb-2">Hasil Deteksi dengan Bounding Box:</p>
                        <img src="{{ $result['image_with_bounding_box'] }}" alt="Image with Bounding Box" class="w-full max-w-sm mx-auto rounded-lg shadow-md">
                    </div>
                @endif
                <!-- Detection Table -->
                <table class="w-full mt-4 border-collapse border border-gray-300 dark:border-gray-700">
                    <thead>
                        <tr class="bg-gray-100 dark:bg-gray-700">
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Nama Penyakit</th>
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Confidence Klasifikasi</th>
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Gambar Penyakit</th>
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Deskripsi Penyakit</th>
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Gejala Penyakit</th>
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Pencegahan Penyakit</th>
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Segmentasi Confidence</th>
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Bounding Box</th>
                            <th class="px-4 py-2 border text-left text-gray-800 dark:text-gray-100">Ukuran Bounding Box</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">{{ $result['disease_name'] ?? '-' }}</td>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">{{ $result['classification']['confidence'] ?? '-' }}%</td>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">
                                @if (isset($result['image']))
                                    <img src="{{ $result['image'] }}" alt="Disease Image" class="w-full max-w-sm mx-auto rounded-lg shadow-md">
                                @endif
                            </td>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">{{ $result['description'] ?? '-' }}</td>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">{{ $result['symptoms'] ?? '-' }}</td>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">{{ $result['prevention'] ?? '-' }}</td>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">{{ $result['segmentation_confidence'] ?? '-' }}%</td>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">
                                {{ json_encode($result['bounding_box'] ?? []) }}
                            </td>
                            <td class="px-4 py-2 border text-gray-800 dark:text-gray-200 text-sm text-center">
                                @if (isset($result['shape']))
                                    {{ $result['shape'][0] ?? '-' }}x{{ $result['shape'][1] ?? '-' }} px
                                @else
                                    -
                                @endif
                            </td>
                            
                        </tr>
                    </tbody>
                </table>
            @endif
        </div>
    @endif
</x-filament::page>
