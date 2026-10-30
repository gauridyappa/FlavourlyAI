package com.flavourly.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import com.flavourly.model.User;
import com.flavourly.util.DBConnection;
public class UserDAO {
public boolean registerUser(User user){
String sql="INSERT INTO users(full_name,email,phone,password,profile_image,bio,role,account_status) VALUES(?,?,?,?,?,?,?,?)";
try(Connection connection=DBConnection.getConnection();
PreparedStatement ps=connection.prepareStatement(sql)){
ps.setString(1,user.getFullName());
ps.setString(2,user.getEmail());
ps.setString(3,user.getPhone());
ps.setString(4,user.getPassword());
ps.setString(5,user.getProfileImage());
ps.setString(6,user.getBio());
ps.setString(7,user.getRole());
ps.setString(8,user.getAccountStatus());
return ps.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
return false;
}
}
public User loginUser(String email,String password){
String sql="SELECT * FROM users WHERE email=? AND password=? AND account_status='ACTIVE'";
try(Connection connection=DBConnection.getConnection();
PreparedStatement ps=connection.prepareStatement(sql)){
ps.setString(1,email);
ps.setString(2,password);
try(ResultSet rs=ps.executeQuery()){
if(rs.next()){
User user=new User();
user.setUserId(rs.getInt("user_id"));
user.setFullName(rs.getString("full_name"));
user.setEmail(rs.getString("email"));
user.setPhone(rs.getString("phone"));
user.setPassword(rs.getString("password"));
user.setProfileImage(rs.getString("profile_image"));
user.setBio(rs.getString("bio"));
user.setRole(rs.getString("role"));
user.setAccountStatus(rs.getString("account_status"));
user.setCreatedAt(rs.getTimestamp("created_at"));
user.setLastLogin(rs.getTimestamp("last_login"));
updateLastLogin(user.getUserId());
return user;
}
}
}catch(Exception e){
e.printStackTrace();
}
return null;
}
public boolean emailExists(String email){
String sql="SELECT COUNT(*) FROM users WHERE email=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement ps=connection.prepareStatement(sql)){
ps.setString(1,email);
try(ResultSet rs=ps.executeQuery()){
if(rs.next()){
return rs.getInt(1)>0;
}
}
}catch(Exception e){
e.printStackTrace();
}
return false;
}
private void updateLastLogin(int userId){
String sql="UPDATE users SET last_login=? WHERE user_id=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement ps=connection.prepareStatement(sql)){
ps.setTimestamp(1,new Timestamp(System.currentTimeMillis()));
ps.setInt(2,userId);
ps.executeUpdate();
}catch(Exception e){
e.printStackTrace();
}
}
public User getUserById(int userId){
String sql="SELECT * FROM users WHERE user_id=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement ps=connection.prepareStatement(sql)){
ps.setInt(1,userId);
try(ResultSet rs=ps.executeQuery()){
if(rs.next()){
User user=new User();
user.setUserId(rs.getInt("user_id"));
user.setFullName(rs.getString("full_name"));
user.setEmail(rs.getString("email"));
user.setPhone(rs.getString("phone"));
user.setPassword(rs.getString("password"));
user.setProfileImage(rs.getString("profile_image"));
user.setBio(rs.getString("bio"));
user.setRole(rs.getString("role"));
user.setAccountStatus(rs.getString("account_status"));
user.setCreatedAt(rs.getTimestamp("created_at"));
user.setLastLogin(rs.getTimestamp("last_login"));
return user;
}
}
}catch(Exception e){
e.printStackTrace();
}
return null;
}

public boolean updateProfile(User user){
String sql="UPDATE users SET full_name=?,phone=?,bio=? WHERE user_id=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement ps=connection.prepareStatement(sql)){
ps.setString(1,user.getFullName());
ps.setString(2,user.getPhone());
ps.setString(3,user.getBio());
ps.setInt(4,user.getUserId());
return ps.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
}
return false;
}
public boolean verifyCurrentPassword(int userId,String currentPassword){
String sql="SELECT user_id FROM users WHERE user_id=? AND password=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement ps=connection.prepareStatement(sql)){
ps.setInt(1,userId);
ps.setString(2,currentPassword);
try(ResultSet rs=ps.executeQuery()){
return rs.next();
}
}catch(Exception e){
e.printStackTrace();
}
return false;
}

public boolean updatePassword(int userId,String newPassword){
String sql="UPDATE users SET password=? WHERE user_id=?";
try(Connection connection=DBConnection.getConnection();
PreparedStatement ps=connection.prepareStatement(sql)){
ps.setString(1,newPassword);
ps.setInt(2,userId);
return ps.executeUpdate()>0;
}catch(Exception e){
e.printStackTrace();
}
return false;
}
}