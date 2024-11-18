<?php

namespace App\Filament\Resources;

use App\Filament\Resources\TreatmentLogsResource\Pages;
use App\Filament\Resources\TreatmentLogsResource\RelationManagers;
use App\Models\TreatmentLogs;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Models\DiagnosisHistory;

class TreatmentLogsResource extends Resource
{
    protected static ?string $model = TreatmentLogs::class;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-check';
    protected static ?string $navigationGroup = 'User Management';
    protected static ?int $navigationSort = 6;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make()
                ->schema([
                    Forms\Components\Select::make('diagnosis_history_id')
                        ->options(fn () => DiagnosisHistory::all()->mapWithKeys(function ($item) {
                            return [
                                $item->id => "ID: {$item->id}, Media Tanam: {$item->media_type}, Nama Tanaman: {$item->name_plant}"
                            ];
                        }))
                        ->searchable()
                        ->label('Diagnosis History ID')
                        ->required()
                        ->placeholder('Pilih berdasarkan Diagnosis History'),
                    Forms\Components\Select::make('treatment_type')
                        ->required()
                        ->options([
                            'penyiraman' => 'Penyiraman',
                            'pemupukan' => 'Pemupukan',
                            'pencahayaan' => 'Pencahayaan Matahari',
                            'pengendalian hama' => 'Pengendalian Hama dan Penyakit',
                            'pemangkasan' => 'Pemangkasan',
                            'kelembapan' => 'Pemantauan Kelembapan',
                        ])
                        ->placeholder('Pilih Jenis Perawatan'),
                    Forms\Components\DateTimePicker::make('treatment_date')
                        ->required(),
                ]),
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\MarkdownEditor::make('notes')
                            ->placeholder('Tuliskan catatan perawatan tanaman disini')
                            ->label('Catatan')
                            ->required(),
                    ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('diagnosis_history_id')
                    ->numeric()
                    ->sortable(),
                Tables\Columns\TextColumn::make('treatment_type')
                    ->searchable(),
                Tables\Columns\TextColumn::make('treatment_date')
                    ->dateTime()
                    ->sortable(),
                Tables\Columns\TextColumn::make('notes')
                    ->searchable(),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
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
            'index' => Pages\ListTreatmentLogs::route('/'),
            'create' => Pages\CreateTreatmentLogs::route('/create'),
            'edit' => Pages\EditTreatmentLogs::route('/{record}/edit'),
        ];
    }
}
