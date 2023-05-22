using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BuildingManager : Singleton<BuildingManager>
{
    [SerializeField] private Tile _tile;

    [SerializeField] private BuildingFloor _floorPrefab;

    [SerializeField] private int _floorWidth = 6;

    [SerializeField] private int _maxPlayerDistance = 5;

    private const float TILE_HEIGHT = .8f;
    private const float INITIAL_BUILDING_HEIGHT = 9;

    private List<BuildingFloor> _floors;

    private void Awake()
    {
        _floors = new List<BuildingFloor>();

        AddBuildingFloor(-1, false);

        for (int i = 0; i < INITIAL_BUILDING_HEIGHT; i++)
        {
            AddBuildingFloor(_floors[^1].transform.position.y, false);
        }
    }

    private void FixedUpdate()
    {
        CheckForNewFloor();
    }

    private void CheckForNewFloor()
    {
        GameObject player = GameManager.GetPlayer();
        BuildingFloor LatestFloor = _floors[^1];

        if (Mathf.Abs(player.transform.position.y - LatestFloor.transform.position.y) < _maxPlayerDistance)
        {
            AddBuildingFloor(LatestFloor.transform.position.y);
        }
    }

    private void AddBuildingFloor(float previousPosition, bool removeOldFloor = true)
    {
        BuildingFloor floor = Instantiate(_floorPrefab);
        floor.transform.parent = transform;
        floor.transform.position = new Vector2(0, TILE_HEIGHT + previousPosition);
        floor.InitializeFloor(_tile, _floorWidth);
        _floors.Add(floor);

        if (removeOldFloor)
            RemoveOldestFloor();
    }

    private void RemoveOldestFloor()
    {
        BuildingFloor floorToRemove = _floors[0];
        _floors.RemoveAt(0);
        Destroy(floorToRemove.gameObject);
    }
}
