<x-filament::page>
    <form wire:submit.prevent="detect" class="max-w-md mx-auto p-6 bg-white dark:bg-gray-800 rounded-lg shadow-md">
        <h2 class="text-lg font-medium text-center text-green-500 dark:text-green-300 mb-2">
            <span class="bg-green-100 dark:bg-green-700 py-1 px-2 rounded-full text-green-800 dark:text-green-200">
              Deteksi Penyakit Daun Tomat
            </span>
          </h2>
        <!-- Section Upload Image -->
        <div class="mb-6 flex justify-between">
            <div class="w-full md:w-2/3">
                <label for="image" class="block font-medium text-lg text-gray-800 dark:text-gray-100 mb-2">Unggah Gambar Daun</label>
                <input type="file" 
                    wire:model="image" 
                    id="image" 
                    accept="image/*" 
                    class="block w-full cursor-pointer border rounded-lg p-3 text-gray-800 dark:text-gray-200 bg-white dark:bg-gray-700 focus:ring focus:ring-blue-500"
                />
                <p class="mt-2 text-sm text-gray-600 dark:text-gray-400">Unggah file gambar untuk proses deteksi.</p>
                @error('image') 
                    <span class="text-red-500 dark:text-red-400 text-sm">{{ $message }}</span> 
                @enderror
                @if ($image)
                    <img src="{{ $image->temporaryUrl() }}" alt="Uploaded image" class="w-full max-w-md mx-auto rounded-lg shadow-md mb-4">
                @endif
            </div>
        </div>
        <!-- End Section Upload Image -->

        <div class="w-full flex justify-center">
            <x-filament::button type="submit" color="danger" class="px-4 py-2 text-lg">
                <x-heroicon-o-camera class="w-8 h-1 mx-auto my-auto mr-2" />
                <span class="flex items-center">
                    Deteksi 
                </span>
            </x-filament::button>
        </div>
    </form>

    <!-- Display Detection Result -->
    @if ($result)
        <div class="mt-6 bg-white dark:bg-gray-800 p-6 rounded-lg shadow-md">
            <h2 class="text-lg font-medium text-center text-green-500 dark:text-green-300 mb-2">
                <span class="bg-green-100 dark:bg-green-700 py-1 px-2 rounded-full text-green-800 dark:text-green-200">
                  Hasil Deteksi:
                </span>
              </h2>
            @if (isset($result['error']))
                <p class="text-red-500 dark:text-red-400 text-center mt-4">{{ $result['error'] }}</p>
            @else
                <table class="w-full mt-4 border-collapse border border-gray-300 dark:border-gray-700">
                    <thead>
                        <tr class="bg-gray-100 dark:bg-gray-700">
                            <th class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-left text-gray-800 dark:text-gray-100">Nama Penyakit</th>
                            <th class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-left text-gray-800 dark:text-gray-100">Akurasi</th>
                            <th class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-left text-gray-800 dark:text-gray-100">Gambar Penyakit</th>
                            <th class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-left text-gray-800 dark:text-gray-100">Deskripsi</th>
                            <th class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-left text-gray-800 dark:text-gray-100">Gejala</th>
                            <th class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-left text-gray-800 dark:text-gray-100">Penyebab</th>
                            <th class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-left text-gray-800 dark:text-gray-100">Pencegahan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-gray-800 dark:text-gray-200">{{ $result['disease_name'] ?? '' }}</td>
                            <td class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-gray-800 dark:text-gray-200">{{ $result['confidence'] ?? '' }}%</td>
                            <td class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-gray-800 dark:text-gray-200">
                                <img src="{{ $result['image'] ?? '' }}" alt="Penyakit" class="w-full max-w-md mx-auto rounded-lg shadow-md mb-4">
                            </td>
                            <td class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-gray-800 dark:text-gray-200">{{ $result['description'] ?? '' }}</td>
                            <td class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-gray-800 dark:text-gray-200">{{ $result['symptoms'] ?? '' }}</td>
                            <td class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-gray-800 dark:text-gray-200">{{ $result['cause'] ?? '' }}</td>
                            <td class="border border-gray-300 dark:border-gray-600 px-4 py-2 text-gray-800 dark:text-gray-200">{{ $result['prevention'] ?? '' }}</td>                            
                        </tr>
                    </tbody>
                </table>
            @endif
        </div>
    @endif
</x-filament::page>
