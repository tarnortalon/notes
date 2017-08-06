# Basic VIM operations

## Operator

| Trigger | Effect             |
|---------|--------------------|
| `c`     | Change             |
| `d`     | Delete             |
| `y`     | Yank into register |
| `g~`    | Swap case          |
| `gu`    | Make lowercase     |
| `gU`    | Make uppercase     |
| `>`     | Shift right        |
| `<`     | Shift left         |

### Visual operator

| Trigger | Effect                                    |
|---------|-------------------------------------------|
| `U`     | Convert selected characters to uppercase |

## Double operator

| Trigger   | Effect                          |
| --------- | ------------------------------- |
| `cc`      | Change the current line         |
| `dd`      | Delete the current line         |
| `yy`      | Yank the current line           |
| `g~~`     | Swap case for the current line  |
| `guu`     | Make current line lowercase     |
| `gUU`     | Make current line uppercase     |
| `>>`      | Shift right the current line    |
| `<<`      | Shift left the current line     |

## Motion

### Line-wise motion

| Command | Move cursor                                 |
|---------|---------------------------------------------|
| `j`     | Down one real line                          |
| `gj`    | Down one display line                       |
| `k`     | Up one real line                            |
| `gk`    | Up one display line                         |
| `0`     | To first character of real line             |
| `g0`    | To first chracter of display line           |
| `^`     | To first nonblank character of real line    |
| `g^`    | To first nonblank character of display line |
| `$`     | To end of real line                         |
| `g$`    | To end of display line                      |

### Word-wise motion

| Command | Move cursor                                |
|---------|--------------------------------------------|
| `w`     | Forward to start of next word              |
| `b`     | Backward to start of current/previous word |
| `e`     | Forward to end of current/next word        |
| `ge`    | Backward to end of previous word           |

![vim_wordwise_motion](vim_wordwise_motion)

| Object | Definition                                                                                                               |
|--------|--------------------------------------------------------------------------------------------------------------------------|
| word   | A sequence of letters, digits, and underscores, or as a sequence of other nonblank characters, separated with whitespace |
| WORD   | A sequence of nonblank characters separated with whitespace                                                              |

### Find by character

| Command   | Effect                                                            |
|-----------|-------------------------------------------------------------------|
| `f{char}` | Forward to the next occurrence of {char}                          |
| `F{char}` | Backward to the previous occurrence of {char}                     |
| `t{char}` | Forward to the character before the next occurrence of {char}     |
| `T{char}` | Backward to the character after the previous occurrence of {char} |
| `;`       | Repeat the last character-search command                          |
| `,`       | Reverse the last character-search command                         |

## Jump and change list

### Jump definitions

| Command                                           | Effect                                         |
|---------------------------------------------------|------------------------------------------------|
| `[count]G`                                        | Jump to line number                            |
| <code>//pattern&lt;CR>/?pattern&lt;CR>/n/N</code> | Jump to next/previous occurrence of pattern    |
| `%`                                               | Jump to matching parenthesis                   |
| `(/)`                                             | Jump to start of previous/next sentence        |
| `{/}`                                             | Jump to start of previous/next paragraph       |
| `H/M/L`                                           | Jump to top/middle/bottom of screen            |
| `gf`                                              | Jump to file name under the cursor             |
| <code>&lt;C-]></code>                             | Jump to definition of keyword under the cursor |
| <code>'{mark}/`{mark}</code>                      | Jump to a mark                                 |

### Traverse the jump list

| Command | Effect            |
|---------|-------------------|
| `<C-o>` | Go back a jump    |
| `<C-i>` | Go forward a jump |

### Traverse the change list

| Command | Effect              |
|---------|---------------------|
| `g;`    | Go back a change    |
| `g,`    | Go forward a change |

## Text object

### Delimited text objects

| Text object     | Selection                                          |
|-----------------|----------------------------------------------------|
| `a)` or `ab`    | A pair of (parentheses)                            |
| `i)` or `ib`    | Inside of (parentheses)                            |
| `a}` or `aB`    | A pair of {braces}                                 |
| `i}` or `iB`    | Inside of {braces}                                 |
| `a]`            | A pair of [brackets]                               |
| `i]`            | Inside of [brackets]                               |
| `a>`            | A pair of &lt;angle brackets>                      |
| `i>`            | Inside of &lt;angle brackets>                      |
| `a'`            | A pair of 'single quotes'                          |
| `i'`            | Inside of 'single quotes'                          |
| `a"`            | A pair of "double quotes"                          |
| `i"`            | Inside of "double quotes"                          |
| <code>a`</code> | A pair of \`backticks\`                            |
| <code>i`</code> | Inside of \`backticks\`                            |
| `at`            | A tag block, including surrounding tags            |
| `it`            | An inner tag block, not including surrounding tags |

### Bounded text objects

| Text object | Selection                             |
|-------------|---------------------------------------|
| `iw`        | Current word                          |
| `aw`        | Current word plus one space           |
| `iW`        | Current WORD                          |
| `aW`        | Current WORD plus one space           |
| `is`        | Current sentence                      |
| `as`        | Current sentence plus one space       |
| `ip`        | Current paragraph                     |
| `ap`        | Current paragraph plus one blank line |

## Special command

### Normal mode

| Special command | Effect                         |
|-----------------|--------------------------------|
| `.`             | Repeat last change             |
| `<C-a>`         | Perform addition on numbers    |
| `<C-x>`         | Perform subtraction on numbers |

### Insert mode / Command-Line mode

| Special command       | Effect                                                 |
|-----------------------|--------------------------------------------------------|
| `<C-h>`               | Delete back one character                              |
| `<C-w>`               | Delete back one word                                   |
| `<C-u>`               | Delete back to start of line                           |
| `<C-o>`               | Switch to Insert Normal mode                           |
| `<C-r>{register}`     | Paste text from register                               |
| `<C-r>=`              | Paste from expression register                         |
| `<C-v>{123}`          | Insert character by decimal code                       |
| `<C-v>{1234}`         | Insert character by hexadecimal code                   |
| `<C-v>{nondigit}`     | Insert nondigit literally                              |
| `<C-k>{char1}{char2}` | Insert character represented by {char1}{char2} digraph |

### Command-Line mode

| Special command | Effect                                                                    |
|-----------------|---------------------------------------------------------------------------|
| `<C-r><C-w>`    | Copies the word under the cursor and insert it at the command-line prompt |

### Visual mode

| Special command | Effect                              |
|-----------------|-------------------------------------|
| `o`             | Go to other end of highlighted text |

## Compound command

| Compound command | Equivalent in longhand |
|------------------|------------------------|
| `C`              | `c$`                   |
| `s`              | `cl`                   |
| `S`              | `^C`                   |
| `I`              | `^i`                   |
| `A`              | `$a`                   |
| `o`              | `A<CR>`                |
| `O`              | `ko`                   |

## Visual mode triggering

| Trigger | Effect                             |
|---------|------------------------------------|
| `v`     | Enable character-wise Visual mode  |
| `V`     | Enable line-wise Visual mode       |
| `<C-v>` | Enable block-wise Visual mode      |
| `gv`    | Reselect the last visual selection |

## Triggering special mode

### From Normal mode

| Trigger | Special mode                      |
|---------|-----------------------------------|
| `R`     | Replace mode                      |
| `gR`    | Virtual replace mode              |
| `r`     | Single-shot replace mode          |
| `gr`    | Single short virtual replace mode |

### From Visual mode

| Trigger | Special mode |
|---------|--------------|
| `<C-g>` | Select mode  |

## Command-Line mode

| Command                                         | Effect                                                                          |
|-------------------------------------------------|---------------------------------------------------------------------------------|
| `:[range]delete [x]`                            | Delete specified lines [into register x]                                        |
| `:[range]yank [x]`                              | Yank specified lines [into register x]                                          |
| `:[line]put [x]`                                | Put the text from register x after the specified line                           |
| `:[range]copy {address}`                        | Copy the specified lines to below the line specified by {address}               |
| `:[range]move {address}`                        | Move the specified lines to below the line specified by {address}               |
| `:[range]join`                                  | Join the specified lines                                                        |
| `:[range]normal {commands}`                     | Execute Normal mode {commands} on each specified line                           |
| `:[range]substitute/{pattern}/{string}/[flags]` | Replace occurrences of {pattern} with {string} on each specified line           |
| `:[range]global/{pattern}/[cmd]`                | Execute the Ex command [cmd] on all specified lines where the {pattern} matches |

### Range definition

| Symbol | Address                                   |
|--------|-------------------------------------------|
| `1`    | First line of the file                    |
| `$`    | Last line of the file                     |
| `0`    | Virtual line above first line of the file |
| `.`    | Line where the cursor is placed           |
| `'m`   | Line containing mark `m`                  |
| `'<`   | Start of visual selection                 |
| `'>`   | End of visual seleection                  |
| `%`    | The entire file (shorthand for `1,$`)     |

## Managing buffers

### Spliting windows

| Command            | Effect                                                                    |
|--------------------|---------------------------------------------------------------------------|
| `<C-w>s`           | Split the current window horizontally into two windows of equal height    |
| `<C-w>v`           | Split the current window vertically into two windows of equal width       |
| `:sp[lit] {file}`  | Split the current window horizontally, loading {file} into the new window |
| `:vsp[lit] {file}` | Split the current window vertically, loading {file} into the new window   |

### Changing the focus between windows

| Command  | Effect                        |
|----------|-------------------------------|
| `<C-w>w` | Cycle through open windows    |
| `<C-w>h` | Focus the window to the left  |
| `<C-w>j` | Focus the window below        |
| `<C-w>k` | Focus the window above        |
| `<C-w>h` | Focus the window to the right |

### Closing windows

| Ex Command | Normal Command | Effect                                          |
|------------|----------------|-------------------------------------------------|
| `:cl[ose]` | `<C-w>c`       | Close the active window                         |
| `:on[ly]`  | `<C-w>o`       | Keep only the active window, closing all others |

### Resizing and Rearranging windows

| Command                           | Effect                                   |
|-----------------------------------|------------------------------------------|
| `<C-w>=`                          | Equalize width and height of all windows |
| `<C-w>_`                          | Maximize height of the active window     |
| <code>&lt;C-w>&#124;</code>    | Maximize width of the active window      |
| `[N]<C-w>_`                       | Set active window height to [N] rows     |
| <code>[N]&lt;C-w>&#124;</code> | Set active window width to [N] columns   |

### Moving window to tab

| Command  | Effect                                      |
|----------|---------------------------------------------|
| `<C-w>T` | Move the current window into a new tab page |

## Useful tips

### Act, Repeat, Reverse

This is Tip 4 from Drew Neil's Practical Vim.

> When facing a repetitive task, we can achieve an optimal editing strategy by making both the motion and the change repeatable.
> 
> Whenever Vim makes it easy to repeat an action or a motion, it always provides some way of backing out in case we accidentally go too far. It always helps to know where the reverse gear is.
