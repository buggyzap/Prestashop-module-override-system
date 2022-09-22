# Override default php module Prestashop behaviours

Are you searching for a method that let you override php modules behaviours of Prestashop?

---

## Module Download

➡️ [Last release download](https://replaceme)

---

## What this module do

This module let you override every module .php files you want in your shop.

Native Prestashop override system, only let you override default .js and .tpl files via themes/modules sub-folders, or default Prestashop classes via override folder.

Thats way I decided to create a module that let you to override .php files too!

Sometimes you want to replace specific module behaviours and you don't want to touch original code, this module let you do exactly that!

---

## How it works

1. Download and install last module release
2. Create a module structure you need to override inside the *module_overrides* folder, following the schema (You will duplicate existing sample as starter point)

```
- module_name
  - module_version
    - .override
    - file_to_override_2.php
    - file_to_override_1.php
    - src
      - class_to_override.php
```
3. Go to module configuration page and switch from Active/Inactive override.

<span style="color:#ff4444">.override</span> file is mandatory and contain the override state.

The module automatically detect if is your first override and create *.original* file version that is used in case you want to reverse the changes.

Note that you will see only overrides of modules you have installed of the specific version you want to override.

---

## Report a bug

Please open an issue if you found a bug.
