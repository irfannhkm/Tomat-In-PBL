<?php

namespace App\Filament\Resources;

use App\Filament\Resources\UserResource\Pages;
use App\Models\AppUser; // Menggunakan model AppUser
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Hash;

class UserResource extends Resource
{
    protected static ?string $model = AppUser::class; // Ubah ke model AppUser

    protected static ?string $navigationIcon = 'heroicon-s-user-group';
    protected static ?string $navigationLabel = 'User';
    protected static ?string $navigationGroup = 'User Management';
    
    protected static ?int $navigationSort = 3;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\Section::make('User Information')
                            ->schema([
                                Forms\Components\TextInput::make('name')
                                    ->required()
                                    ->maxLength(30),
                                Forms\Components\TextInput::make('email')
                                    ->email()
                                    ->required()
                                    ->maxLength(30),
                                Forms\Components\Select::make('role_id')
                                    ->relationship('role', 'role_name') // Menghubungkan ke tabel roles
                                    ->preload()
                                    ->searchable()
                                    ->required(),
                                Forms\Components\FileUpload::make('avatar')
                                    ->label('Avatar')
                                    ->image()
                                    ->maxSize(1024),
                            ]),
                    ]),
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\Section::make('Authentication')
                            ->schema([
                                Forms\Components\DateTimePicker::make('email_verified_at')
                                    ->label('Email Verified At'),
                                Forms\Components\TextInput::make('password')
                                    ->password()
                                    ->maxLength(255)
                                    ->dehydrateStateUsing(fn ($state) => Hash::make($state))
                                    ->dehydrated(fn ($state) => filled($state))
                                    ->required(fn (string $context): bool => $context === 'create'),
                            ])
                    ])
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id') // Menambahkan kolom ID
                    ->sortable()
                    ->label('No'),
                Tables\Columns\ImageColumn::make('avatar')
                    ->circular()
                    ->label('Avatar'),
                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable()
                    ->label('Name'),
                Tables\Columns\TextColumn::make('email')
                    ->searchable()
                    ->label('Email'),
                Tables\Columns\TextColumn::make('role.role_name') // Menampilkan nama role
                    ->searchable()
                    ->sortable()
                    ->label('Role'),
                // Tables\Columns\TextColumn::make('email_verified_at')
                //     ->dateTime()
                //     ->sortable()
                //     ->label('Email Verified At'),
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
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            'edit' => Pages\EditUser::route('/{record}/edit'),
        ];
    }
}

