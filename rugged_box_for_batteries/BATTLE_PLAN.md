# BATTLE PLAN: Rugged Box for Batteries - OpenSCAD Modular System

**Project Goal:** Create a modular, type-safe OpenSCAD system for generating rugged battery boxes with integrated battery spacers.

**Philosophy:** Rust-style enums and function-based accessors to minimize errors and maximize configurability.

---

## PHASE 1: LIBRARY EXTRACTION & MODULARIZATION

### Step 1.1: Extract Battery Holder Library
**File:** `/home/conan/git/models/rugged_box_for_batteries/battery_holder.scad`

**Tasks:**
- Extract all battery spec structures and accessor functions
- Extract all manufacturing spec structures and accessor functions
- Extract all design spec structures and accessor functions
- Extract battery definitions (BATTERY_RED, BATTERY_GREEN, etc.)
- Extract manufacturing profiles (MFG_STANDARD_FDM, etc.)
- Extract design presets (DESIGN_COMPACT, DESIGN_ROBUST, etc.)
- Extract calculation functions (spacing, dimensions)
- Extract visualization modules (battery, battery_matrix)
- Extract holder generation modules (single_cell_holder, holder_matrix)
- Keep through-hole spacer version logic

**Verification:**
- [ ] All spec structures have complete accessor functions
- [ ] No magic array indices in code
- [ ] All constants follow enum-like pattern
- [ ] File can be included independently
- [ ] No floating dependencies

**From Original:** `18650_enum_like_version_003_matrix.scad` (lines 1-422)

---

### Step 1.2: Extract Rugged Box Library
**File:** `/home/conan/git/models/rugged_box_for_batteries/rugged_box.scad`

**Tasks:**
- Extract view mode enums (VIEW_BOTH, VIEW_TOP, VIEW_BOTTOM)
- Extract position enums (POS_CENTER, POS_AT_HINGE)
- Extract hinge state enums (HINGE_CLOSED through HINGE_OPEN)
- Extract main ruggedBox() module
- Extract all helper modules (topHingeSide, bottomRabbet, etc.)
- Extract conditional transform modules (top_transform, set_color)
- Keep all hinge/lock mechanism logic
- Keep snap lid mechanism

**Verification:**
- [ ] All enums defined as constants
- [ ] No magic strings/numbers in logic
- [ ] ruggedBox() module works independently
- [ ] All helper modules properly scoped
- [ ] File can be included independently

**From Original:** `paaavel_rugged_box_enum_like.scad` (lines 1-487)

---

### Step 1.3: Create Main Configuration File
**File:** `/home/conan/git/models/rugged_box_for_batteries/main.scad`

**Tasks:**
- Include both libraries (use<> for modules only)
- Create unified configuration section with:
  - Battery selection (enum-like choice)
  - Battery matrix configuration [cols, rows]
  - Manufacturing profile selection
  - Design preset selection
  - Box dimensions (auto-calculated from battery + margins)
  - Box part view mode (SHOW_BOX_BOTTOM, SHOW_BOX_LID, SHOW_SPACER, SHOW_ALL)
  - Hinge open angle selection
  - Render quality multiplier
  - Color configuration
- Create rendering logic that conditionally shows requested parts
- Add export mode helpers (comments showing how to export each part)

**Verification:**
- [ ] Single point of configuration
- [ ] All choices use enum-like constants
- [ ] Clear comments for each configuration option
- [ ] Export instructions included
- [ ] No code duplication from libraries

---

## PHASE 2: INTEGRATION & ALIGNMENT

### Step 2.1: Box-to-Spacer Dimensional Integration
**File:** Updates to `main.scad`

**Tasks:**
- Calculate battery holder dimensions from selected battery + matrix
- Calculate required inner box dimensions to fit holder
- Add margin parameters (clearance between spacer and box interior)
- Ensure box dimensions auto-adjust to battery selection
- Create derived calculations (let-style bindings)

**Verification:**
- [ ] Spacer fits inside box with proper clearance
- [ ] Dimensions update automatically when battery type changes
- [ ] Dimensions update automatically when matrix changes
- [ ] No manual dimension conflicts possible

---

### Step 2.2: View Mode System
**File:** Updates to `main.scad`

**Tasks:**
- Create view mode enums:
  - `SHOW_BOX_ONLY` - just box (bottom + lid at hinge)
  - `SHOW_BOX_BOTTOM` - only bottom half
  - `SHOW_BOX_LID` - only lid (for STL export)
  - `SHOW_SPACER` - only battery spacer (for STL export)
  - `SHOW_BOX_WITH_SPACER` - complete assembly view
  - `SHOW_ALL_SEPARATED` - all parts laid out for inspection
- Implement conditional rendering based on view mode
- Add positioning logic for separated view

**Verification:**
- [ ] Each view mode works correctly
- [ ] STL export modes show only one part
- [ ] Assembly view shows proper fit
- [ ] No overlapping geometry in separated view

---

## PHASE 3: ENHANCEMENT & REFINEMENT

### Step 3.1: Advanced Configuration Options
**File:** Updates to `main.scad`

**Tasks:**
- Add spacer placement options (bottom-only, top-and-bottom, separate)
- Add optional features toggles:
  - Drainage holes in box bottom
  - Ventilation holes in box sides
  - Label area on lid
  - Mounting holes in box bottom
- Create feature flag enums
- Implement conditional geometry generation

**Verification:**
- [ ] All options work independently
- [ ] Options can be combined safely
- [ ] Optional features don't break core functionality
- [ ] Feature flags follow enum pattern

---

### Step 3.2: Export Optimization
**File:** Updates to `main.scad`

**Tasks:**
- Add export mode enum (EXPORT_BOX_BOTTOM, EXPORT_BOX_LID, EXPORT_SPACER)
- Auto-rotate parts to optimal print orientation in export mode
- Add build plate positioning
- Add part labels in comments
- Create quick-switch presets for common configurations

**Verification:**
- [ ] Exported parts are correctly oriented
- [ ] Parts are positioned at origin/build plate
- [ ] Easy to switch between export modes
- [ ] Presets work as expected

---

### Step 3.3: Documentation & Examples
**File:** Updates to `main.scad` (comments only)

**Tasks:**
- Add header documentation explaining the system
- Document each enum with usage examples
- Add quick-start configuration examples:
  - Small box: 2x3 batteries, compact design
  - Medium box: 3x4 batteries, robust design
  - Large box: 4x5 batteries, custom dimensions
- Add STL export workflow instructions
- Document recommended print settings per manufacturing profile

**Verification:**
- [ ] New users can understand configuration options
- [ ] Examples are copy-paste ready
- [ ] Export workflow is clear
- [ ] Print settings recommendations are accurate

---

## PHASE 4: VALIDATION & TESTING

### Step 4.1: Render Testing
**Tasks:**
- Test all battery type combinations
- Test all matrix sizes (1x1 through 5x5)
- Test all view modes
- Test all hinge positions
- Test all design presets
- Check for OpenSCAD warnings/errors

**Verification:**
- [ ] No OpenSCAD errors
- [ ] No geometry warnings
- [ ] All combinations render successfully
- [ ] Reasonable render times

---

### Step 4.2: Dimensional Validation
**Tasks:**
- Verify battery clearances are correct
- Verify box-to-spacer fit with margins
- Verify hinge operation geometry
- Verify snap lock clearances
- Check wall thicknesses meet minimum specs

**Verification:**
- [ ] All clearances within tolerance
- [ ] Parts fit together properly
- [ ] No interference in assembled state
- [ ] Printable wall thicknesses

---

### Step 4.3: STL Export Validation
**Tasks:**
- Export box bottom STL
- Export box lid STL
- Export spacer STL
- Check STL files in slicer software
- Verify manifold geometry
- Check for non-printable features

**Verification:**
- [ ] STL files are manifold (watertight)
- [ ] No errors in slicer
- [ ] Proper orientation for printing
- [ ] Support requirements are reasonable

---

## PHASE 5: POLISH & FINALIZATION

### Step 5.1: Code Quality Review
**Tasks:**
- Verify all functions follow naming conventions
- Check for code duplication
- Ensure consistent indentation
- Verify all magic numbers are eliminated
- Check all comments are accurate

**Verification:**
- [ ] Consistent code style
- [ ] No duplicated logic
- [ ] All values are named constants
- [ ] Comments match implementation

---

### Step 5.2: User Experience Polish
**Tasks:**
- Add echo() statements for key dimensions
- Add render progress indicators
- Improve variable naming for clarity
- Group related configurations
- Add visual separators in code

**Verification:**
- [ ] Console output is helpful
- [ ] Configuration section is intuitive
- [ ] Related options are grouped logically
- [ ] Code is easy to scan visually

---

## SUCCESS CRITERIA

**The project is complete when:**
1. ✅ All three files exist and are properly modularized
2. ✅ Battery type selection works with all defined batteries
3. ✅ Matrix size can be changed with single parameter
4. ✅ Box dimensions auto-calculate from battery + matrix + margins
5. ✅ All view modes work correctly
6. ✅ All hinge positions work correctly
7. ✅ STL export modes produce clean, printable files
8. ✅ No magic numbers or hardcoded values in logic
9. ✅ All enums follow consistent naming pattern
10. ✅ Code is readable and maintainable

---

## RISK MITIGATION

**Potential Issues:**
- **Dimensional conflicts:** Mitigated by auto-calculation and derived values
- **Export orientation errors:** Mitigated by explicit export modes with rotations
- **Printability issues:** Mitigated by manufacturing profile system
- **Configuration complexity:** Mitigated by presets and clear documentation
- **Code coupling:** Mitigated by library separation and clean interfaces

---

## DECISION LOG

**Key Architectural Decisions:**
1. Use `use<>` instead of `include<>` to avoid namespace pollution
2. Function-based accessors instead of array indices for type safety
3. Enum-like constants instead of magic strings/numbers
4. Auto-calculated dimensions instead of manual coordination
5. Conditional rendering instead of separate files for each part
6. Through-hole spacer design for easier battery access

**Future Enhancements (Out of Scope):**
- Multi-battery-type support in single holder
- Parametric hinge design (different styles)
- Gasket/seal integration
- Custom label text generation
- Battery terminal protection features

---

**START DATE:** 2025-11-18
**STATUS:** Phase 1 - Planning Complete, Ready for Implementation
