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
    protected static ?string $navigationGroup = 'User Management';
    protected static ?int $navigationSort = 5;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('user_id') 
                    ->label('User ID')
                    ->required(),
                Forms\Components\Select::make('disease_id')
                    ->label('Disease ID')
                    ->required(),
                Forms\Components\FileUpload::make('image')
                    ->label('Image')
                    ->required(),
                Forms\Components\DatePicker::make('diagnosis_date')
                    ->label('Diagnosis Date')
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('user_id')
                    ->relationship('AppUser', 'name')
                    ->preload()
                    ->searchable()
                    ->label('User ID')
                    ->sortable(),
                Tables\Columns\TextColumn::make('disease_id')
                    ->relationship('disease', 'disease_name')
                    ->preload()
                    ->label('Disease ID')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('image')
                    ->label('Image')
                    ->searchable()
                    ->circular()
                    ->sortable(),
                Tables\Columns\TextColumn::make('diagnosis_date')
                    ->label('Diagnosis Date')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable(),        
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
