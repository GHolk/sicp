# scheme 直譯器
最簡單就直接裝 mit-scheme，
環境和 sicp 裡的差不多。
想實用一點可以裝 guile 或 racket。
guile 是 gnu 的 scheme，
號稱要做 gnu 系程式的擴展腳本語言。
racket 則是最近很火的 scheme 魔改。

## mit-scheme
我一開始就是 mit-scheme，
直接 `apt install mit-scheme` 就好了。
之後 $PATH 裡就有 scheme 了。
可以在 emacs 裡 `M-x run-scheme`

## guile
這個裝完後只有 guile，
我自己 `ln -s /usr/bin/guile ~/.local/bin/scheme` ，
$PATH 裡有 scheme 才能用 `run-scheme` 。

之後發現一些列表操作沒有，
[查了一下文件，找到要手動載入 srfi 模組。][srfi]
`(use-modules (srfi srfi-1))` 即可載入 srfi-1，
也就是對列表的工具函數。
可以寫到 `~/.guile` 裡，讓 guile 啟動後自動執行。

[srfi]: https://www.gnu.org/software/guile/manual/html_node/About-SRFI-Usage.html#About-SRFI-Usage
