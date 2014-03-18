//GUI
var hudGUISkin: GUISkin;
var showHUD : boolean = true;
var levelTimer : float = 25;

//BADD
var hullHealth : float = 999;
var oilHealth : float = 999;
var oilExpended : float = 1;
var spendOilTimer : float = 0.65;

//Oil Regen
var oilRegenTimer : float = 0.8;
var oilRegenCount : float = 0;
var oilRegenCountMax : int = 100; 
var oilRegenCountBonus : int = 50;
var oilRegenAmount : float = 1;

//Buffs
var buff : int = 0; //0-No Buff 1-Super Drill 2-????? 3-?????
var superDrillTimer : float = 4;
 
//Sound
var blockBreakSound : AudioSource;
var drillSound : AudioSource;

//Score
var currentScore : int = 0;

var collisionBlockHp;

function Start()
{

}

function Update () 
{
	levelTimer -= Time.deltaTime;
	
	if(hullHealth <= 0)
	{	
		Application.LoadLevel(2);
	}	
	if(hullHealth > 9)
	{
		hullHealth = 9;
	}
	if(oilHealth < 0)
	{	
		oilHealth = 0;
	}
	if(oilHealth > 10) 
	{	
		oilHealth = 10;
	}
	if(oilHealth >= 0 && oilHealth < 10)
	{
		oilRegenTimer -= Time.deltaTime;
		OilRegen();
	}
	if(oilRegenCount >= oilRegenCountMax)
	{
		oilHealth += oilRegenAmount;
		oilRegenCount = 0;
	}
	if(buff == 0)
	{
		superDrillTimer = 4;
	}
	if(buff == 1)
	{	
		SuperDrill();
	}
	if(currentScore <=0)
	{	
		currentScore = 0;
	}
}

function OnCollisionStay(collision : Collision)
{		
	if(collision.gameObject.tag == "Block0")
	{
		collisionBlockHp = collision.gameObject.GetComponent(BlockHealth);
		
		BreakBlock(collisionBlockHp);
		if(collisionBlockHp.health <= 0)
		{
			Destroy(collision.gameObject);
			ChangeScore(10);
		}
	}
	if(collision.gameObject.tag == "Block1")
	{
		collisionBlockHp = collision.gameObject.GetComponent(BlockHealth);
		
		BreakBlock(collisionBlockHp);
		if(collisionBlockHp.health <= 0)
		{
			Destroy(collision.gameObject);
			ChangeScore(25);
		}
	}
	if(collision.gameObject.tag == "Block2")
	{
		collisionBlockHp = collision.gameObject.GetComponent(BlockHealth);
		
		BreakBlock(collisionBlockHp);
		if(collisionBlockHp.health <= 0)
		{
			Destroy(collision.gameObject);
			ChangeScore(75);
		}
	}
	if(collision.gameObject.tag == "Block3")
	{
		collisionBlockHp = collision.gameObject.GetComponent(BlockHealth);
		
		BreakBlock(collisionBlockHp);
		if(collisionBlockHp.health <= 0)
		{
			Destroy(collision.gameObject);
			ChangeScore(150);
		}
	}
}

function BreakBlock(blockHp)
{		
	spendOilTimer -= Time.deltaTime;
	if(spendOilTimer <= 0)
	{
		blockHp.RemoveHealth();
		//Debug.Log("It made it!");
		//drillSound.Play();
		//blockBreakSound.Play();
		if(oilHealth > 0)
		{
			Debug.Log(oilExpended);
	    	oilHealth -= oilExpended;
	    } 
	    else 
	    {
	    	hullHealth -= 1;
	    }
		spendOilTimer = 0.65;
	}
}
function OilRegen()
{
	if(oilRegenTimer <= 0)
	{
		oilRegenCount += oilRegenCountBonus;
		oilRegenTimer = 0.8;
	}
}
function SuperDrill()
{
	if(superDrillTimer == 4)
	{
		spendOilTimer = 0.3;
		oilExpended = 0.5;
		superDrillTimer -= Time.deltaTime;
	}
	else
	{
		superDrillTimer -= Time.deltaTime;
		Debug.Log(oilExpended);
		if(superDrillTimer < 0)
		{
			spendOilTimer = 0.65;
			oilExpended = 1;
			buff = 0;
		}
	}
}
function ChangeScore(blockPoints)
{
	currentScore += blockPoints;
}

function OnCollisionExit(collision : Collision)
{
	spendOilTimer = 0.65;
}

function OnTriggerEnter(other : Collider)
{
	var delayDamage : float;
	if(other.tag=="oilBlock")
	{
		buff = 1;
		Destroy(other.gameObject);
 	}
 	if(other.gameObject.tag=="lava")
 	{
 		hullHealth = 0;
	}
	if(other.gameObject.tag=="end")
	{
 		 Application.LoadLevel(3);
	}
}

function OnGUI()
{
 	GUI.skin = hudGUISkin;
  	if (showHUD)
	{
		// GUI.Label (Rect (110,10,100,100), oilIMG);
		GUI.Box (Rect (5, 20, 100, 25), "Oil Health"); 
		GUI.Box (Rect (10, 40, 50, 25), ""+ oilHealth + "");
		GUI.Box (Rect (110, 20, 100, 25), "Hull Health");
		GUI.Box (Rect (125, 50, 70, 40), ""+ hullHealth + "");
		GUI.Box (Rect (210, 20, 100, 25), "Time");
		GUI.Box (Rect (230, 40, 60, 25), ""+ levelTimer + "");
		GUI.Box (Rect (540, 20, 100, 25), "SCORE");
		GUI.Box (Rect (550, 40, 60, 25), ""+ currentScore + "");         
	}
}