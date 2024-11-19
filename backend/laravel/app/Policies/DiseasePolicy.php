<?php

namespace App\Policies;

use App\Models\AppUser;
use App\Models\Disease;
use Illuminate\Auth\Access\HandlesAuthorization;

class DiseasePolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the appUser can view any models.
     */
    public function viewAny(AppUser $appUser): bool
    {
        return $appUser->can('view_any_disease');
    }

    /**
     * Determine whether the appUser can view the model.
     */
    public function view(AppUser $appUser, Disease $disease): bool
    {
        return $appUser->can('view_disease');
    }

    /**
     * Determine whether the appUser can create models.
     */
    public function create(AppUser $appUser): bool
    {
        return $appUser->can('create_disease');
    }

    /**
     * Determine whether the appUser can update the model.
     */
    public function update(AppUser $appUser, Disease $disease): bool
    {
        return $appUser->can('update_disease');
    }

    /**
     * Determine whether the appUser can delete the model.
     */
    public function delete(AppUser $appUser, Disease $disease): bool
    {
        return $appUser->can('delete_disease');
    }

    /**
     * Determine whether the appUser can bulk delete.
     */
    public function deleteAny(AppUser $appUser): bool
    {
        return $appUser->can('delete_any_disease');
    }

    /**
     * Determine whether the appUser can permanently delete.
     */
    public function forceDelete(AppUser $appUser, Disease $disease): bool
    {
        return $appUser->can('force_delete_disease');
    }

    /**
     * Determine whether the appUser can permanently bulk delete.
     */
    public function forceDeleteAny(AppUser $appUser): bool
    {
        return $appUser->can('force_delete_any_disease');
    }

    /**
     * Determine whether the appUser can restore.
     */
    public function restore(AppUser $appUser, Disease $disease): bool
    {
        return $appUser->can('restore_disease');
    }

    /**
     * Determine whether the appUser can bulk restore.
     */
    public function restoreAny(AppUser $appUser): bool
    {
        return $appUser->can('restore_any_disease');
    }

    /**
     * Determine whether the appUser can replicate.
     */
    public function replicate(AppUser $appUser, Disease $disease): bool
    {
        return $appUser->can('replicate_disease');
    }

    /**
     * Determine whether the appUser can reorder.
     */
    public function reorder(AppUser $appUser): bool
    {
        return $appUser->can('reorder_disease');
    }
}
