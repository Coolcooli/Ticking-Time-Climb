using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingManager : Singleton<BuildingManager>
{
    [SerializeField] private Tile tile;

    [SerializeField] private BuildingFloor floorPrefab;

    [SerializeField] private int floorWidth = 6;

    [SerializeField] private int maxPlayerDistance = 5;

    private const float TILE_HEIGHT = .8f;

    private List<BuildingFloor> floors;

    private void Awake()
    {
        floors = new List<BuildingFloor>();

        AddBuildingFloor(-2);
    }

    private void FixedUpdate()
    {
        CheckForNewFloor();
    }

    private void CheckForNewFloor()
    {
        GameObject player = GameManager.GetPlayer();
        BuildingFloor LatestFloor = floors[^1];

        if (Mathf.Abs(player.transform.position.y - LatestFloor.transform.position.y) < maxPlayerDistance)
        {
            AddBuildingFloor(LatestFloor.transform.position.y);
        }
    }

    private void AddBuildingFloor(float previousPosition)
    {
        BuildingFloor floor = Instantiate(floorPrefab);
        floor.transform.parent = transform;
        floor.transform.position = new Vector2(0, TILE_HEIGHT + previousPosition);
        floor.InitializeFloor(tile, floorWidth);
        floors.Add(floor);
    }
}
