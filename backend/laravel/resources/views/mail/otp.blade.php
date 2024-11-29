<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TomatIn - OTP Verification</title>
    <!-- Logo favicon -->
    <link rel="icon" type="image/x-icon" href="{{ asset('images/favicon.png') }}">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gradient-to-b from-green-100 to-gray-50 min-h-screen flex items-center justify-center">
    <div class="max-w-md w-full bg-white shadow-lg rounded-xl p-6">
        <!-- Header -->
        <div class="text-center">
            <img src="{{ asset('images/logo_tomatin_upscayl.png') }}" alt="TomatIn Logo" class="w-16 mx-auto mb-4">
            <h1 class="text-2xl font-bold text-gray-800 mb-2">Verifikasi OTP</h1>
            <p class="text-gray-600 mb-4">Kode verifikasi telah dikirim ke email Anda. Masukkan kode untuk melanjutkan.</p>
        </div>

        <!-- OTP Code -->
        <div class="flex justify-center items-center bg-gray-100 rounded-lg p-4 mb-6">
            <span class="text-gray-500 text-2xl font-bold">Kode OTP Anda:</span>
            <span class="ml-2 text-green-600 text-2xl font-bold"><b>{{ $otp }}<b></span>
        </div>
    </div>
</body>

</html>
