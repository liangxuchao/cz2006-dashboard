package com.hellokoding.springboot.view.model;

public class UserModel {
    String Username;
    Integer DentalID;
    String DisplayName;
    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public Integer getDentalID() {
        return DentalID;
    }

    public void setDentalID(Integer dentalID) {
        DentalID = dentalID;
    }

    public String getDisplayName() {
        return DisplayName;
    }

    public void setDisplayName(String displayName) {
        DisplayName = displayName;
    }

}
