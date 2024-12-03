<x-filament::page>
    <form wire:submit.prevent="detect" class="max-w-md mx-auto p-6 bg-gray-800 rounded-lg shadow-md">
        <h2 class="text-lg font-medium text-center text-gray-100 mb-4">Deteksi Penyakit Daun</h2>

        <!-- Section Upload Image -->
        <div class="mb-6 flex justify-between">
            <div class="w-full md:w-2/3">
                <label for="image" class="block font-medium text-lg text-gray-100 mb-2">Unggah Gambar Daun</label>
                <input type="file" 
                    wire:model="image" 
                    id="image" 
                    accept="image/*" 
                    class="block w-full cursor-pointer border rounded-lg p-3 text-gray-200 bg-gray-700 focus:ring focus:ring-blue-500"
                />
                <p class="mt-2 text-sm text-gray-400">Unggah file gambar untuk proses deteksi.</p>
                @error('image') 
                    <span class="text-red-400 text-sm">{{ $message }}</span> 
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
        <div class="mt-6 bg-gray-800 p-6 rounded-lg shadow-md">
            <h3 class="text-lg font-medium text-left text-gray-100 mb-2">Hasil Deteksi:</h3>
            @if (isset($result['error']))
                <p class="text-red-400 text-center mt-4">{{ $result['error'] }}</p>
            @else
                <table class="w-full mt-4 border-collapse border border-gray-700">
                    <thead>
                        <tr class="bg-gray-700">
                            <th class="border border-gray-600 px-4 py-2 text-left text-gray-100">Nama Penyakit</th>
                            <th class="border border-gray-600 px-4 py-2 text-left text-gray-100">Akurasi</th>
                            <th class="border border-gray-600 px-4 py-2 text-left text-gray-100">Deskripsi</th>
                            <th class="border border-gray-600 px-4 py-2 text-left text-gray-100">Gejala</th>
                            <th class="border border-gray-600 px-4 py-2 text-left text-gray-100">Penyebab</th>
                            <th class="border border-gray-600 px-4 py-2 text-left text-gray-100">Pencegahan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="border border-gray-600 px-4 py-2 text-gray-200">{{ $result['disease_name'] ?? '' }}</td>
                            <td class="border border-gray-600 px-4 py-2 text-gray-200">{{ $result['confidence'] ?? '' }}%</td>
                            <td class="border border-gray-600 px-4 py-2 text-gray-200">{{ $result['description'] ?? '' }}</td>
                            <td class="border border-gray-600 px-4 py-2 text-gray-200">{{ $result['symptoms'] ?? '' }}</td>
                            <td class="border border-gray-600 px-4 py-2 text-gray-200">{{ $result['cause'] ?? '' }}</td>
                            <td class="border border-gray-600 px-4 py-2 text-gray-200">{{ $result['prevention'] ?? '' }}</td>                            
                        </tr>
                    </tbody>
                </table>
            @endif
        </div>
    @endif
</x-filament::page>
