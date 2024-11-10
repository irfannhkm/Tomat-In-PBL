<?php

namespace App\Policies;

use App\Models\AppUser;
use Spatie\Permission\Models\Role;
use Illuminate\Auth\Access\HandlesAuthorization;

class RolePolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the appUser can view any models.
     */
    public function viewAny(AppUser $appUser): bool
    {
        return $appUser->can('view_any_role');
    }

    /**
     * Determine whether the appUser can view the model.
     */
    public function view(AppUser $appUser, Role $role): bool
    {
        return $appUser->can('view_role');
    }

    /**
     * Determine whether the appUser can create models.
     */
    public function create(AppUser $appUser): bool
    {
        return $appUser->can('create_role');
    }

    /**
     * Determine whether the appUser can update the model.
     */
    public function update(AppUser $appUser, Role $role): bool
    {
        return $appUser->can('update_role');
    }

    /**
     * Determine whether the appUser can delete the model.
     */
    public function delete(AppUser $appUser, Role $role): bool
    {
        return $appUser->can('delete_role');
    }

    /**
     * Determine whether the appUser can bulk delete.
     */
    public function deleteAny(AppUser $appUser): bool
    {
        return $appUser->can('delete_any_role');
    }

    /**
     * Determine whether the appUser can permanently delete.
     */
    public function forceDelete(AppUser $appUser, Role $role): bool
    {
        return $appUser->can('{{ ForceDelete }}');
    }

    /**
     * Determine whether the appUser can permanently bulk delete.
     */
    public function forceDeleteAny(AppUser $appUser): bool
    {
        return $appUser->can('{{ ForceDeleteAny }}');
    }

    /**
     * Determine whether the appUser can restore.
     */
    public function restore(AppUser $appUser, Role $role): bool
    {
        return $appUser->can('{{ Restore }}');
    }

    /**
     * Determine whether the appUser can bulk restore.
     */
    public function restoreAny(AppUser $appUser): bool
    {
        return $appUser->can('{{ RestoreAny }}');
    }

    /**
     * Determine whether the appUser can replicate.
     */
    public function replicate(AppUser $appUser, Role $role): bool
    {
        return $appUser->can('{{ Replicate }}');
    }

    /**
     * Determine whether the appUser can reorder.
     */
    public function reorder(AppUser $appUser): bool
    {
        return $appUser->can('{{ Reorder }}');
    }
}
