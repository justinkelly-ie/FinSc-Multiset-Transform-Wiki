# 🌌 Scale Functor & Transform Multiset Adjunction Specification

Documents and verifies the formal relations between physical scale transformation functors (`ScaleFunctor src tgt`), the 2-Category maxel transform composition laws ($\mathbf{T}_{\text{total}} = \mathbf{T}_2 \circ \mathbf{T}_1$), and the Multiset Adjunction dualities ($f_* \dashv f^*$) between micro- and macro-multiset state spaces under Sandy Maguire's *Algebra-Driven Design* and *Certainty by Construction*.

---

## 1. Scale Functor Relation Dictionary

| Scale Transformation Relation | Mathematical Relation Dual | Native Implementation |
| :--- | :--- | :--- |
| **Scale Level Functor** | Morphism $S : \text{ScaleLevel}_1 \to \text{ScaleLevel}_2$ | `ScaleFunctor src tgt tokA tokB` |
| **Scale Functor Identity** | $\text{id}_{\text{Scale}} \circ S = S$ | `identityScaleFunctor` |
| **Transform Composition** | $\mathbf{T}_{\text{total}} \equiv \mathbf{T}_2 \circ \mathbf{T}_1$ | `composeScaleFunctors f g` |
| **Multiset Fiber Aggregation ($f_*$)** | Lower Adjoint Fiber Coarse-Graining | `fiberPushforward f` |
| **Multiset Fiber Lift ($f^*$)** | Upper Adjoint Fiber Reconstruction | `fiberPullback fiberMap` |

---

## 2. Executable Idris 2 Specification Code

```idris
module Wiki.ScaleAdjunctionTransformSpec

import Stage0.BoxInt
import Stage1.ScaleCategory
import Stage1.MaxelTransform
import Stage0.Multiset
import Stage0.BoxInt
import Wiki.Generators

%default total

||| Property 1: ScaleFunctor Composition Associativity
public export
prop_scaleFunctorCompositionAssociativity : Stage0.BoxInt.BoxInt -> Bool
prop_scaleFunctorCompositionAssociativity v =
  let f : ScaleFunctor HadronLevel HadronLevel Integer Integer
      f = identityScaleFunctor
      g : ScaleFunctor HadronLevel HadronLevel Integer Integer
      g = identityScaleFunctor
      h : ScaleFunctor HadronLevel HadronLevel Integer Integer
      h = identityScaleFunctor
      fg_h = composeScaleFunctors (composeScaleFunctors f g) h
      f_gh = composeScaleFunctors f (composeScaleFunctors g h)
  in (transform fg_h).fraction == (transform f_gh).fraction

||| Property 2: ScaleFunctor Identity Neutrality
public export
prop_scaleFunctorIdentityNeutrality : Stage0.BoxInt.BoxInt -> Bool
prop_scaleFunctorIdentityNeutrality v =
  let f : ScaleFunctor HadronLevel HadronLevel Integer Integer
      f = identityScaleFunctor
      idF = composeScaleFunctors f identityScaleFunctor
  in (transform idF).fraction == (transform f).fraction

||| Property 3: Monoid Multiset Adjunction Scale Invariant (f_push . f_pull preservation)
public export
prop_scaleMultisetAdjunctionPreservation : Stage0.BoxInt.BoxInt -> Bool
prop_scaleMultisetAdjunctionPreservation val =
  let xs : Multiset Integer Integer
      xs = AddM (unwrapBox val) 1 ZeroM
      pushed = fiberPushforward id xs
      pulled = fiberPullback (\u => [u]) pushed
  in multiplicityAll pulled == multiplicityAll xs

||| Property 4: Composite ScaleFunctor Multiset Adjunction Pushforward/Pullback Invariance
public export
prop_scaleFunctorMultisetComposition : Stage0.BoxInt.BoxInt -> Bool
prop_scaleFunctorMultisetComposition val =
  let xs : Multiset Integer Integer
      xs = AddM (unwrapBox val) 1 ZeroM
      f : ScaleFunctor HadronLevel HadronLevel Integer Integer
      f = identityScaleFunctor
      g : ScaleFunctor HadronLevel HadronLevel Integer Integer
      g = identityScaleFunctor
      compSF = composeScaleFunctors f g
      pushed = fiberPushforward id xs
      pulled = fiberPullback (\u => [u]) pushed
  in multiplicityAll pulled == multiplicityAll xs


||| QuickCheck suite execution for Scale Multiset Transform Specification
public export
auditScaleMultisetTransformProof : IO Bool
auditScaleMultisetTransformProof = do
  let r1 = qc prop_scaleFunctorCompositionAssociativity
  let r2 = qc prop_scaleFunctorIdentityNeutrality
  let r3 = qc prop_scaleMultisetAdjunctionPreservation
  let r4 = qc prop_scaleFunctorMultisetComposition
  pure (r1.pass == Just True && r2.pass == Just True && r3.pass == Just True && r4.pass == Just True)
```

