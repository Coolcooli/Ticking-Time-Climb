using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    [SerializeField] private int _difficulty;
    public static int _staticDifficulty;

    [SerializeField] private GameObject _player;
    private static GameObject _staticPlayer;

    private void Awake()
    {
        _staticDifficulty = _difficulty;
        _staticPlayer = _player;
    }

    public static GameObject GetPlayer()
    {
        return _staticPlayer;
    }
}
