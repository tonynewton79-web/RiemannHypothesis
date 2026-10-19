import Mathlib

/-!
# Kernel-checked rational jet recursion

For s(t) = Σ aₖ tᵏ, the degree-k coefficient of
T(s) = (s')² - s*s'' is the convolution coded here.
This file checks exact rational arithmetic for a 12-decimal
Taylor-jet approximation. It is **not** by itself a theorem about
the genuine theta series: rigorous coefficient enclosures and
interval-soundness need a separate analytic/Lean bridge.
-/

namespace XiKernel

def jetCoeff (a : List ℚ) (k : ℕ) : ℚ :=
  (a[k]?).getD 0

def jetStep (a : List ℚ) : List ℚ :=
  (List.range (a.length - 2)).map fun k =>
    (List.range (k + 1)).foldl (fun acc i =>
      let j := k - i
      acc
        + ((i + 1 : ℕ) : ℚ) * ((j + 1 : ℕ) : ℚ) *
          jetCoeff a (i + 1) * jetCoeff a (j + 1)
        - ((j + 1 : ℕ) : ℚ) * ((j + 2 : ℕ) : ℚ) *
          jetCoeff a i * jetCoeff a (j + 2)
    ) 0

/-- Numerators of the 12-decimal rational approximants to
the first eleven theta-kernel Taylor coefficients. -/
def jetApprox : List ℚ :=
  ([446696900467,
    -16730500774704,
    270720944485141,
    -2254921151385263,
    5788367582106794,
    92543044213073323,
    -1476047241742765808,
    13455626539085734237,
    -106203604539334108017,
    842450837277601011206,
    -6605516223786828265570] : List ℚ).map
      (fun x => x / 1000000000000)

def jet5 : List ℚ :=
  jetStep (jetStep (jetStep (jetStep (jetStep jetApprox))))

theorem rational_jet_fifth_negative :
    jetCoeff jet5 0 < 0 := by
  native_decide

end XiKernel
