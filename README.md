# B

B言語からi386アセンブリを生成するコンパイラです。ソースは未実装です。

`src/` にCソース・ヘッダー・`lexer.l`・`parser.y`、`tests/` にテストを置きます。
必要なツールはCコンパイラ、flex、bison、GNU make 4.3以降です。

```sh
make          # Bをビルド（生成物はbuild/）
make clean    # 生成物を削除
make fclean   # 生成物とBを削除
make re       # 再ビルド
```
