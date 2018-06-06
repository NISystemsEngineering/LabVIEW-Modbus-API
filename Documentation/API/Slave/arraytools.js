
/*********************************************************************
* deleteEmptyStringElements(array)
* Removes empty string elements from an array and returns the cleaned array
*
* Params:
* Name		Type	Description
* array		Array	The array to clean
*
**********************************************************************/

function deleteEmptyStringElements(array) {
   var newArray=new Array;
   var index;
   for(index=0; index<array.length; index++) {
      if(array[index]!='') {
         newArray=newArray.concat(array[index]);
      }
   }
   return newArray;
}

/*********************************************************************
* searchArray(searchArray, searchElement)
* Searches an array for a particular element. Returns true if searchArray
* contains at least one instance of searchElement.
*
* Params:
* Name				Type		Description
* searchArray		Array		The array to search
* searchElement		wildcard	The element to search for
*
**********************************************************************/

function searchArray(searchArray, searchElement) {
	var index;
	for(index=0;index<searchArray.length; index++) {
		if (searchArray[index]==searchElement) return true;
	}
   return false;
}

/*********************************************************************
* addFirstElement(array, element)
* Adds element to array as the first element
*
* Params:
* Name			Type		Description
* array			Array		The array to add element to
* element		wildcard	The element to add
*
**********************************************************************/

function addFirstElement(array, element) {
	var newArray = new Array();
	newArray[0] = element;
	return newArray.concat(array);
}
