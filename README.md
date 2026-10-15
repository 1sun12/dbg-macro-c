# dbg-macro-c

A one-header `dbg()` macro for C. It prints the file, line, function and value to your terminal, picks the
right `printf` format for the type, and compiles to nothing when it's off.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/1sun12/dbg-macro-c/HEAD/install.sh | bash
```

This copies `debug.h` into `/usr/local/include`, which gcc and clang already search. It asks for your sudo
password. Read [install.sh](install.sh) first if you like; it's short.

### Manual install

If you'd rather not run a remote script as root, download the header, read it, and copy it yourself:

```bash
curl -fsSLO https://raw.githubusercontent.com/1sun12/dbg-macro-c/HEAD/debug.h
```
```bash
sudo cp debug.h /usr/local/include/
```

To skip sudo entirely, keep `debug.h` in your project and use `#include "debug.h"`.

## Use

```c
#define DBG_ON true    // false (or no define) turns it off
#include <debug.h>

int main(void) {
    int count = 42;
    dbg(count);
}
```
```
13:41:07: main.c: 6: main(): 42
```

Or skip the define and compile with `gcc -DDBG_ON`.

## Q&A

- **Nothing prints?** `DBG_ON` must be `true`, and defined before the include.
- **Error mentioning `_Generic`?** That type isn't supported. Cast it: `dbg((int)x)`.
- **Same time on every line?** It's the compile time (`__TIME__`).
- **Uninstall?** `sudo rm /usr/local/include/debug.h`
