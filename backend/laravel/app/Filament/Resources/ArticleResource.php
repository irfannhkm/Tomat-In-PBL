<?php

namespace App\Filament\Resources;

use App\Filament\Resources\ArticleResource\Pages;
use App\Models\Article;
use Filament\Forms;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;

class ArticleResource extends Resource
{
    protected static ?string $model = Article::class;

    protected static ?string $navigationIcon = 'heroicon-o-document-text';
    protected static ?string $navigationLabel = 'Articles';
    protected static ?string $navigationGroup = 'Content Management';
    protected static ?int $navigationSort = 8;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make()
                ->schema([
                    Forms\Components\TextInput::make('article_title')
                        ->required()
                        ->maxLength(255),
                    Forms\Components\TextInput::make('article_url')
                        ->required(),
                    Forms\Components\Select::make('disease_id')
                        ->relationship('disease', 'disease_name')
                        // ->required(),
                ]),
                Forms\Components\Group::make()
                ->schema([
                    Forms\Components\FileUpload::make('image_cover')
    
                ]),
                Forms\Components\Section::make()
                ->schema([
                    Forms\Components\MarkdownEditor::make('article_content')
                    ->required(),
                ])
                
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('article_title')
                    ->searchable()
                    ->sortable()
                    ->limit(25)
                    ->label('Title/Judul'),
                Tables\Columns\TextColumn::make('article_content')
                    ->searchable()
                    ->sortable()
                    ->limit(25)
                    ->label('Isi Content'),
                Tables\Columns\TextColumn::make('article_url')
                    ->searchable()
                    ->sortable()
                    ->limit(25)
                    ->label('URL Article'),
                Tables\Columns\TextColumn::make('disease.disease_name')
                    ->searchable()
                    ->sortable()
                    ->label('Jenis Penyakit'),
                Tables\Columns\ImageColumn::make('image_cover')
                    ->searchable()
                    ->sortable()
                    ->label('Image Cover'),
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
            'index' => Pages\ListArticles::route('/'),
            'create' => Pages\CreateArticle::route('/create'),
            'edit' => Pages\EditArticle::route('/{record}/edit'),
        ];
    }
}
