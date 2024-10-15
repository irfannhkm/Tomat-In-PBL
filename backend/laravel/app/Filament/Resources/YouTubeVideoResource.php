<?php

namespace App\Filament\Resources;

use App\Filament\Resources\YouTubeVideoResource\Pages;
use App\Models\YouTubeVideo;
use Filament\Forms;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;

class YouTubeVideoResource extends Resource
{
    protected static ?string $model = YouTubeVideo::class;

    protected static ?string $navigationIcon = 'heroicon-o-video-camera';
    protected static ?string $navigationLabel = 'Videos';
    protected static ?string $navigationGroup = 'Content Management';
    protected static ?string $label = 'YouTube Video';
    protected static ?int $navigationSort = 9;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('title')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('url')
                    ->required()
                    ->url()
                    ->maxLength(255)
                    ->label('Video URL'),
                Forms\Components\Textarea::make('description')
                    ->nullable()
                    ->maxLength(500),
                Forms\Components\DateTimePicker::make('published_at')
                    ->label('Publish Date')
                    ->nullable(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('title')
                    ->searchable()
                    ->sortable()
                    ->label('Title'),
                Tables\Columns\TextColumn::make('url')
                    ->limit(50)
                    ->url(fn ($record) => $record->url, true)
                    ->label('URL'),
                Tables\Columns\TextColumn::make('published_at')
                    ->dateTime()
                    ->sortable()
                    ->label('Published At'),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->label('Created At'),
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
            'index' => Pages\ListYouTubeVideos::route('/'),
            'create' => Pages\CreateYouTubeVideo::route('/create'),
            'edit' => Pages\EditYouTubeVideo::route('/{record}/edit'),
        ];
    }
}
