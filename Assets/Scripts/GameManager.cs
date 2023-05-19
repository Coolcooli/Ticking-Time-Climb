using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    [SerializeField] private int diff;
    public static int difficulty;

    private void Awake()
    {
        difficulty = diff;
    }
}
