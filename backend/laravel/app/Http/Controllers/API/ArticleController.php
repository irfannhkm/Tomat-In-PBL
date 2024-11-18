<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Article;
use Illuminate\Support\Facades\Storage;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    /**
     * Get a list of all articles.
     */
    public function index()
    {
        $articles = Article::select('id', 'article_title', 'article_content', 'article_url', 'disease_id', 'image_cover', 'created_at', 'updated_at')
            ->with('disease:id,disease_name') // Include related disease data
            ->latest('created_at') // Order by creation date
            ->get();

        return response()->json([
            'success' => true,
            'data' => $articles,
        ]);
    }

    /**
     * Get details of a single article by ID.
     */
    public function show($id)
    {
        $article = Article::with('disease:id,disease_name') // Include related disease data
            ->select('id', 'article_title', 'article_content', 'article_url', 'disease_id', 'image_cover', 'created_at', 'updated_at')
            ->find($id);

        if (!$article) {
            return response()->json([
                'success' => false,
                'message' => 'Article not found.',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $article,
        ]);
    }
    public function store(Request $request)
    {
        $validated = $request->validate([
            'article_title' => 'required|string|max:255',
            'article_content' => 'required|string',
            'article_url' => 'required|url',
            'image_cover' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        if ($request->hasFile('image_cover')) {
            $validated['image_cover'] = $request->file('image_cover')->store('article_images', 'public');
        }

        $article = Article::create($validated);

        return response()->json([
            'success' => true,
            'data' => $article,
        ], 201);
    }
}
