<?php

namespace App\Filament\Resources;

use App\Filament\Resources\DiseaseResource\Pages;
use App\Models\Disease;
use Filament\Forms;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;

class DiseaseResource extends Resource
{
    protected static ?string $model = Disease::class;

    protected static ?string $navigationIcon = 'heroicon-o-exclamation-circle';
    protected static ?string $navigationLabel = 'Diseases';
    protected static ?string $navigationGroup = 'Plants Management';
    protected static ?int $navigationSort = 5;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('name')
                    ->label('Disease Name')
                    ->required()
                    ->maxLength(100)
                    ->placeholder('Enter the disease name'),
                Forms\Components\Textarea::make('description')
                    ->label('Description')
                    ->required()
                    ->maxLength(500)
                    ->placeholder('Enter the description of the disease'),
                Forms\Components\TextInput::make('symptoms')
                    ->label('Symptoms')
                    ->maxLength(255)
                    ->placeholder('List common symptoms'),
                Forms\Components\TextInput::make('cause')
                    ->label('Cause')
                    ->maxLength(255)
                    ->placeholder('Specify the cause of the disease'),
                Forms\Components\TextInput::make('prevention')
                    ->label('Prevention')
                    ->maxLength(255)
                    ->placeholder('Suggest preventive measures (optional)'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id') // Menambahkan kolom ID
                    ->sortable()
                    ->label('No'),
                Tables\Columns\TextColumn::make('disease_name')
                    ->searchable()
                    ->sortable()
                    ->label('Disease Name'),
                Tables\Columns\TextColumn::make('description')
                    ->limit(30)
                    ->label('Description'),
                Tables\Columns\TextColumn::make('symptoms')
                    ->limit(25)
                    ->label('Gejala'),
                // Tables\Columns\TextColumn::make('cause')
                //     ->limit(25)
                //     ->label('Penyebab'),
                // Tables\Columns\TextColumn::make('prevention')
                //     ->limit(25)
                //     ->label('Pencegahan'),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true)
                    ->label('Created At'),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true)
                    ->label('Updated At'),
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
            'index' => Pages\ListDiseases::route('/'),
            'create' => Pages\CreateDisease::route('/create'),
            'edit' => Pages\EditDisease::route('/{record}/edit'),
        ];
    }
}
