package com.example.bottomnavigation;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;

import com.google.android.material.bottomnavigation.BottomNavigationView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        //initialize and assign variable
        BottomNavigationView bottomNavigationView=findViewById(R.id.bottom_navigation);

        //set home selected
        bottomNavigationView.setSelectedItemId(R.id.home);

        //perform itemSelectedListener
        bottomNavigationView.setOnNavigationItemSelectedListener(new BottomNavigationView.OnNavigationItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {
                switch (menuItem.getItemId()){
                    case R.id.dashboard:
                        startActivity(new Intent(getApplicationContext()
                        ,Dashboard.class));

                        //overridePendingTransition(int enterAnim: 0,int exitAnim: 0);
                        overridePendingTransition(0,0);
                        return true;

                    case R.id.home:

                        return true;

                    case R.id.search:
                        startActivity(new Intent(getApplicationContext()
                                , Search.class));

                        //overridePendingTransition(int enterAnim: 0,int exitAnim: 0);
                        overridePendingTransition(0,0);
                        return true;

                    case R.id.message:
                        startActivity(new Intent(getApplicationContext()
                                , Message.class));

                        //overridePendingTransition(int enterAnim: 0,int exitAnim: 0);
                        overridePendingTransition(0,0);
                        return true;

                }
                return false;
            }
        });
    }
}
