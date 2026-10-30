document.addEventListener("DOMContentLoaded",function(){
const recipeSearch=document.getElementById("recipeSearch");
const difficultyFilter=document.getElementById("difficultyFilter");
const recipesGrid=document.getElementById("recipesGrid");
const recipesNoResults=document.getElementById("recipesNoResults");
const deleteForms=document.querySelectorAll(".delete-recipe-form");
function filterRecipes(){
if(!recipesGrid)return;
const searchValue=recipeSearch?recipeSearch.value.toLowerCase().trim():"";
const difficultyValue=difficultyFilter?difficultyFilter.value.toLowerCase():"all";
const recipeCards=recipesGrid.querySelectorAll(".recipe-card");
let visibleRecipes=0;
recipeCards.forEach(card=>{
const recipeName=card.dataset.name||"";
const recipeDifficulty=card.dataset.difficulty||"";
const matchesSearch=recipeName.includes(searchValue);
const matchesDifficulty=difficultyValue==="all"||recipeDifficulty===difficultyValue;
if(matchesSearch&&matchesDifficulty){
card.style.display="";
visibleRecipes++;
}else{
card.style.display="none";
}
});
if(recipesNoResults){
recipesNoResults.style.display=visibleRecipes===0?"flex":"none";
}
}
if(recipeSearch){
recipeSearch.addEventListener("input",filterRecipes);
}
if(difficultyFilter){
difficultyFilter.addEventListener("change",filterRecipes);
}
deleteForms.forEach(form=>{
form.addEventListener("submit",function(event){
const confirmed=window.confirm("Are you sure you want to delete this recipe? This action cannot be undone.");
if(!confirmed){
event.preventDefault();
}
});
});
});