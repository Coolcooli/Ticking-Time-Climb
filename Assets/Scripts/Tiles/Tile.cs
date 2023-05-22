using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Tile : MonoBehaviour
{
    [SerializeField] bool _alwaysHasPlatform = false;
    [SerializeField] private GameObject _platform;

    private Tile _tileBeneath;

    [SerializeField] private AnimationCurve _curve;

    private bool _onFire = false;

    private void Awake()
    {
        if (!_alwaysHasPlatform)
            CalculatePlatformProbability();
    }

    private void CalculatePlatformProbability()
    {
        float randomNumber = Random.value;

        if (randomNumber > _curve.Evaluate(GameManager._staticDifficulty))
        {
            _platform.SetActive(false);
        }
    }

    public void SetTileBeneath(Tile tileBeneath)
    {
        this._tileBeneath = tileBeneath;
    }

    public void Shatter()
    {
        _onFire = true;
    }
}
