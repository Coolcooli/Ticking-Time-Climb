using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Explosion : MonoBehaviour
{
    public UnityEvent animationHasFinished;

    private Animator animator;

    private bool _isAnimating = false;

    private void Awake()
    {
        animator = GetComponent<Animator>();
    }

    private void FixedUpdate()
    {
        if (animator.GetCurrentAnimatorStateInfo(0).IsName("isExploding") && _isAnimating)
        {

        }
    }

    private void SetPositionAndScale(Vector2 position, Vector3 scale)
    {
        transform.position = position;
        transform.localScale = scale;
    }

    public void StartExplosion(Vector2 position, Vector3 scale)
    {
        SetPositionAndScale(position, scale);
        _isAnimating = true;
        animator.SetBool("isExploding", _isAnimating);
    }
}
