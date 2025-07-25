/-
Copyright (c) 2025 Lean FRO, LLC. or its affiliates. All Rights Reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Kim Morrison
-/
module

prelude
public import Init.Grind.Ring.Basic
public import all Init.GrindInstances.ToInt
public import all Init.Data.UInt.Basic
public import Init.Data.UInt.Lemmas

public section

namespace UInt8

/-- Variant of `UInt8.ofNat_mod_size` replacing `2 ^ 8` with `256`.-/
theorem ofNat_mod_size' : ofNat (x % 256) = ofNat x := ofNat_mod_size

@[expose]
def natCast : NatCast UInt8 where
  natCast x := UInt8.ofNat x

@[expose]
def intCast : IntCast UInt8 where
  intCast x := UInt8.ofInt x

attribute [local instance] natCast intCast

theorem intCast_neg (x : Int) : ((-x : Int) : UInt8) = - (x : UInt8) := by
  simp only [Int.cast, IntCast.intCast, UInt8.ofInt_neg]

theorem intCast_ofNat (x : Nat) : (OfNat.ofNat (α := Int) x : UInt8) = OfNat.ofNat x := by
    -- A better proof would be welcome!
    simp only [Int.cast, IntCast.intCast]
    rw [UInt8.ofInt]
    rw [Int.toNat_emod (Int.zero_le_ofNat x) (by decide)]
    erw [Int.toNat_natCast]
    rw [Int.toNat_pow_of_nonneg (by decide)]
    simp only [ofNat, BitVec.ofNat, Fin.ofNat, Int.reduceToNat, Nat.dvd_refl,
      Nat.mod_mod_of_dvd, instOfNat]

end UInt8

namespace UInt16

/-- Variant of `UInt16.ofNat_mod_size` replacing `2 ^ 16` with `65536`.-/
theorem ofNat_mod_size' : ofNat (x % 65536) = ofNat x := ofNat_mod_size

@[expose]
def natCast : NatCast UInt16 where
  natCast x := UInt16.ofNat x

@[expose]
def intCast : IntCast UInt16 where
  intCast x := UInt16.ofInt x

attribute [local instance] natCast intCast

theorem intCast_neg (x : Int) : ((-x : Int) : UInt16) = - (x : UInt16) := by
  simp only [Int.cast, IntCast.intCast, UInt16.ofInt_neg]

theorem intCast_ofNat (x : Nat) : (OfNat.ofNat (α := Int) x : UInt16) = OfNat.ofNat x := by
    -- A better proof would be welcome!
    simp only [Int.cast, IntCast.intCast]
    rw [UInt16.ofInt]
    rw [Int.toNat_emod (Int.zero_le_ofNat x) (by decide)]
    erw [Int.toNat_natCast]
    rw [Int.toNat_pow_of_nonneg (by decide)]
    simp only [ofNat, BitVec.ofNat, Fin.ofNat, Int.reduceToNat, Nat.dvd_refl,
      Nat.mod_mod_of_dvd, instOfNat]

end UInt16

namespace UInt32

/-- Variant of `UInt32.ofNat_mod_size` replacing `2 ^ 32` with `4294967296`.-/
theorem ofNat_mod_size' : ofNat (x % 4294967296) = ofNat x := ofNat_mod_size

@[expose]
def natCast : NatCast UInt32 where
  natCast x := UInt32.ofNat x

@[expose]
def intCast : IntCast UInt32 where
  intCast x := UInt32.ofInt x

attribute [local instance] natCast intCast

theorem intCast_neg (x : Int) : ((-x : Int) : UInt32) = - (x : UInt32) := by
  simp only [Int.cast, IntCast.intCast, UInt32.ofInt_neg]

theorem intCast_ofNat (x : Nat) : (OfNat.ofNat (α := Int) x : UInt32) = OfNat.ofNat x := by
    -- A better proof would be welcome!
    simp only [Int.cast, IntCast.intCast]
    rw [UInt32.ofInt]
    rw [Int.toNat_emod (Int.zero_le_ofNat x) (by decide)]
    erw [Int.toNat_natCast]
    rw [Int.toNat_pow_of_nonneg (by decide)]
    simp only [ofNat, BitVec.ofNat, Fin.ofNat, Int.reduceToNat, Nat.dvd_refl,
      Nat.mod_mod_of_dvd, instOfNat]

end UInt32

namespace UInt64

/-- Variant of `UInt64.ofNat_mod_size` replacing `2 ^ 64` with `18446744073709551616`.-/
theorem ofNat_mod_size' : ofNat (x % 18446744073709551616) = ofNat x := ofNat_mod_size

@[expose]
def natCast : NatCast UInt64 where
  natCast x := UInt64.ofNat x

@[expose]
def intCast : IntCast UInt64 where
  intCast x := UInt64.ofInt x

attribute [local instance] natCast intCast

theorem intCast_neg (x : Int) : ((-x : Int) : UInt64) = - (x : UInt64) := by
  simp only [Int.cast, IntCast.intCast, UInt64.ofInt_neg]

theorem intCast_ofNat (x : Nat) : (OfNat.ofNat (α := Int) x : UInt64) = OfNat.ofNat x := by
    -- A better proof would be welcome!
    simp only [Int.cast, IntCast.intCast]
    rw [UInt64.ofInt]
    rw [Int.toNat_emod (Int.zero_le_ofNat x) (by decide)]
    erw [Int.toNat_natCast]
    rw [Int.toNat_pow_of_nonneg (by decide)]
    simp only [ofNat, BitVec.ofNat, Fin.ofNat, Int.reduceToNat, Nat.dvd_refl,
      Nat.mod_mod_of_dvd, instOfNat]

end UInt64

namespace USize

@[expose]
def natCast : NatCast USize where
  natCast x := USize.ofNat x

@[expose]
def intCast : IntCast USize where
  intCast x := USize.ofInt x

attribute [local instance] natCast intCast

theorem intCast_neg (x : Int) : ((-x : Int) : USize) = - (x : USize) := by
  simp only [Int.cast, IntCast.intCast, USize.ofInt_neg]

theorem intCast_ofNat (x : Nat) : (OfNat.ofNat (α := Int) x : USize) = OfNat.ofNat x := by
    -- A better proof would be welcome!
    simp only [Int.cast, IntCast.intCast]
    rw [USize.ofInt]
    rw [Int.toNat_emod (Int.zero_le_ofNat x)]
    · erw [Int.toNat_natCast]
      rw [Int.toNat_pow_of_nonneg (by decide)]
      simp only [ofNat, BitVec.ofNat, Fin.ofNat, Int.reduceToNat, Nat.dvd_refl,
        Nat.mod_mod_of_dvd, instOfNat]
    · obtain _ | _ := System.Platform.numBits_eq <;> simp_all

end USize
namespace Lean.Grind

attribute [local instance] UInt8.natCast UInt8.intCast in
instance : CommRing UInt8 where
  nsmul := ⟨(· * ·)⟩
  zsmul := ⟨(· * ·)⟩
  add_assoc := UInt8.add_assoc
  add_comm := UInt8.add_comm
  add_zero := UInt8.add_zero
  neg_add_cancel := UInt8.add_left_neg
  mul_assoc := UInt8.mul_assoc
  mul_comm := UInt8.mul_comm
  mul_one := UInt8.mul_one
  one_mul := UInt8.one_mul
  left_distrib _ _ _ := UInt8.mul_add
  right_distrib _ _ _ := UInt8.add_mul
  zero_mul _ := UInt8.zero_mul
  mul_zero _ := UInt8.mul_zero
  sub_eq_add_neg := UInt8.sub_eq_add_neg
  pow_zero := UInt8.pow_zero
  pow_succ := UInt8.pow_succ
  ofNat_succ x := UInt8.ofNat_add x 1
  intCast_neg := UInt8.ofInt_neg
  intCast_ofNat := UInt8.intCast_ofNat
  neg_zsmul i a := by simp [UInt8.intCast_neg, UInt8.neg_mul]
  zsmul_natCast_eq_nsmul n a := congrArg (· * a) (UInt8.intCast_ofNat _)

instance : IsCharP UInt8 256 := IsCharP.mk' _ _
  (ofNat_eq_zero_iff := fun x => by
    have : OfNat.ofNat x = UInt8.ofNat x := rfl
    simp [this, UInt8.ofNat_eq_iff_mod_eq_toNat])

-- Verify we can derive the instances showing how `toInt` interacts with operations:
example : ToInt.Add UInt8 (.uint 8) := inferInstance
example : ToInt.Neg UInt8 (.uint 8) := inferInstance
example : ToInt.Sub UInt8 (.uint 8) := inferInstance

instance : ToInt.Pow UInt8 (.uint 8) := ToInt.pow_of_semiring (by simp)

attribute [local instance] UInt16.natCast UInt16.intCast in
instance : CommRing UInt16 where
  nsmul := ⟨(· * ·)⟩
  zsmul := ⟨(· * ·)⟩
  add_assoc := UInt16.add_assoc
  add_comm := UInt16.add_comm
  add_zero := UInt16.add_zero
  neg_add_cancel := UInt16.add_left_neg
  mul_assoc := UInt16.mul_assoc
  mul_comm := UInt16.mul_comm
  mul_one := UInt16.mul_one
  one_mul := UInt16.one_mul
  left_distrib _ _ _ := UInt16.mul_add
  right_distrib _ _ _ := UInt16.add_mul
  zero_mul _ := UInt16.zero_mul
  mul_zero _ := UInt16.mul_zero
  sub_eq_add_neg := UInt16.sub_eq_add_neg
  pow_zero := UInt16.pow_zero
  pow_succ := UInt16.pow_succ
  ofNat_succ x := UInt16.ofNat_add x 1
  intCast_neg := UInt16.ofInt_neg
  intCast_ofNat := UInt16.intCast_ofNat
  neg_zsmul i a := by simp [UInt16.intCast_neg, UInt16.neg_mul]
  zsmul_natCast_eq_nsmul n a := congrArg (· * a) (UInt16.intCast_ofNat _)

instance : IsCharP UInt16 65536 := IsCharP.mk' _ _
  (ofNat_eq_zero_iff := fun x => by
    have : OfNat.ofNat x = UInt16.ofNat x := rfl
    simp [this, UInt16.ofNat_eq_iff_mod_eq_toNat])

-- Verify we can derive the instances showing how `toInt` interacts with operations:
example : ToInt.Add UInt16 (.uint 16) := inferInstance
example : ToInt.Neg UInt16 (.uint 16) := inferInstance
example : ToInt.Sub UInt16 (.uint 16) := inferInstance

instance : ToInt.Pow UInt16 (.uint 16) := ToInt.pow_of_semiring (by simp)

attribute [local instance] UInt32.natCast UInt32.intCast in
instance : CommRing UInt32 where
  nsmul := ⟨(· * ·)⟩
  zsmul := ⟨(· * ·)⟩
  add_assoc := UInt32.add_assoc
  add_comm := UInt32.add_comm
  add_zero := UInt32.add_zero
  neg_add_cancel := UInt32.add_left_neg
  mul_assoc := UInt32.mul_assoc
  mul_comm := UInt32.mul_comm
  mul_one := UInt32.mul_one
  one_mul := UInt32.one_mul
  left_distrib _ _ _ := UInt32.mul_add
  right_distrib _ _ _ := UInt32.add_mul
  zero_mul _ := UInt32.zero_mul
  mul_zero _ := UInt32.mul_zero
  sub_eq_add_neg := UInt32.sub_eq_add_neg
  pow_zero := UInt32.pow_zero
  pow_succ := UInt32.pow_succ
  ofNat_succ x := UInt32.ofNat_add x 1
  intCast_neg := UInt32.ofInt_neg
  intCast_ofNat := UInt32.intCast_ofNat
  neg_zsmul i a := by simp [UInt32.intCast_neg, UInt32.neg_mul]
  zsmul_natCast_eq_nsmul n a := congrArg (· * a) (UInt32.intCast_ofNat _)

instance : IsCharP UInt32 4294967296 := IsCharP.mk' _ _
  (ofNat_eq_zero_iff := fun x => by
    have : OfNat.ofNat x = UInt32.ofNat x := rfl
    simp [this, UInt32.ofNat_eq_iff_mod_eq_toNat])

-- Verify we can derive the instances showing how `toInt` interacts with operations:
example : ToInt.Add UInt32 (.uint 32) := inferInstance
example : ToInt.Neg UInt32 (.uint 32) := inferInstance
example : ToInt.Sub UInt32 (.uint 32) := inferInstance

instance : ToInt.Pow UInt32 (.uint 32) := ToInt.pow_of_semiring (by simp)

attribute [local instance] UInt64.natCast UInt64.intCast in
instance : CommRing UInt64 where
  nsmul := ⟨(· * ·)⟩
  zsmul := ⟨(· * ·)⟩
  add_assoc := UInt64.add_assoc
  add_comm := UInt64.add_comm
  add_zero := UInt64.add_zero
  neg_add_cancel := UInt64.add_left_neg
  mul_assoc := UInt64.mul_assoc
  mul_comm := UInt64.mul_comm
  mul_one := UInt64.mul_one
  one_mul := UInt64.one_mul
  left_distrib _ _ _ := UInt64.mul_add
  right_distrib _ _ _ := UInt64.add_mul
  zero_mul _ := UInt64.zero_mul
  mul_zero _ := UInt64.mul_zero
  sub_eq_add_neg := UInt64.sub_eq_add_neg
  pow_zero := UInt64.pow_zero
  pow_succ := UInt64.pow_succ
  ofNat_succ x := UInt64.ofNat_add x 1
  intCast_neg := UInt64.ofInt_neg
  intCast_ofNat := UInt64.intCast_ofNat
  neg_zsmul i a := by simp [UInt64.intCast_neg, UInt64.neg_mul]
  zsmul_natCast_eq_nsmul n a := congrArg (· * a) (UInt64.intCast_ofNat _)

instance : IsCharP UInt64 18446744073709551616 := IsCharP.mk' _ _
  (ofNat_eq_zero_iff := fun x => by
    have : OfNat.ofNat x = UInt64.ofNat x := rfl
    simp [this, UInt64.ofNat_eq_iff_mod_eq_toNat])

-- Verify we can derive the instances showing how `toInt` interacts with operations:
example : ToInt.Add UInt64 (.uint 64) := inferInstance
example : ToInt.Neg UInt64 (.uint 64) := inferInstance
example : ToInt.Sub UInt64 (.uint 64) := inferInstance

instance : ToInt.Pow UInt64 (.uint 64) := ToInt.pow_of_semiring (by simp)

attribute [local instance] USize.natCast USize.intCast in
instance : CommRing USize where
  nsmul := ⟨(· * ·)⟩
  zsmul := ⟨(· * ·)⟩
  add_assoc := USize.add_assoc
  add_comm := USize.add_comm
  add_zero := USize.add_zero
  neg_add_cancel := USize.add_left_neg
  mul_assoc := USize.mul_assoc
  mul_comm := USize.mul_comm
  mul_one := USize.mul_one
  one_mul := USize.one_mul
  left_distrib _ _ _ := USize.mul_add
  right_distrib _ _ _ := USize.add_mul
  zero_mul _ := USize.zero_mul
  mul_zero _ := USize.mul_zero
  sub_eq_add_neg := USize.sub_eq_add_neg
  pow_zero := USize.pow_zero
  pow_succ := USize.pow_succ
  ofNat_succ x := USize.ofNat_add x 1
  intCast_neg := USize.ofInt_neg
  intCast_ofNat := USize.intCast_ofNat
  neg_zsmul i a := by simp [USize.intCast_neg, USize.neg_mul]
  zsmul_natCast_eq_nsmul n a := congrArg (· * a) (USize.intCast_ofNat _)

open System.Platform

instance : IsCharP USize (2 ^ numBits) := IsCharP.mk' _ _
  (ofNat_eq_zero_iff := fun x => by
    have : OfNat.ofNat x = USize.ofNat x := rfl
    simp [this, USize.ofNat_eq_iff_mod_eq_toNat])

-- Verify we can derive the instances showing how `toInt` interacts with operations:
example : ToInt.Add USize (.uint numBits) := inferInstance
example : ToInt.Neg USize (.uint numBits) := inferInstance
example : ToInt.Sub USize (.uint numBits) := inferInstance

instance : ToInt.Pow USize (.uint numBits) :=
  ToInt.pow_of_semiring (by simp)

end Lean.Grind
