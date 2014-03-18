#pragma strict

function Start () {

}

function Update () 
{
if(Input.anyKey == false)
{
gameObject.rigidbody.velocity = Vector3.zero;
}
if(Input.GetKey("up"))
{
transform.Translate(Vector3(0,5,0) * Time.deltaTime);
}
if(Input.GetKey("down"))
{
transform.Translate(Vector3(0,-5,0) * Time.deltaTime);
}
if(Input.GetKey("right"))
{
transform.Translate(Vector3(0,0,5) * Time.deltaTime);
}
if(Input.GetKey("left"))
{
transform.Translate(Vector3(0,0,-5) * Time.deltaTime);
}
}