package com.hellokoding.springboot.view.model;

/**
 * Store User info after login
 */
public class UserModel {

    String Username;


    Integer UserID;
    Integer VetID;
    String DisplayName;

    public Integer getUserID() {
        return UserID;
    }

    public void setUserID(Integer userID) {
        UserID = userID;
    }
    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public Integer getVetID() {
        return VetID;
    }

    public void setVetID(Integer vetID) {
        VetID = vetID;
    }

    public String getDisplayName() {
        return DisplayName;
    }

    public void setDisplayName(String displayName) {
        DisplayName = displayName;
    }

}
