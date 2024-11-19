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
    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'User Management';
    protected static ?int $navigationSort = 5;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\Select::make('user_id')
                            ->relationship('AppUser', 'name')
                            ->label('User ID')
                            ->required()
                            ->placeholder('Select User ID'),
                        Forms\Components\Select::make('disease_id')
                            ->required()
                            ->label('Penyakit Tanaman')
                            ->relationship('Disease', 'disease_name')
                            ->placeholder('Select Disease'),             
                            Forms\Components\Select::make('media_type')
                            ->label('Jenis Media Tanam')
                            ->options([
                                'pot' => 'Pot',
                                'lahan_sawah' => 'Lahan Sawah',
                                'pekarangan' => 'Pekarangan Belakang Rumah',
                            ])
                            ->required()
                            ->reactive() // Memungkinkan form bereaksi terhadap perubahan
                            ->afterStateUpdated(function (callable $set, $state) {
                                $set('media_size', ''); // Reset media_size ketika jenis media berubah
                            }),
                        
                        Forms\Components\Select::make('media_size')
                            ->label('Ukuran Media Tanam')
                            ->options(function (callable $get) {
                                $mediaType = $get('media_type'); // Mendapatkan nilai media_type
                        
                                if ($mediaType === 'pot') {
                                    return [
                                        'kecil' => 'Kecil (5-10 cm)',
                                        'sedang' => 'Sedang (10-20 cm)',
                                        'besar' => 'Besar (>20 cm)',
                                    ];
                                } elseif ($mediaType === 'lahan_sawah') {
                                    return [
                                        'seperempat_hektar' => '1/4 Hektar',
                                        'setengah_hektar' => '1/2 Hektar',
                                        'satu_hektar' => '1 Hektar',
                                    ];
                                } elseif ($mediaType === 'pekarangan') {
                                    return [
                                        'kecil' => 'Kecil (10-50 m²)',
                                        'sedang' => 'Sedang (50-200 m²)',
                                        'besar' => 'Besar (>200 m²)',
                                    ];
                                }
                        
                                return []; // Default jika media_type belum dipilih
                            })
                            ->required(),
                        Forms\Components\TextInput::make('name_plant')
                            ->label('Nama Tanaman')
                            ->placeholder('Tomat John Doe')
                            ->helperText('Anda bisa menambahkan nama tanaman jika ada'),
                       
                    ]),
                Forms\Components\Group::make()
                    ->schema([    
                        Forms\Components\FileUpload::make('Gambar Deteksi')
                            ->image()
                            ->required(fn (string $context): bool => $context === 'create'),
                        
                        Forms\Components\DatePicker::make('diagnosis_date')
                            ->required(),
                    ])
                
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('AppUser.name')
                    ->sortable()
                    ->searchable()
                    ->label('User'),
                Tables\Columns\TextColumn::make('Disease.disease_name')
                    ->label('Penyakit Tanaman')
                    ->sortable()
                    ->limit(25),
                Tables\Columns\ImageColumn::make('image')
                    ->label('Image')
                    ->circular(),
                Tables\Columns\TextColumn::make('media_type')
                    ->label('Media Tanam'),
                Tables\Columns\TextColumn::make('media_size')
                    ->label('Ukuran Media'),
                Tables\Columns\TextColumn::make('diagnosis_date')
                    ->label('Tanggal Deteksi')
                    ->date()
                    ->sortable(),
                Tables\Columns\TextColumn::make('name_plant')
                    ->label('Nama Tanaman'),
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
            'index' => Pages\ListDiagnosisHistories::route('/'),
            'create' => Pages\CreateDiagnosisHistory::route('/create'),
            'edit' => Pages\EditDiagnosisHistory::route('/{record}/edit'),
    
        ];
    }
}
