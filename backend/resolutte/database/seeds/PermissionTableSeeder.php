<?php

use Illuminate\Database\Seeder;
use App\Models\Permission\Permission;

class PermissionTableSeeder extends Seeder
{

    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        // Reset cached roles and permissions
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        $permissions = [
           'role-list',
           'role-create',
           'role-edit',
           'role-delete',
           'product-list',
           'product-create',
           'product-edit',
           'product-delete'
        ];


        foreach ($permissions as $permission) {
             Permission::create([
                 'name' => $permission
             ]);
        }
    }
}
