<?php

namespace App\Filament\Resources;

use App\Filament\Resources\RoleResource\Pages;
use App\Models\Role;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class RoleResource extends Resource
{
    // Gunakan model Role
    protected static ?string $model = Role::class;

    // Ikon navigasi untuk Role
    protected static ?string $navigationIcon = 'heroicon-s-shield-check';
    protected static ?string $navigationLabel = 'Role';
    protected static ?string $navigationGroup = 'User Management';

    // Urutan navigasi
    protected static ?int $navigationSort = 2;

    // Form untuk input Role
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Group::make()
                    ->schema([
                        Forms\Components\TextInput::make('role_name')
                            ->required()
                            ->maxLength(50)
                            ->label('Role Name'), // Nama Role
                    ]),
            ]);
    }

    // Tabel untuk menampilkan Role
    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('Role ID') // Menampilkan ID Role
                    ->sortable(), // Dapat diurutkan
                Tables\Columns\TextColumn::make('role_name')
                    ->searchable()
                    ->label('Role Name'), // Nama Role
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->label('Created At'), // Tanggal pembuatan
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->label('Updated At'), // Tanggal pembaruan
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

    // Halaman untuk Role
    public static function getPages(): array
    {
        return [
            'index' => Pages\ListRoles::route('/'),
            'create' => Pages\CreateRole::route('/create'),
            'edit' => Pages\EditRole::route('/{record}/edit'),
        ];
    }
}
