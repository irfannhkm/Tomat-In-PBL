<?php

namespace App\Filament\Resources;

use App\Filament\Resources\LocationResource\Pages;
use App\Models\Location;
use Filament\Forms;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Humaidem\FilamentMapPicker\Fields\OSMMap;

class LocationResource extends Resource
{
    protected static ?string $model = Location::class;

    protected static ?string $navigationIcon = 'heroicon-o-map-pin';
    protected static ?string $navigationLabel = 'Locations';
    protected static ?string $navigationGroup = 'User Management';
    protected static ?int $navigationSort = 4;

    public static function form(Form $form): Form
    {
        return $form
        ->schema([
            Forms\Components\Group::make()
                ->schema([
                    Forms\Components\Section::make()
                        ->schema([
                            Forms\Components\TextInput::make('location_name')
                                ->label('Location Name')
                                ->required()
                                ->maxLength(100)
                                ->placeholder('Enter the name of the location')
                                ->helperText('contoh., Kebun atau Nama tempat'),
                            Forms\Components\Select::make('user_id')
                                ->relationship('AppUser', 'name')
                                ->label('User ID')
                                ->required()
                                ->searchable()
                                ->placeholder('Select User ID'),
                            Forms\Components\Group::make()
                                ->schema([
                                    Forms\Components\TextInput::make('latitude')
                                        ->required()
                                        ->numeric(),
                                    Forms\Components\TextInput::make('longitude')
                                        ->required()
                                        ->numeric(),
                                ])->columns(2)    
                        ])     
                ]),
                    Forms\Components\Group::make()
                        ->schema([
                            Forms\Components\Section::make()
                                ->schema([
                                    OSMMap::make('location')
                                        ->label('Location')
                                        ->showMarker()
                                        ->draggable()
                                        ->extraControl([
                                            'zoomDelta'           => 1,
                                            'zoomSnap'            => 0.25,
                                            'wheelPxPerZoomLevel' => 60
                                        ])
                                        ->afterStateHydrated(function (Forms\Get $get, Forms\Set $set, $record) {
                                            if ($record) {
                                                $latitude = $record->latitude;
                                                $longitude = $record->longitude;
                                                $locationName = $record->location_name;
                                
                                                if ($latitude && $longitude) {
                                                    $set('location', ['lat' => $latitude, 'lng' => $longitude, 'name' => $locationName]);
                                                }
                                            }
                                        })
                                        ->afterStateUpdated(function ($state, Forms\Get $get, Forms\Set $set) {
                                            $set('latitude', $state['lat']);
                                            $set('longitude', $state['lng']);
                                        })
                                        // Use the default OSM tile layer to show place names
                                        // ->tilesUrl('https://services.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}')
                                        ->tilesUrl('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png'),

                                ])
                    ])            
        ]);
        
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('location_name')
                    ->sortable()
                    ->searchable()
                    ->label('Location Name'),
                Tables\Columns\TextColumn::make('AppUser.name')
                    ->sortable()
                    ->searchable()
                    ->label('User ID'),
                Tables\Columns\TextColumn::make('latitude')
                    ->sortable()
                    ->searchable()
                    ->label('Latitude'),
                Tables\Columns\TextColumn::make('longitude')
                    ->sortable()
                    ->searchable()
                    ->label('Longitude'),
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
            'index' => Pages\ListLocations::route('/'),
            'create' => Pages\CreateLocation::route('/create'),
            'edit' => Pages\EditLocation::route('/{record}/edit'),
        ];
    }
}
