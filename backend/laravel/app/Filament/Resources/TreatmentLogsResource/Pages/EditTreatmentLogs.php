<?php

namespace App\Filament\Resources\TreatmentLogsResource\Pages;

use App\Filament\Resources\TreatmentLogsResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditTreatmentLogs extends EditRecord
{
    protected static string $resource = TreatmentLogsResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
