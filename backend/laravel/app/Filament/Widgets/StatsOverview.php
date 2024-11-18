<?php

namespace App\Filament\Widgets;

use App\Models\Article;
use App\Models\Disease;
use App\Models\AppUser;
use App\Models\YouTubeVideo;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends BaseWidget
{
    protected static ?int $sort = 1;

    protected function getStats(): array
    {
        return [
            Stat::make('Total Users', AppUser::count())
                ->icon('heroicon-o-user-group')
                ->description(('Jumlah Pengguna aplikasi'))
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color('success'),

            Stat::make('Total Penyakit', Disease::count())
                ->icon('heroicon-o-exclamation-circle')
                ->description(('Jumlah Penyakit pada daun tomat'))
                // ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color('danger'),

            Stat::make('Total Artikel', Article::count())
                ->icon('heroicon-o-document-text')
                ->description(('Jumlah Artikel yang dibuat'))
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color('warning'),

            Stat::make('Total Video', YouTubeVideo::count())
                ->icon('heroicon-o-video-camera')
                ->description(('Jumlah Video YouTube yang dibuat'))
                ->descriptionIcon('heroicon-m-arrow-trending-up')
                ->chart([7, 2, 10, 3, 15, 4, 17])
                ->color('info'),
        ];
    }
}
