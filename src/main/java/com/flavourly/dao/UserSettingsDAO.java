package com.flavourly.dao;
import com.flavourly.model.UserSettings;
import com.flavourly.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class UserSettingsDAO{
public UserSettings getSettingsByUser(int userId){
String sql="SELECT * FROM user_settings WHERE user_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
try(ResultSet resultSet=statement.executeQuery()){
if(resultSet.next())return mapSettings(resultSet);
}
}catch(Exception e){
e.printStackTrace();
}
return createDefaultSettings(userId);
}
public UserSettings createDefaultSettings(int userId){
String sql="INSERT IGNORE INTO user_settings(user_id) VALUES(?)";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
statement.executeUpdate();
}catch(Exception e){
e.printStackTrace();
}
return getExistingSettings(userId);
}
private UserSettings getExistingSettings(int userId){
String sql="SELECT * FROM user_settings WHERE user_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setInt(1,userId);
try(ResultSet resultSet=statement.executeQuery()){
if(resultSet.next())return mapSettings(resultSet);
}
}catch(Exception e){
e.printStackTrace();
}
return null;
}
public boolean updateSettings(UserSettings settings){
String sql="UPDATE user_settings SET email_notifications=?,recipe_updates=?,review_notifications=?,profile_visibility=?,default_recipe_view=? WHERE user_id=?";
try(Connection connection=DBConnection.getConnection();PreparedStatement statement=connection.prepareStatement(sql)){
statement.setBoolean(1,settings.isEmailNotifications());
statement.setBoolean(2,settings.isRecipeUpdates());
statement.setBoolean(3,settings.isReviewNotifications());
statement.setString(4,settings.getProfileVisibility());
statement.setString(5,settings.getDefaultRecipeView());
statement.setInt(6,settings.getUserId());
return statement.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
return false;
}
}
private UserSettings mapSettings(ResultSet resultSet)throws Exception{
UserSettings settings=new UserSettings();
settings.setSettingId(resultSet.getInt("setting_id"));
settings.setUserId(resultSet.getInt("user_id"));
settings.setEmailNotifications(resultSet.getBoolean("email_notifications"));
settings.setRecipeUpdates(resultSet.getBoolean("recipe_updates"));
settings.setReviewNotifications(resultSet.getBoolean("review_notifications"));
settings.setProfileVisibility(resultSet.getString("profile_visibility"));
settings.setDefaultRecipeView(resultSet.getString("default_recipe_view"));
settings.setCreatedAt(resultSet.getTimestamp("created_at"));
settings.setUpdatedAt(resultSet.getTimestamp("updated_at"));
return settings;
}
}