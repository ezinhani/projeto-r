<?php

use App\Models\Permission\Permission;
use Illuminate\Database\Seeder;
use App\Models\Permission\Role;

class RolesTableSeeder extends Seeder
{

    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $role = Role::create([
            'name' => 'admin'
        ]);
        $role->givePermissionTo(Permission::all());
    }
}
