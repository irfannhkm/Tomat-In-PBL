<x-filament::page>
    <form wire:submit.prevent="detect" class="max-w-md mx-auto p-6 bg-white rounded-lg shadow-md">
        <h2 class="text-lg font-medium text-center text-gray-700 mb-4">Deteksi Penyakit Daun</h2>

        <!-- Section Upload Image -->
        <div class="mb-6 flex justify-between">
            <div class="w-full md:w-2/3">
                <label for="image" class="block font-medium text-lg text-gray-700 mb-2">Unggah Gambar Daun</label>
                <input type="file" 
                    wire:model="image" 
                    id="image" 
                    accept="image/*" 
                    class="block w-full cursor-pointer border rounded-lg p-3 text-gray-700 focus:ring focus:ring-blue-300"
                />
                <p class="mt-2 text-sm text-gray-400">Unggah file gambar untuk proses deteksi.</p>
                @error('image') 
                    <span class="text-red-500 text-sm">{{ $message }}</span> 
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
        <div class="mt-6 bg-white p-6 rounded-lg shadow-md">
            <h3 class="text-lg font-medium text-left text-gray-700 mb-2">Hasil Deteksi:</h3>
            @if (isset($result['error']))
                <p class="text-red-500 text-center mt-4">{{ $result['error'] }}</p>
            @else
                <table class="w-full mt-4 border-collapse border border-gray-300">
                    <thead>
                        <tr class="bg-gray-100">
                            <th class="border px-4 py-2 text-left">Nama Penyakit</th>
                            <th class="border px-4 py-2 text-left">Akurasi</th>
                            <th class="border px-4 py-2 text-left">Deskripsi</th>
                            <th class="border px-4 py-2 text-left">Gejala</th>
                            <th class="border px-4 py-2 text-left">Penyebab</th>
                            <th class="border px-4 py-2 text-left">Pencegahan</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="border px-4 py-2">{{ $result['disease_name'] ?? '' }}</td>
                            <td class="border px-4 py-2">{{ $result['confidence'] ?? '' }}%</td>
                            <td class="border px-4 py-2">{{ $result['description'] ?? '' }}</td>
                            <td class="border px-4 py-2">{{ $result['symptoms'] ?? '' }}</td>
                            <td class="border px-4 py-2">{{ $result['cause'] ?? '' }}</td>
                            <td class="border px-4 py-2">{{ $result['prevention'] ?? '' }}</td>                            
                        </tr>
                    </tbody>
                </table>
            @endif
        </div>
    @endif
</x-filament::page>