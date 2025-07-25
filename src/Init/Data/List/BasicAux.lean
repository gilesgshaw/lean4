/-
Copyright (c) 2019 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Author: Leonardo de Moura
-/
module

prelude
public import Init.Data.Nat.Linear

public section

set_option linter.listVariables true -- Enforce naming conventions for `List`/`Array`/`Vector` variables.
set_option linter.indexVariables true -- Enforce naming conventions for index variables.

universe u

namespace List
/-! The following functions can't be defined at `Init.Data.List.Basic`, because they depend on `Init.Util`,
   and `Init.Util` depends on `Init.Data.List.Basic`. -/

/-! ## Alternative getters -/

/-! ### get? -/

/--
Returns the `i`-th element in the list (zero-based).

If the index is out of bounds (`i ≥ as.length`), this function returns `none`.
Also see `get`, `getD` and `get!`.
-/
@[deprecated "Use `a[i]?` instead." (since := "2025-02-12"), expose]
def get? : (as : List α) → (i : Nat) → Option α
  | a::_,  0   => some a
  | _::as, n+1 => get? as n
  | _,     _   => none

set_option linter.deprecated false in
@[deprecated "Use `a[i]?` instead." (since := "2025-02-12"), simp]
theorem get?_nil : @get? α [] n = none := rfl
set_option linter.deprecated false in
@[deprecated "Use `a[i]?` instead." (since := "2025-02-12"), simp]
theorem get?_cons_zero : @get? α (a::l) 0 = some a := rfl
set_option linter.deprecated false in
@[deprecated "Use `a[i]?` instead." (since := "2025-02-12"), simp]
theorem get?_cons_succ : @get? α (a::l) (n+1) = get? l n := rfl

set_option linter.deprecated false in
@[deprecated "Use `List.ext_getElem?`." (since := "2025-02-12")]
theorem ext_get? : ∀ {l₁ l₂ : List α}, (∀ n, l₁.get? n = l₂.get? n) → l₁ = l₂
  | [], [], _ => rfl
  | _ :: _, [], h => nomatch h 0
  | [], _ :: _, h => nomatch h 0
  | a :: l₁, a' :: l₂, h => by
    have h0 : some a = some a' := h 0
    injection h0 with aa; simp only [aa, ext_get? fun n => h (n+1)]

/-! ### get! -/

/--
Returns the `i`-th element in the list (zero-based).

If the index is out of bounds (`i ≥ as.length`), this function panics when executed, and returns
`default`. See `get?` and `getD` for safer alternatives.
-/
@[deprecated "Use `a[i]!` instead." (since := "2025-02-12"), expose]
def get! [Inhabited α] : (as : List α) → (i : Nat) → α
  | a::_,  0   => a
  | _::as, n+1 => get! as n
  | _,     _   => panic! "invalid index"

set_option linter.deprecated false in
@[deprecated "Use `a[i]!` instead." (since := "2025-02-12")]
theorem get!_nil [Inhabited α] (n : Nat) : [].get! n = (default : α) := rfl
set_option linter.deprecated false in
@[deprecated "Use `a[i]!` instead." (since := "2025-02-12")]
theorem get!_cons_succ [Inhabited α] (l : List α) (a : α) (n : Nat) :
    (a::l).get! (n+1) = get! l n := rfl
set_option linter.deprecated false in
@[deprecated "Use `a[i]!` instead." (since := "2025-02-12")]
theorem get!_cons_zero [Inhabited α] (l : List α) (a : α) : (a::l).get! 0 = a := rfl

/-! ### getD -/

/--
Returns the element at the provided index, counting from `0`. Returns `fallback` if the index is out
of bounds.

To return an `Option` depending on whether the index is in bounds, use `as[i]?`. To panic if the
index is out of bounds, use `as[i]!`.

Examples:
 * `["spring", "summer", "fall", "winter"].getD 2 "never" = "fall"`
 * `["spring", "summer", "fall", "winter"].getD 0 "never" = "spring"`
 * `["spring", "summer", "fall", "winter"].getD 4 "never" = "never"`
-/
@[expose] def getD (as : List α) (i : Nat) (fallback : α) : α :=
  as[i]?.getD fallback

@[simp] theorem getD_nil : getD [] n d = d := rfl

/-! ### getLast! -/

/--
Returns the last element in the list. Panics and returns `default` if the list is empty.

Safer alternatives include:
 * `getLast?`, which returns an `Option`,
 * `getLastD`, which takes a fallback value for empty lists, and
 * `getLast`, which requires a proof that the list is non-empty.

Examples:
 * `["circle", "rectangle"].getLast! = "rectangle"`
 * `["circle"].getLast! = "circle"`
-/
@[expose]
def getLast! [Inhabited α] : List α → α
  | []    => panic! "empty list"
  | a::as => getLast (a::as) (fun h => List.noConfusion h)

/-! ## Head and tail -/

/-! ### head! -/

/--
Returns the first element in the list. If the list is empty, panics and returns `default`.

Safer alternatives include:
  * `List.head`, which requires a proof that the list is non-empty,
  * `List.head?`, which returns an `Option`, and
  * `List.headD`, which returns an explicitly-provided fallback value on empty lists.
-/
@[expose] def head! [Inhabited α] : List α → α
  | []   => panic! "empty list"
  | a::_ => a

/-! ### tail! -/

/--
Drops the first element of a nonempty list, returning the tail. If the list is empty, this function
panics when executed and returns the empty list.

Safer alternatives include
 * `tail`, which returns the empty list without panicking,
 * `tail?`, which returns an `Option`, and
 * `tailD`, which returns a fallback value when passed the empty list.

Examples:
 * `["apple", "banana", "grape"].tail! = ["banana", "grape"]`
 * `["banana", "grape"].tail! = ["grape"]`
-/
@[expose] def tail! : List α → List α
  | []    => panic! "empty list"
  | _::as => as

@[simp] theorem tail!_cons : @tail! α (a::l) = l := rfl

/-! ### partitionM -/

/--
Returns a pair of lists that together contain all the elements of `as`. The first list contains
those elements for which the monadic predicate `p` returns `true`, and the second contains those for
which `p` returns `false`. The list's elements are examined in order, from left to right.

This is a monadic version of `List.partition`.

Example:
```lean example
def posOrNeg (x : Int) : Except String Bool :=
  if x > 0 then pure true
  else if x < 0 then pure false
  else throw "Zero is not positive or negative"
```
```lean example
#eval [-1, 2, 3].partitionM posOrNeg
```
```output
Except.ok ([2, 3], [-1])
```
```lean example
#eval [0, 2, 3].partitionM posOrNeg
```
```output
Except.error "Zero is not positive or negative"
```
-/
@[inline] def partitionM [Monad m] (p : α → m Bool) (l : List α) : m (List α × List α) :=
  go l #[] #[]
where
  /-- Auxiliary for `partitionM`:
  `partitionM.go p l acc₁ acc₂` returns `(acc₁.toList ++ left, acc₂.toList ++ right)`
  if `partitionM p l` returns `(left, right)`. -/
  @[specialize] go : List α → Array α → Array α → m (List α × List α)
  | [], acc₁, acc₂ => pure (acc₁.toList, acc₂.toList)
  | x :: xs, acc₁, acc₂ => do
    if ← p x then
      go xs (acc₁.push x) acc₂
    else
      go xs acc₁ (acc₂.push x)

/-! ### partitionMap -/

/--
Applies a function that returns a disjoint union to each element of a list, collecting the `Sum.inl`
and `Sum.inr` results into separate lists.

Examples:
 * `[0, 1, 2, 3].partitionMap (fun x => if x % 2 = 0 then .inl x else .inr x) = ([0, 2], [1, 3])`
 * `[0, 1, 2, 3].partitionMap (fun x => if x = 0 then .inl x else .inr x) = ([0], [1, 2, 3])`
-/
@[inline] def partitionMap (f : α → β ⊕ γ) (l : List α) : List β × List γ := go l #[] #[] where
  /-- Auxiliary for `partitionMap`:
  `partitionMap.go f l acc₁ acc₂ = (acc₁.toList ++ left, acc₂.toList ++ right)`
  if `partitionMap f l = (left, right)`. -/
  @[specialize] go : List α → Array β → Array γ → List β × List γ
  | [], acc₁, acc₂ => (acc₁.toList, acc₂.toList)
  | x :: xs, acc₁, acc₂ =>
    match f x with
    | .inl a => go xs (acc₁.push a) acc₂
    | .inr b => go xs acc₁ (acc₂.push b)

/-! ### mapMono

This is a performance optimization for `List.mapM` that avoids allocating a new list when the result of each `f a` is a pointer equal value `a`.

For verification purposes, `List.mapMono = List.map`.
-/

@[specialize] private unsafe def mapMonoMImp [Monad m] (as : List α) (f : α → m α) : m (List α) := do
  match as with
  | [] => return as
  | b :: bs =>
    let b'  ← f b
    let bs' ← mapMonoMImp bs f
    if ptrEq b' b && ptrEq bs' bs then
      return as
    else
      return b' :: bs'

/--
Applies a monadic function to each element of a list, returning the list of results. The function is
monomorphic: it is required to return a value of the same type. The internal implementation uses
pointer equality, and does not allocate a new list if the result of each function call is
pointer-equal to its argument.
-/
@[implemented_by mapMonoMImp] def mapMonoM [Monad m] (as : List α) (f : α → m α) : m (List α) :=
  match as with
  | [] => return []
  | a :: as => return (← f a) :: (← mapMonoM as f)

/--
Applies a function to each element of a list, returning the list of results. The function is
monomorphic: it is required to return a value of the same type. The internal implementation uses
pointer equality, and does not allocate a new list if the result of each function call is
pointer-equal to its argument.

For verification purposes, `List.mapMono = List.map`.
-/
def mapMono (as : List α) (f : α → α) : List α :=
  Id.run <| as.mapMonoM (pure <| f ·)

/-! ## Additional lemmas required for bootstrapping `Array`. -/

@[simp]
theorem getElem_append_left {as bs : List α} (h : i < as.length) {h' : i < (as ++ bs).length} :
    (as ++ bs)[i] = as[i] := by
  induction as generalizing i with
  | nil => trivial
  | cons a as ih =>
    cases i with
    | zero => rfl
    | succ i => apply ih

@[simp]
theorem getElem_append_right {as bs : List α} {i : Nat} (h₁ : as.length ≤ i) {h₂} :
    (as ++ bs)[i]'h₂ =
      bs[i - as.length]'(by rw [length_append] at h₂; exact Nat.sub_lt_left_of_lt_add h₁ h₂) := by
  induction as generalizing i with
  | nil => trivial
  | cons a as ih =>
    cases i with simp [Nat.succ_sub_succ] <;> simp at h₁
    | succ i => apply ih; simp [h₁]

@[deprecated "Deprecated without replacement." (since := "2025-02-13")]
theorem get_last {as : List α} {i : Fin (length (as ++ [a]))} (h : ¬ i.1 < as.length) : (as ++ [a] : List _).get i = a := by
  cases i; rename_i i h'
  induction as generalizing i with
  | nil => cases i with
    | zero => simp [List.get]
    | succ => simp +arith at h'
  | cons a as ih =>
    cases i with simp at h
    | succ i => apply ih; simp [h]

theorem sizeOf_lt_of_mem [SizeOf α] {as : List α} (h : a ∈ as) : sizeOf a < sizeOf as := by
  induction h with
  | head => simp +arith
  | tail _ _ ih => exact Nat.lt_trans ih (by simp +arith)

/-- This tactic, added to the `decreasing_trivial` toolbox, proves that
`sizeOf a < sizeOf as` when `a ∈ as`, which is useful for well founded recursions
over a nested inductive like `inductive T | mk : List T → T`. -/
macro "sizeOf_list_dec" : tactic =>
  `(tactic| first
    | with_reducible apply sizeOf_lt_of_mem; assumption; done
    | with_reducible
        apply Nat.lt_of_lt_of_le (sizeOf_lt_of_mem ?h)
        case' h => assumption
      simp +arith)

macro_rules | `(tactic| decreasing_trivial) => `(tactic| sizeOf_list_dec)

theorem append_cancel_left {as bs cs : List α} (h : as ++ bs = as ++ cs) : bs = cs := by
  induction as with
  | nil => assumption
  | cons a as ih =>
    injection h with _ h
    exact ih h

theorem append_cancel_right {as bs cs : List α} (h : as ++ bs = cs ++ bs) : as = cs := by
  match as, cs with
  | [], []       => rfl
  | [], c::cs    => have aux := congrArg length h; simp +arith at aux
  | a::as, []    => have aux := congrArg length h; simp +arith at aux
  | a::as, c::cs => injection h with h₁ h₂; subst h₁; rw [append_cancel_right h₂]

@[simp] theorem append_cancel_left_eq (as bs cs : List α) : (as ++ bs = as ++ cs) = (bs = cs) := by
  apply propext; apply Iff.intro
  next => apply append_cancel_left
  next => intro h; simp [h]

@[simp] theorem append_cancel_right_eq (as bs cs : List α) : (as ++ bs = cs ++ bs) = (as = cs) := by
  apply propext; apply Iff.intro
  next => apply append_cancel_right
  next => intro h; simp [h]

theorem sizeOf_get [SizeOf α] (as : List α) (i : Fin as.length) : sizeOf (as.get i) < sizeOf as := by
  match as, i with
  | a::as, ⟨0, _⟩  => simp +arith [get]
  | a::as, ⟨i+1, h⟩ =>
    have ih := sizeOf_get as ⟨i, Nat.le_of_succ_le_succ h⟩
    apply Nat.lt_trans ih
    simp +arith

theorem not_lex_antisymm [DecidableEq α] {r : α → α → Prop} [DecidableRel r]
    (antisymm : ∀ x y : α, ¬ r x y → ¬ r y x → x = y)
    {as bs : List α} (h₁ : ¬ Lex r bs as) (h₂ : ¬ Lex r as bs) : as = bs :=
  match as, bs with
  | [],    []    => rfl
  | [],    _::_ => False.elim <| h₂ (List.Lex.nil ..)
  | _::_, []    => False.elim <| h₁ (List.Lex.nil ..)
  | a::as, b::bs => by
    by_cases hab : r a b
    · exact False.elim <| h₂ (List.Lex.rel hab)
    · by_cases eq : a = b
      · subst eq
        have h₁ : ¬ Lex r bs as := fun h => h₁ (List.Lex.cons h)
        have h₂ : ¬ Lex r as bs := fun h => h₂ (List.Lex.cons h)
        simp [not_lex_antisymm antisymm h₁ h₂]
      · exfalso
        by_cases hba : r b a
        · exact h₁ (Lex.rel hba)
        · exact eq (antisymm _ _ hab hba)

protected theorem le_antisymm [LT α]
    [i : Std.Antisymm (¬ · < · : α → α → Prop)]
    {as bs : List α} (h₁ : as ≤ bs) (h₂ : bs ≤ as) : as = bs :=
  open Classical in
  not_lex_antisymm i.antisymm h₁ h₂

instance [LT α]
    [s : Std.Antisymm (¬ · < · : α → α → Prop)] :
    Std.Antisymm (· ≤ · : List α → List α → Prop) where
  antisymm _ _ h₁ h₂ := List.le_antisymm h₁ h₂

end List
