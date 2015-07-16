=======================================================
Windows Server 情報採取ツール
Ver:0.3  
Date: 2015.07.16
Copyright(c) 2015 INNOVACTORY INC. ALL Rights Reserved.
=======================================================

【機能概要】
OS基本情報を採取するツールです。
実行後に同フォルダ内にOS基本情報を
「server-info_YYYYYMMDD-HHMMSS.log」に出力します。

(1)zipファイルを解答

(2)管理者権限でコマンドプロンプトを起動

(3)zipファイルを解答したフォルダ内まで移動

> cd <解答したフォルダ>

(4)server-info.batを管理者権限を実行

> server-info.bat

同フォルダ内に「server-info_YYYYYMMDD-HHMMSS.log」が作成されます。


※以下のセキュリティ警告が表示される場合は「R」を入力して実行してください。

信頼するスクリプトのみを実行してください。インターネットから入手したスクリプト
は便利ですが、コンピューターに危害を及ぼす可能性があります。C:\Users\Administra
tor\Desktop\tools\server_info.ps1 を実行しますか?
[D] 実行しない(D)  [R] 一度だけ実行する(R)  [S] 中断(S)  [?] ヘルプ
(既定値は "D"):R

