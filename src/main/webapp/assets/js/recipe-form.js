document.addEventListener("DOMContentLoaded",function(){
const ingredientsContainer=document.getElementById("ingredientsContainer");
const stepsContainer=document.getElementById("stepsContainer");
const addIngredientBtn=document.getElementById("addIngredientBtn");
const addStepBtn=document.getElementById("addStepBtn");
const recipeImageUpload=document.getElementById("recipeImageUpload");
const recipeImageInput=document.getElementById("recipeImage");
const recipeImageUploadContent=document.getElementById("recipeImageUploadContent");
const recipeImagePreview=document.getElementById("recipeImagePreview");
const recipePreviewImage=document.getElementById("recipePreviewImage");
const recipeImageError=document.getElementById("recipeImageError");
const changeImageBtn=document.getElementById("changeImageBtn");
const removeImageBtn=document.getElementById("removeImageBtn");
const maxImageSize=5*1024*1024;
const allowedImageTypes=["image/jpeg","image/png","image/webp"];
const existingImageSrc=recipePreviewImage&&recipeImagePreview.classList.contains("active")?recipePreviewImage.src:null;
function updateIngredientNumbers(){
if(!ingredientsContainer)return;
const rows=ingredientsContainer.querySelectorAll(".ingredient-row");
rows.forEach((row,index)=>{
row.querySelector(".row-number").textContent=index+1;
});
}
function updateStepNumbers(){
if(!stepsContainer)return;
const rows=stepsContainer.querySelectorAll(".step-row");
rows.forEach((row,index)=>{
row.querySelector(".step-number").textContent="Step "+(index+1);
const textarea=row.querySelector("textarea");
textarea.placeholder="Describe cooking step "+(index+1)+"...";
});
}
function createIngredientRow(){
const row=document.createElement("div");
row.className="ingredient-row dynamic-row";
row.innerHTML=`<div class="row-number"></div><div class="dynamic-fields ingredient-fields"><div class="recipe-input-group"><label>Ingredient</label><div class="recipe-input-box"><i class="fa-solid fa-carrot"></i><input type="text" name="ingredientName" placeholder="Example: Paneer" maxlength="150" required></div></div><div class="recipe-input-group"><label>Quantity</label><div class="recipe-input-box"><i class="fa-solid fa-scale-balanced"></i><input type="text" name="quantity" placeholder="Example: 200" maxlength="50"></div></div><div class="recipe-input-group"><label>Unit</label><div class="recipe-input-box"><i class="fa-solid fa-ruler"></i><input type="text" name="unit" placeholder="Example: grams" maxlength="30"></div></div></div><button type="button" class="remove-field-btn remove-ingredient" title="Remove ingredient"><i class="fa-solid fa-trash"></i></button>`;
ingredientsContainer.appendChild(row);
updateIngredientNumbers();
}
function createStepRow(){
const row=document.createElement("div");
row.className="step-row dynamic-row";
row.innerHTML=`<div class="step-number"></div><div class="step-field"><textarea name="instruction" maxlength="2000" required></textarea></div><button type="button" class="remove-field-btn remove-step" title="Remove step"><i class="fa-solid fa-trash"></i></button>`;
stepsContainer.appendChild(row);
updateStepNumbers();
}
function showImageError(message){
if(!recipeImageError)return;
recipeImageError.textContent=message;
recipeImageError.classList.add("active");
}
function clearImageError(){
if(!recipeImageError)return;
recipeImageError.textContent="";
recipeImageError.classList.remove("active");
}
function showSelectedImage(file){
if(!file)return;
clearImageError();
if(!allowedImageTypes.includes(file.type)){
recipeImageInput.value="";
showImageError("Please select a JPG, JPEG, PNG or WEBP image.");
return;
}
if(file.size>maxImageSize){
recipeImageInput.value="";
showImageError("Image size must not exceed 5 MB.");
return;
}
const reader=new FileReader();
reader.onload=function(event){
recipePreviewImage.src=event.target.result;
recipeImagePreview.classList.add("active");
recipeImageUploadContent.classList.add("hidden");
};
reader.readAsDataURL(file);
}
function openImagePicker(event){
if(event)event.stopPropagation();
recipeImageInput.click();
}
if(addIngredientBtn){
addIngredientBtn.addEventListener("click",createIngredientRow);
}
if(addStepBtn){
addStepBtn.addEventListener("click",createStepRow);
}
if(ingredientsContainer){
ingredientsContainer.addEventListener("click",function(event){
const removeButton=event.target.closest(".remove-ingredient");
if(!removeButton)return;
const rows=ingredientsContainer.querySelectorAll(".ingredient-row");
if(rows.length>1){
removeButton.closest(".ingredient-row").remove();
updateIngredientNumbers();
}
});
}
if(stepsContainer){
stepsContainer.addEventListener("click",function(event){
const removeButton=event.target.closest(".remove-step");
if(!removeButton)return;
const rows=stepsContainer.querySelectorAll(".step-row");
if(rows.length>1){
removeButton.closest(".step-row").remove();
updateStepNumbers();
}
});
}
if(recipeImageInput){
recipeImageInput.addEventListener("change",function(){
if(this.files&&this.files[0]){
showSelectedImage(this.files[0]);
}
});
}
if(recipeImageUploadContent){
recipeImageUploadContent.addEventListener("click",openImagePicker);
}
if(changeImageBtn){
changeImageBtn.addEventListener("click",openImagePicker);
}
if(removeImageBtn){
removeImageBtn.addEventListener("click",function(event){
event.stopPropagation();
recipeImageInput.value="";
clearImageError();
if(existingImageSrc){
recipePreviewImage.src=existingImageSrc;
recipeImagePreview.classList.add("active");
recipeImageUploadContent.classList.add("hidden");
}else{
recipePreviewImage.src="";
recipeImagePreview.classList.remove("active");
recipeImageUploadContent.classList.remove("hidden");
}
});
}
if(recipeImageUpload){
["dragenter","dragover"].forEach(eventName=>{
recipeImageUpload.addEventListener(eventName,function(event){
event.preventDefault();
event.stopPropagation();
recipeImageUpload.classList.add("drag-active");
});
});
["dragleave","drop"].forEach(eventName=>{
recipeImageUpload.addEventListener(eventName,function(event){
event.preventDefault();
event.stopPropagation();
recipeImageUpload.classList.remove("drag-active");
});
});
recipeImageUpload.addEventListener("drop",function(event){
const files=event.dataTransfer.files;
if(files&&files[0]){
const dataTransfer=new DataTransfer();
dataTransfer.items.add(files[0]);
recipeImageInput.files=dataTransfer.files;
showSelectedImage(files[0]);
}
});
}
if(existingImageSrc&&recipeImageUploadContent){
recipeImageUploadContent.classList.add("hidden");
}
updateIngredientNumbers();
updateStepNumbers();
});