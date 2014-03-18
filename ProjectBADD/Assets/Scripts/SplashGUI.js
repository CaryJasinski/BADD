var splashGUIStuff: GUISkin;
var splashOne : boolean = true;
var splashTwo : boolean = false;
var buttonOne : boolean = true;
var buttonTwo : boolean = true;
var splashPic : Texture2D;
var howtoPlay : Texture2D;

function Start () {

}

function Update () {

}

function OnGUI()
{
 GUI.skin = splashGUIStuff;
 
 
 if (splashOne)
  {
		GUI.Label (Rect (100,100,800,700), splashPic);
  }
  if (splashTwo)
  {
  		GUI.Label (Rect (100,100,800,700), howtoPlay);
  }
		  
	if(buttonOne)
	 {
		if(GUI.Button (Rect (100,500,200,90), "New Game")) 
   	          {
		       Application.LoadLevel(1);
	 	      }
	 }
	 
	 if(buttonTwo)
	 {
		if(GUI.Button (Rect (600,500,200,90), "How To Play")) 
   	          {
   	           splashOne = false;
   	           splashTwo = true;
	 	      }
	 }

 

	
		   
		 
		     
		 
}