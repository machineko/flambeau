# Flambeau
# Copyright (c) 2020 Mamy André-Ratsimbazafy
# Licensed and distributed under either of
#   * MIT license (license terms in the root directory or at http://opensource.org/licenses/MIT).
#   * Apache v2 license (license terms in the root directory or at http://www.apache.org/licenses/LICENSE-2.0).
# at your option. This file may not be copied, modified, or distributed except according to those terms.

# ############################################################
#
#                   C++ standard types wrapper
#
# ############################################################

# std::string
# -----------------------------------------------------------------------

{.push header: "<string>".}

type
  CppString* {.importcpp: "std::string", bycopy.} = object

func len*(s: CppString): int {.importcpp: "#.length()".}
  ## Returns the length of a C++ std::string
func data*(s: CppString): lent char {.importcpp: "#.data()".}
  ## Returns a pointer to the raw data of a C++ std::string
func cstring*(s: CppString): cstring {.importcpp: "#.c_str()"}

# Interop
# ------------------------------

func `$`*(s: CppString): string =
  result = newString(s.len)
  copyMem(result[0].addr, s.data.unsafeAddr, s.len)

{.pop.}

# std::shared_ptr<T>
# -----------------------------------------------------------------------

{.push header: "<memory>".}

type
  CppSharedPtr* {.importcpp: "std::shared_ptr", bycopy.} [T] = object

func make_shared*(T: typedesc): CppSharedPtr[T] {.importcpp: "std::make_shared<'*0>()".}

{.pop.}

# std::vector<T>
# -----------------------------------------------------------------------

{.push header: "<memory>".}

type
  CppVector* {.importcpp"std::vector", header: "<vector>", bycopy.} [T] = object

proc init*(V: type CppVector): V {.importcpp: "std::vector<'*0>()", header: "<vector>", constructor.}
proc init*(V: type CppVector, size: int): V {.importcpp: "std::vector<'*0>(#)", header: "<vector>", constructor.}
proc len*(v: CppVector): int {.importcpp: "#.size()", header: "<vector>".}
proc add*[T](v: var CppVector[T], elem: T){.importcpp: "#.push_back(#)", header: "<vector>".}
proc `[]`*[T](v: CppVector[T], idx: int): T{.importcpp: "#[#]", header: "<vector>".}
proc `[]`*[T](v: var CppVector[T], idx: int): var T{.importcpp: "#[#]", header: "<vector>".}

{.pop.}
