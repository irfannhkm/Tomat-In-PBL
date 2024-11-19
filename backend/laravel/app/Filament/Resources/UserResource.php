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
use Spatie\Permission\Models\Role;

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
                                    ->label('Full Name')
                                    ->placeholder('John Doe'),
                                Forms\Components\TextInput::make('username')
                                    ->label('Username (Unique)')
                                    ->unique(AppUser::class, 'username', ignoreRecord: true)    
                                    ->placeholder('john_doe')
                                    ->required(fn (string $context): bool => $context === 'create'),
                                Forms\Components\TextInput::make('email')
                                    ->email()
                                    ->required()
                                    ->Label('Email')
                                    ->placeholder('johndoe@example.com'),
                            ]),
                    ]),
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\Section::make('Authentication')
                            ->schema([
                                // Forms\Components\DateTimePicker::make('email_verified_at')
                                //     ->label('Email Verified At'),
                                Forms\Components\Select::make('roles')
                                    ->required()
                                    ->relationship('roles', 'name')
                                    ->preload()
                                    ->label('Role')
                                    ->options(Role::all()->pluck('name', 'id')) // Menampilkan semua role yang tersedia
                                    ->searchable(),
                                Forms\Components\TextInput::make('password')
                                    ->password()
                                    ->label('Password')
                                    ->placeholder('********')
                                    ->dehydrateStateUsing(fn ($state) => Hash::make($state))
                                    ->dehydrated(fn ($state) => filled($state))
                                    ->required(fn (string $context): bool => $context === 'create'),
                            ])
                    ]),
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\Section::make('Profile')
                            ->schema([
                                Forms\Components\FileUpload::make('avatar')
                                    ->label('Image Profile (Avatar)')
                                    ->image()
                                    ->maxSize(1024),
                            ])
                    ])
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\ImageColumn::make('avatar')
                    ->circular()
                    ->label('Image Profile'),
                Tables\Columns\TextColumn::make('username')
                    ->sortable()
                    ->searchable()
                    ->label('Username'),
                Tables\Columns\TextColumn::make('name')
                    ->searchable()
                    ->sortable()
                    ->label('Full Name'),
                Tables\Columns\TextColumn::make('email')
                    ->searchable()
                    ->label('Email'),
                Tables\Columns\TextColumn::make('roles.name') // Menampilkan nama role
                    ->searchable()
                    ->sortable()
                    ->badge()
                    ->label('Role'),
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
            'view' => Pages\ViewUser::route('/{record}'),
        ];
    }
}

