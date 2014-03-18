var health : float = 3;
var removeHealth : float = 2; 
function Start () 
{

}

function Update () 
{

}

function GetBlockHealth()
{
	return health;
}

function RemoveHealth()
{
	if(health > 0)
	{
		health -= removeHealth;
	}
	else
	{
		GameObject.Destroy(this);
	}
}

