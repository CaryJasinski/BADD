var splashGUIStuff: GUISkin;
var splashOne : boolean = true;
var endPic : Texture2D;

function Start () {

}

function Update () {

}

function OnGUI()
{
 GUI.skin = splashGUIStuff;
 
 
 if (splashOne)
		 {
		   GUI.Label (Rect (100,100,800,700), endPic);
		       
           if(GUI.Button (Rect (400,500,200,90), "Play Again?")) 
             {
		       Application.LoadLevel(1);
		     }
		   }
		     
		 
}