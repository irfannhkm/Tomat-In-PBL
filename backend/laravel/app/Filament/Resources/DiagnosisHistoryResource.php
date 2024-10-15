<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DiagnosisHistoryResource\Pages;
use App\Filament\Resources\DiagnosisHistoryResource\RelationManagers;
use App\Models\DiagnosisHistory;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class DiagnosisHistoryResource extends Resource
{
    protected static ?string $model = DiagnosisHistory::class;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-list';
    protected static ?string $navigationLabel = 'Diagnosis History';
    protected static ?string $navigationGroup = 'Plants Management';
    protected static ?int $navigationSort = 5;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                //
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListDiagnosisHistories::route('/'),
            'create' => Pages\CreateDiagnosisHistory::route('/create'),
            'edit' => Pages\EditDiagnosisHistory::route('/{record}/edit'),
        ];
    }
}
