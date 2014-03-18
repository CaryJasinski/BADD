var splashGUIStuff: GUISkin;
var endScreenShow : boolean = true;
var endPicture : Texture2D;

function Start () {

}

function Update () {

}

function OnGUI()
{
 GUI.skin = splashGUIStuff;
 
 
 if (endScreenShow)
		 {
		   GUI.Label (Rect (100,100,800,700), endPicture);
		       
           if(GUI.Button (Rect (400,500,200,90), "Try Again?")) 
             {
		       Application.LoadLevel(1);
		     }
		 }
}