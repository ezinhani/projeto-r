<?php

use Illuminate\Database\Seeder;
use App\Models\Access\User\User;

class CreateAdminUserSeeder extends Seeder
{

    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {

        $user = User::create([
        	'name' => 'Hardik Savani',
        	'email' => 'admin@gmail.com',
        	'password' => bcrypt('123456')
        ]);

        $user->assignRole('admin');
    }
}
