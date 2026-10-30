document.addEventListener("DOMContentLoaded",function(){
const favoriteSearch=document.getElementById("favoriteSearch");
const favoritesGrid=document.getElementById("favoritesGrid");
const favoritesNoResults=document.getElementById("favoritesNoResults");
if(!favoriteSearch||!favoritesGrid)return;
const favoriteCards=favoritesGrid.querySelectorAll(".favorite-card");
favoriteSearch.addEventListener("input",function(){
const searchValue=this.value.toLowerCase().trim();
let visibleCount=0;
favoriteCards.forEach(card=>{
const recipeName=card.dataset.name||"";
const categoryName=card.dataset.category||"";
const isMatch=recipeName.includes(searchValue)||categoryName.includes(searchValue);
card.style.display=isMatch?"":"none";
if(isMatch){
visibleCount++;
}
});
if(favoritesNoResults){
favoritesNoResults.classList.toggle("active",visibleCount===0);
}
favoritesGrid.style.display=visibleCount===0?"none":"grid";
});
});