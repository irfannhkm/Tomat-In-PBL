<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;

use BezhanSalleh\FilamentShield\Traits\HasPageShield;

class Map extends Page
{
    use HasPageShield;
    protected static ?string $navigationIcon = 'heroicon-o-document-text';    protected static ?string $navigationLabel = 'User';

    protected static ?string $navigationGroup = 'User Management';
    
    protected static string $view = 'filament.pages.map';

}
