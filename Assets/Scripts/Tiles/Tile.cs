using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tile : MonoBehaviour
{
    private bool hasPlatform = true;
    [SerializeField] private GameObject platform;

    private Tile tileBeneath;

    [SerializeField] private AnimationCurve curve;

    private bool onFire = false;

    private void Awake()
    {
        CalculatePlatformProbability();
    }

    private void CalculatePlatformProbability()
    {
        float randomNumber = Random.value;

        if (randomNumber > curve.Evaluate(GameManager.staticDifficulty))
        {
            platform.SetActive(false);
            hasPlatform = false;
        }
    }

    public void SetTileBeneath(Tile tileBeneath)
    {
        this.tileBeneath = tileBeneath;
    }

    public void Shatter()
    {
        onFire = true;
    }
}
