using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    [SerializeField] private int difficulty;
    public static int staticDifficulty;

    [SerializeField] private GameObject player;
    private static GameObject staticPlayer;

    private void Awake()
    {
        staticDifficulty = difficulty;
        staticPlayer = player;
    }

    public static GameObject GetPlayer()
    {
        return staticPlayer;
    }
}
