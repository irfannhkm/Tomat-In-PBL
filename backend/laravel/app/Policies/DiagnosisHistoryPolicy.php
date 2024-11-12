<?php

namespace App\Policies;

use App\Models\AppUser;
use App\Models\DiagnosisHistory;
use Illuminate\Auth\Access\HandlesAuthorization;

class DiagnosisHistoryPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the appUser can view any models.
     */
    public function viewAny(AppUser $appUser): bool
    {
        return $appUser->can('view_any_diagnosis::history');
    }

    /**
     * Determine whether the appUser can view the model.
     */
    public function view(AppUser $appUser, DiagnosisHistory $diagnosisHistory): bool
    {
        return $appUser->can('view_diagnosis::history');
    }

    /**
     * Determine whether the appUser can create models.
     */
    public function create(AppUser $appUser): bool
    {
        return $appUser->can('create_diagnosis::history');
    }

    /**
     * Determine whether the appUser can update the model.
     */
    public function update(AppUser $appUser, DiagnosisHistory $diagnosisHistory): bool
    {
        return $appUser->can('update_diagnosis::history');
    }

    /**
     * Determine whether the appUser can delete the model.
     */
    public function delete(AppUser $appUser, DiagnosisHistory $diagnosisHistory): bool
    {
        return $appUser->can('delete_diagnosis::history');
    }

    /**
     * Determine whether the appUser can bulk delete.
     */
    public function deleteAny(AppUser $appUser): bool
    {
        return $appUser->can('delete_any_diagnosis::history');
    }

    /**
     * Determine whether the appUser can permanently delete.
     */
    public function forceDelete(AppUser $appUser, DiagnosisHistory $diagnosisHistory): bool
    {
        return $appUser->can('force_delete_diagnosis::history');
    }

    /**
     * Determine whether the appUser can permanently bulk delete.
     */
    public function forceDeleteAny(AppUser $appUser): bool
    {
        return $appUser->can('force_delete_any_diagnosis::history');
    }

    /**
     * Determine whether the appUser can restore.
     */
    public function restore(AppUser $appUser, DiagnosisHistory $diagnosisHistory): bool
    {
        return $appUser->can('restore_diagnosis::history');
    }

    /**
     * Determine whether the appUser can bulk restore.
     */
    public function restoreAny(AppUser $appUser): bool
    {
        return $appUser->can('restore_any_diagnosis::history');
    }

    /**
     * Determine whether the appUser can replicate.
     */
    public function replicate(AppUser $appUser, DiagnosisHistory $diagnosisHistory): bool
    {
        return $appUser->can('replicate_diagnosis::history');
    }

    /**
     * Determine whether the appUser can reorder.
     */
    public function reorder(AppUser $appUser): bool
    {
        return $appUser->can('reorder_diagnosis::history');
    }
}
