function polyVISelectHandler(selectObj) 
{
   window.location = selectObj.options[selectObj.selectedIndex].value;
   selectObj.selectedIndex = 0; //To put the selector back on "Select an instance"
   window.focus(); //To remove focus from the selector so that using the scroll wheel doesn't change poly VIs
}