<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class LandingPageController extends Controller
{
    // Menampilkan halaman utama
    public function index()
    {
        return view('landing.index');
    }

    // Menangani pengiriman pesan dari formulir
    public function sendMessage(Request $request)
    {
        dd($request->all()); 
        // Validasi input
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'subject' => 'required|string|max:255',
            'message' => 'required|string|max:5000',
        ]);

        // Data yang akan dikirimkan ke email
        $data = $request->only(['name', 'email', 'subject', 'message']);

        try {
            // Kirim email
            Mail::send('emails.contact', $data, function ($message) use ($data) {
                $message->to('leafingrowbeyond@gmail.com')
                    ->subject($data['subject'])
                    ->from($data['email'], $data['name']);
            });

            return redirect()->back()->with('success', 'Your message has been sent successfully!');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Failed to send your message. Please try again.');
        }
    }
}

