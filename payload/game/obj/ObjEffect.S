#include <Common.S>

PATCH_B_START(ObjEfDirector_mountEffect, 0x2c8)
    cmpwi r3, 8
    bge TooManyEffects
        addi r0, r3, 1 // Original instruction
        b ObjEfDirector_mountEffect + 0x2cc
    TooManyEffects:
        // r3: Current size
        li r4, 8 // Capacity
        // r5: Path
        b TooManyEffectsFail
PATCH_B_END(ObjEfDirector_mountEffect, 0x2c8)

PATCH_B_START(ObjEfDirector_mountEffect, 0x2d8)
    mr r4, r26 // Path
    mr r26, r3 // Original instruction
    lhz r3, 0x12(r24) // Index
    bl LogLoadedEffect
    b ObjEfDirector_mountEffect + 0x2dc
PATCH_B_END(ObjEfDirector_mountEffect, 0x2d8)

PATCH_B_START(ObjEfDirector_mount, 0x4c)
    mr r30, r3 // Original instruction

    bl ResetLoadedEffects
    li r3, 0 // Index
    addi r4, r31, 48 // Path
    bl LogLoadedEffect
    b ObjEfDirector_mount + 0x50
PATCH_B_END(ObjEfDirector_mount, 0x4c)
