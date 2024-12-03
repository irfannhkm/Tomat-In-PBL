<?php

namespace App\Filament\Pages;

use BezhanSalleh\FilamentShield\Traits\HasPageShield;
use Filament\Pages\Page;

class MapLocation extends Page
{
    use HasPageShield;
    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $navigationLabel = 'Map Location User';
    protected static ?string $navigationGroup = 'User Management';
    protected static ?int $navigationSort = 3;
    protected static string $view = 'filament.pages.map-location';
    

}
