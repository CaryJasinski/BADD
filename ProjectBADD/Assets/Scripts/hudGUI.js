var hudGUISkin: GUISkin;
var showHUD : boolean = true;
var airIMG : Texture2D;
var oilIMG : Texture2D;

var oilHealth : float = 80;
var airHealth : float = 80;


function Start () {

}

function Update () {

}

function OnGUI()
{
 GUI.skin = hudGUISkin;
}