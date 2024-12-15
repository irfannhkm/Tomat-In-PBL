<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\YouTubeVideo;
use Illuminate\Http\Request;

class YouTubeVideoController extends Controller
{
    /**
     * Get a list of all YouTube videos.
     */
    public function index()
    {
        $videos = YouTubeVideo::select('id', 'video_title', 'video_url', 'disease_id', 'created_at', 'updated_at')
            ->with('disease:id,disease_name') // Include related disease data
            ->latest('created_at') // Order by creation date
            ->get();

        return response()->json([
            'success' => true,
            'data' => $videos,
        ]);
    }

    /**
     * Get details of a single YouTube video by ID.
     */
    public function show($id)
    {
        $video = YouTubeVideo::with('disease:id,disease_name') // Include related disease data
            ->select('id', 'video_title', 'video_url', 'disease_id', 'created_at', 'updated_at')
            ->find($id);

        if (!$video) {
            return response()->json([
                'success' => false,
                'message' => 'Video not found.',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $video,
        ]);
    }
}
