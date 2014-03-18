using UnityEngine;
using System.Collections;

public class Explosion : MonoBehaviour 
{

	// Use this for initialization
	void Start () 
	{
	
	}
	
	public float radius = 3.0f;
	public float ExplosionTimer = 4.0f;
	bool startExplosion = false;
	
	// Update is called once per frame
	void Update () 
	{
		if(startExplosion == true)
		{
			ExplosionTimer -= Time.deltaTime;
			if(ExplosionTimer <= 0)
			{
				Explode();
			}
		}
	}
	void OnCollisionEnter(Collision collision)
	{
		if(collision.gameObject.tag == "Player")
		{
			startExplosion = true;
		}
	}
	void Explode()
	{
		Collider[] colliders = Physics.OverlapSphere(this.gameObject.transform.position, radius);
		foreach (Collider col in colliders)
      	{

	        if (col.tag == "Block0")
			{
				Destroy(col.gameObject);
			}
			else if (col.tag == "Block1")
			{
				Destroy(col.gameObject);
			}
			else if (col.tag == "Block2")
			{
				Destroy(col.gameObject);
			}
			else if (col.tag == "Block3")
			{
				Destroy(col.gameObject);
			}
			else if (col.tag == "Block4")
			{
				Destroy(col.gameObject);
			}
			else if (col.tag == "Block5")
			{
				Destroy(col.gameObject);
			}
			Destroy (gameObject);
		}
	}
}
