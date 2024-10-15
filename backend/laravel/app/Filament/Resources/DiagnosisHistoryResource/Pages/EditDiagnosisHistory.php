<?php

namespace App\Filament\Resources\DiagnosisHistoryResource\Pages;

use App\Filament\Resources\DiagnosisHistoryResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditDiagnosisHistory extends EditRecord
{
    protected static string $resource = DiagnosisHistoryResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
