<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class YouTubeVideoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $youtubeVideos = [
            [
                'video_title' => 'Tomato Mosaic Virus (Symptoms and Management)',
                'video_url' => 'https://www.youtube.com/watch?v=_w5GwfbVytE',
                'disease_id' => 9  // Tomato_mosaic_virus
            ],
            [
                'video_title' => 'Hydrogen Peroxide & Baking Soda Home Remedies for Leaf Spot and Early Blight',
                'video_url' => 'https://www.youtube.com/watch?v=OANcSiKZzyQ',
                'disease_id' => 4  // Leaf_Mold
            ],
            [
                'video_title' => 'How to Treat Early Blight in Tomato Plants',
                'video_url' => 'https://www.youtube.com/watch?v=s9ztEw_r9R4',
                'disease_id' => 2  // Early_blight
            ],
            [
                'video_title' => 'How to Defeat Tomato Blight',
                'video_url' => 'https://www.youtube.com/watch?v=QEuknYpO7E',
                'disease_id' => 3  // Late_blight
            ],
            [
                'video_title' => 'Medicine and Treatment For Leaf Curl Virus/Mosaic Virus in All Vegetable Crops',
                'video_url' => 'https://www.youtube.com/watch?v=jMKk4gHZx5w',
                'disease_id' => 8  // Yellow_Leaf_Curl_Virus
            ],
            [
                'video_title' => 'Best Practices for Growing Healthy Tomatoes',
                'video_url' => 'https://www.youtube.com/watch?v=abcd1234', // Replace with actual URL
                'disease_id' => 10 // Tomato healthy
            ],
            [
                'video_title' => 'How to Fertilize Tomato Plants for Maximum Yield',
                'video_url' => 'https://www.youtube.com/watch?v=efgh5678', // Replace with actual URL
                'disease_id' => 10 // Tomato healthy
            ],
            [
                'video_title' => 'Watering Techniques for Healthy Tomato Plants',
                'video_url' => 'https://www.youtube.com/watch?v=ijkl9012', // Replace with actual URL
                'disease_id' => 10 // Tomato healthy
            ],
            [
                'video_title' => 'Pruning Tomato Plants for Better Growth',
                'video_url' => 'https://www.youtube.com/watch?v=mnoq3456', // Replace with actual URL
                'disease_id' => 10 // Tomato healthy
            ],
            [
                'video_title' => 'Companion Planting for Healthy Tomatoes',
                'video_url' => 'https://www.youtube.com/watch?v=pqrs7890', // Replace with actual URL
                'disease_id' => 10 // Tomato healthy
            ],
        ];
        

        foreach ($youtubeVideos as $video) {
            \App\Models\YouTubeVideo::create($video);
        }
    }
}
