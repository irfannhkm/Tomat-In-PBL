<?php

namespace App\Policies;

use App\Models\AppUser;

use Illuminate\Auth\Access\HandlesAuthorization;

class AppUserPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the appUser can view any models.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function viewAny(AppUser $appUser): bool
    {
        return $appUser->can('view_any_user');
    }

    /**
     * Determine whether the appUser can view the model.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function view(AppUser $appUser): bool
    {
        return $appUser->can('view_user');
    }

    /**
     * Determine whether the appUser can create models.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function create(AppUser $appUser): bool
    {
        return $appUser->can('create_user');
    }

    /**
     * Determine whether the appUser can update the model.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function update(AppUser $appUser): bool
    {
        return $appUser->can('update_user');
    }

    /**
     * Determine whether the appUser can delete the model.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function delete(AppUser $appUser): bool
    {
        return $appUser->can('delete_user');
    }

    /**
     * Determine whether the appUser can bulk delete.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function deleteAny(AppUser $appUser): bool
    {
        return $appUser->can('delete_any_user');
    }

    /**
     * Determine whether the appUser can permanently delete.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function forceDelete(AppUser $appUser): bool
    {
        return $appUser->can('force_delete_user');
    }

    /**
     * Determine whether the appUser can permanently bulk delete.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function forceDeleteAny(AppUser $appUser): bool
    {
        return $appUser->can('force_delete_any_user');
    }

    /**
     * Determine whether the appUser can restore.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function restore(AppUser $appUser): bool
    {
        return $appUser->can('restore_user');
    }

    /**
     * Determine whether the appUser can bulk restore.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function restoreAny(AppUser $appUser): bool
    {
        return $appUser->can('restore_any_user');
    }

    /**
     * Determine whether the appUser can bulk restore.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function replicate(AppUser $appUser): bool
    {
        return $appUser->can('replicate_user');
    }

    /**
     * Determine whether the appUser can reorder.
     *
     * @param  \App\Models\AppUser  $appUser
     * @return bool
     */
    public function reorder(AppUser $appUser): bool
    {
        return $appUser->can('reorder_user');
    }
}
