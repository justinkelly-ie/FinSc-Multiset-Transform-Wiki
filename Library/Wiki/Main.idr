module Wiki.Main

import Stage1.MultisetTree
import Stage1.Polynumber
import Stage1.UnixelFraction
import Stage1.VexelMaxel
import Stage1.Math.LawAlgebra
import System
import Wiki.StreamAdjunctionSpec
import Wiki.MaxelAlgebraSpec
import Wiki.UnixelFractionSpec
import Wiki.MultisetTreeSpec
import Wiki.StatefulLawSpec
import Wiki.ScaleAdjunctionTransformSpec
import Wiki.TwelveLevelTypeTheoryStagingSpec
import Wiki.QuadStreamPassbandSpec
import Wiki.CosmicEpochSubstrateSpec
import Wiki.QuadStreamGohAdjunctionSpec

%default total

printTestResult : String -> Bool -> IO Unit
printTestResult name pass = 
  if pass 
     then putStrLn ("  [TEST] " ++ name ++ ": PASSED ✅")
     else putStrLn ("  [TEST] " ++ name ++ ": FAILED ❌")

main : IO ()
main = do
  putStrLn "========================================================"
  putStrLn "  🗃️ IDRIS2-MULTISET-TRANSFORM: VERIFICATION SUITE 🗃️  "
  putStrLn "========================================================"

  putStrLn "\n--------------------------------------------------------"
  putStrLn "  ⚡ IDRIS2-QUICKCHECK GENERATIVE PROPERTY SUITES ⚡  "
  putStrLn "--------------------------------------------------------"

  p0 <- auditStreamAdjunctionProof
  printTestResult "FreeWave ⊣ ForgetfulMonoid Adjunction & Monad Laws (QuickCheck)" p0

  p1 <- auditMaxelAlgebraProof
  printTestResult "Maxel & Vexel Homomorphic Properties (QuickCheck)" p1

  p2 <- auditUnixelFractionProof
  printTestResult "UnixelFraction Rational Arithmetic & Mediant (QuickCheck)" p2

  p3 <- auditMultisetTreeProof
  printTestResult "O(log N) MultisetTree Invariants (QuickCheck)" p3

  p4 <- auditStatefulLawProof
  printTestResult "UniverseState Capacity & Law Monoid (QuickCheck)" p4

  p5 <- auditScaleMultisetTransformProof
  printTestResult "ScaleFunctor & Multiset Adjunction Dualities (QuickCheck)" p5

  p6 <- auditTwelveLevelTypeTheoryStagingProof
  printTestResult "Generic 12LTT Staging & Goh Factorization (Properties)" p6

  p7 <- auditQuadStreamPassbandProof
  printTestResult "Quad-Stream Multiset Architecture & Cyclotomic Passband Filter (Properties)" p7

  p8 <- auditCosmicEpochSubstrateProof
  printTestResult "Cosmological Epoch Collapse & Substrate Re-hydration (Properties)" p8

  p9 <- auditQuadStreamGohAdjunctionProof
  printTestResult "Goh Prime Factor Adjunction (L_p ⊣ R_p) & Quad-Stream Duality (Properties)" p9

  putStrLn "\n--------------------------------------------------------"
  putStrLn "  🔍 STATIC PROOF WITNESS AUDITS 🔍  "
  putStrLn "--------------------------------------------------------"
  printTestResult "O(log N) MultisetTree Lookup & Insertion" auditMultisetTreeLookupProof
  printTestResult "MultisetTree Token Multiplicity Sum" auditMultisetTreeTokenSumProof
  printTestResult "Canonical BoxSpec Tree Ordering" auditBoxSpecTreeOrderingProof
  printTestResult "Tree Universe State Logarithmic Scaling" auditTreeUniverseScalingProof
  printTestResult "Continued Fraction Reconstruction" auditContinuedFractionProof
  printTestResult "Stern-Brocot Mediant Pathfinding" auditSternBrocotProof
  printTestResult "Hehner Constructivist Scale Conversions" auditHehnerScaleConversionProof
  printTestResult "Multiset Born Rule & Hehner Bit Bag" auditMultisetHehnerTriadProof
  printTestResult "Multiset Compactness & Jaccard Overlap" auditMultisetCompactnessRatioProof
  printTestResult "Law Algebra Monoid & Multiset Adjunction" auditLawAlgebraMonoidProof

  let allQc = p0 && p1 && p2 && p3 && p4 && p5 && p6 && p7 && p8 && p9
  let allAudits = auditMultisetTreeLookupProof && auditMultisetTreeTokenSumProof &&
                  auditBoxSpecTreeOrderingProof && auditTreeUniverseScalingProof &&
                  auditContinuedFractionProof && auditSternBrocotProof &&
                  auditHehnerScaleConversionProof && auditMultisetHehnerTriadProof &&
                  auditMultisetCompactnessRatioProof && auditLawAlgebraMonoidProof


  putStrLn "========================================================"
  if allQc && allAudits
     then putStrLn "  ✨ ALL MULTISET TRANSFORM PROOFS & QUICKCHECK PASSED ✨  "
     else do
       putStrLn "  ❌ SOME VERIFICATION TESTS FAILED ❌  "
       exitWith (ExitFailure 1)
