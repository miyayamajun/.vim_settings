# .vim_settings

## 導入方法

### cloneする
`$ git clone git@github.com:miyayamajun/.vim_settings.git ~/.vim_settings`

### 初期設定
~/.vimrcに以下を追加する

```
if filereadable(expand('~/.vim_settings/.vimrc'))
    source ~/.vim_settings/.vimrc
endif
```

### neobundleをインストールする

```
$ cd ~/.vim_settings/bundle
$ git clone git@github.com:Shougo/neobundle.vim.git ./neobundle.vim
```

### NeoBundleInstallを実行
vimを立ちあげてコマンドを実行する

`:NeoBundleInstall`
