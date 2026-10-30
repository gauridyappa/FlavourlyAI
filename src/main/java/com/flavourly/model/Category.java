package com.flavourly.model;
import java.sql.Timestamp;
public class Category {
private int categoryId;
private String categoryName;
private String description;
private String categoryImage;
private Timestamp createdAt;
public Category(){}
public Category(int categoryId,String categoryName,String description,String categoryImage){
this.categoryId=categoryId;
this.categoryName=categoryName;
this.description=description;
this.categoryImage=categoryImage;
}
public int getCategoryId(){
return categoryId;
}
public void setCategoryId(int categoryId){
this.categoryId=categoryId;
}
public String getCategoryName(){
return categoryName;
}
public void setCategoryName(String categoryName){
this.categoryName=categoryName;
}
public String getDescription(){
return description;
}
public void setDescription(String description){
this.description=description;
}
public String getCategoryImage(){
return categoryImage;
}
public void setCategoryImage(String categoryImage){
this.categoryImage=categoryImage;
}
public Timestamp getCreatedAt(){
return createdAt;
}
public void setCreatedAt(Timestamp createdAt){
this.createdAt=createdAt;
}
}