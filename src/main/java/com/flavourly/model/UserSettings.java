package com.flavourly.model;
import java.sql.Timestamp;
public class UserSettings{
private int settingId;
private int userId;
private boolean emailNotifications;
private boolean recipeUpdates;
private boolean reviewNotifications;
private String profileVisibility;
private String defaultRecipeView;
private Timestamp createdAt;
private Timestamp updatedAt;
public UserSettings(){}
public int getSettingId(){return settingId;}
public void setSettingId(int settingId){this.settingId=settingId;}
public int getUserId(){return userId;}
public void setUserId(int userId){this.userId=userId;}
public boolean isEmailNotifications(){return emailNotifications;}
public void setEmailNotifications(boolean emailNotifications){this.emailNotifications=emailNotifications;}
public boolean isRecipeUpdates(){return recipeUpdates;}
public void setRecipeUpdates(boolean recipeUpdates){this.recipeUpdates=recipeUpdates;}
public boolean isReviewNotifications(){return reviewNotifications;}
public void setReviewNotifications(boolean reviewNotifications){this.reviewNotifications=reviewNotifications;}
public String getProfileVisibility(){return profileVisibility;}
public void setProfileVisibility(String profileVisibility){this.profileVisibility=profileVisibility;}
public String getDefaultRecipeView(){return defaultRecipeView;}
public void setDefaultRecipeView(String defaultRecipeView){this.defaultRecipeView=defaultRecipeView;}
public Timestamp getCreatedAt(){return createdAt;}
public void setCreatedAt(Timestamp createdAt){this.createdAt=createdAt;}
public Timestamp getUpdatedAt(){return updatedAt;}
public void setUpdatedAt(Timestamp updatedAt){this.updatedAt=updatedAt;}
}