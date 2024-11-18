<?php

namespace App\Filament\Widgets;

use App\Filament\Resources\UserResource;
use App\Models\AppUser;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Widgets\TableWidget as BaseWidget;

class UserTable extends BaseWidget
{
    protected int | string | array $columnSpan = 'full';
    
    protected static ?int $sort = 2;

    public function table(Table $table): Table
    {
        return $table
            ->query(UserResource::getEloquentQuery())
            ->defaultPaginationPageOption(5)
            ->defaultSort('created_at')
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
            // ->actions([
            //     Tables\Actions\Action::make('open')
            //         ->url(fn (Order $record): string => OrderResource::getUrl('edit', ['record' => $record])),
            // ]);
            ->actions([
                Tables\Actions\Action::make('open')
                    ->url(fn (AppUser $record): string => UserResource::getUrl('edit', ['record' => $record]))
            ]);
    }
}