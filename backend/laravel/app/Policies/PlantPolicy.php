<?php

namespace App\Policies;

use App\Models\AppUser;
use App\Models\Plant;
use Illuminate\Auth\Access\HandlesAuthorization;

class PlantPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the appUser can view any models.
     */
    public function viewAny(AppUser $appUser): bool
    {
        return $appUser->can('view_any_plant');
    }

    /**
     * Determine whether the appUser can view the model.
     */
    public function view(AppUser $appUser, Plant $plant): bool
    {
        return $appUser->can('view_plant');
    }

    /**
     * Determine whether the appUser can create models.
     */
    public function create(AppUser $appUser): bool
    {
        return $appUser->can('create_plant');
    }

    /**
     * Determine whether the appUser can update the model.
     */
    public function update(AppUser $appUser, Plant $plant): bool
    {
        return $appUser->can('update_plant');
    }

    /**
     * Determine whether the appUser can delete the model.
     */
    public function delete(AppUser $appUser, Plant $plant): bool
    {
        return $appUser->can('delete_plant');
    }

    /**
     * Determine whether the appUser can bulk delete.
     */
    public function deleteAny(AppUser $appUser): bool
    {
        return $appUser->can('delete_any_plant');
    }

    /**
     * Determine whether the appUser can permanently delete.
     */
    public function forceDelete(AppUser $appUser, Plant $plant): bool
    {
        return $appUser->can('force_delete_plant');
    }

    /**
     * Determine whether the appUser can permanently bulk delete.
     */
    public function forceDeleteAny(AppUser $appUser): bool
    {
        return $appUser->can('force_delete_any_plant');
    }

    /**
     * Determine whether the appUser can restore.
     */
    public function restore(AppUser $appUser, Plant $plant): bool
    {
        return $appUser->can('restore_plant');
    }

    /**
     * Determine whether the appUser can bulk restore.
     */
    public function restoreAny(AppUser $appUser): bool
    {
        return $appUser->can('restore_any_plant');
    }

    /**
     * Determine whether the appUser can replicate.
     */
    public function replicate(AppUser $appUser, Plant $plant): bool
    {
        return $appUser->can('replicate_plant');
    }

    /**
     * Determine whether the appUser can reorder.
     */
    public function reorder(AppUser $appUser): bool
    {
        return $appUser->can('reorder_plant');
    }
}
