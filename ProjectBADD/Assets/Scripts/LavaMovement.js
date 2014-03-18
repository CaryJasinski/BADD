#pragma strict

function Start () {

}

var lavaTimer : float = 1;


function Update () 
	{
	lavaTimer -= Time.deltaTime;

	if(lavaTimer <= 0)
	{
	transform.Translate(Vector3(0,1,0) * Time.deltaTime / 1);
	}
}
