<?php

namespace App\Filament\Admin\Themes;

use Filament\Panel;
use Hasnayeen\Themes\Contracts\CanModifyPanelConfig;
use Hasnayeen\Themes\Contracts\Theme;

class Awesome implements CanModifyPanelConfig, Theme
{
    public static function getName(): string
    {
        return 'awesome';
    }

    public static function getPath(): string
    {
        return 'resources/css/filament/admin/themes/awesome.css';
    }

    public function getThemeColor(): array
    {
        return [
            'primary' => '#051F20',  // Darkest green
            'secondary' => '#0B2B26',  // Slightly lighter dark green
            'accent' => '#163832',  // Medium-dark green
            'neutral' => '#235347',  // Green with a more balanced tone
            'highlight' => '#8EB69B',  // Lighter green
            'background' => '#DAF1DE',  // Lightest green, suitable for backgrounds
        ];
    }

    public function modifyPanelConfig(Panel $panel): Panel
    {
        return $panel
            ->viteTheme($this->getPath());
    }
}
