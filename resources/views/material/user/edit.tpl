{include file='user/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">アカウント設定</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">

            <div class="col-xx-12 col-sm-6">
                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">サーバーの接続パスワードの変更</div>
                                    <button class="btn btn-flat" id="ss-pwd-update"><span class="icon">check</span>&nbsp;</button>
                                </div>

                                <p>現在のパスワード：<code id="ajax-user-passwd">{$user->passwd}</code>
                                    <button class="kaobei copy-text btn btn-subscription" type="button" data-clipboard-text="{$user->passwd}">
                                        コピー
                                    </button>
                                </p>
                                <!--<div class="form-group form-group-label">
                                    <label class="floating-label" for="sspwd">新连接密码</label>
                                    <input class="form-control maxwidth-edit" id="sspwd" type="text">
                                </div>
                                <br>-->
                                <p>セキュリティの安全の観点からパスワードを任意に設定することはできません。</p>
                                <p>チェックマークボタンを押すことでランダムに生成されます（一度生成したらページを更新するまで再度生成できません）</p>
                                <p>パスワードを変更したら適時Shadowsocksクライアントからパスワードを更新してください。</p>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="card-heading">クライアント設定</div>
                                <p>Shadowsocks/ShadowsocksD/ShadowsocksR、それぞれ設定できる暗号化方式、プラグインが違います。</p>
                                <p>使用したいクライアントを選択して暗号化方式とプロトコル、プラグインを設定してください</p>
                                <br>
                                <button class="btn btn-subscription" type="button" id="filter-btn-ss">SS/SSD</button>
                                <button class="btn btn-subscription" type="button" id="filter-btn-ssr">SSR</button>
                                <button class="btn btn-subscription" type="button" id="filter-btn-universal">決定</button>
                            </div>
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">暗号化方式</div>
                                    <button class="btn btn-flat" id="method-update"><span class="icon">check</span>&nbsp</button>
                                </div>
                                <p>
                                    現在の暗号化方式：<code id="ajax-user-method" data-default="method">[{if URL::CanMethodConnect($user->method) == 2}SS/SSD{else}SS/SSR{/if}で使用可能] {$user->method}</code>
                                </p>
                                <div class="form-group form-group-label control-highlight-custom dropdown">
                                    <label class="floating-label" for="method">暗号化方式</label>
                                    <button id="method" class="form-control maxwidth-edit" data-toggle="dropdown"
                                            value="{$user->method}"></button>
                                    <ul class="dropdown-menu" aria-labelledby="method">
                                        {$method_list = $config_service->getSupportParam('method')}
                                        {foreach $method_list as $method}
                                            <li class="{if URL::CanMethodConnect($user->method) == 2}filter-item-ss{else}filter-item-universal{/if}">
                                                <a href="#" class="dropdown-option" onclick="return false;"
                                                   val="{$method}"
                                                   data="method">[{if URL::CanMethodConnect($method) == 2}SS/SSD{else}SS/SSR{/if}
                                                    で使用可能] {$method}</a>
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>

                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">プロトコル・プラグイン設定</div>
                                    <button class="btn btn-flat" id="ssr-update"><span class="icon">check</span>&nbsp;</button>
                                </div>
                                <p>現在のプロトコル：<code id="ajax-user-protocol" data-default="protocol">[{if URL::CanProtocolConnect($user->protocol) == 3}SS/SSD/SSR{else}SSR{/if}で使用可能] {$user->protocol}</code></p>
                                <div class="form-group form-group-label control-highlight-custom dropdown">
                                    <label class="floating-label" for="protocol">プロトコル</label>
                                    <button id="protocol" class="form-control maxwidth-edit" data-toggle="dropdown"
                                            value="{$user->protocol}"></button>
                                    <ul class="dropdown-menu" aria-labelledby="protocol">
                                        {$protocol_list = $config_service->getSupportParam('protocol')}
                                        {foreach $protocol_list as $protocol}
                                            <li class="{if URL::CanProtocolConnect($protocol) == 3}filter-item-universal{else}filter-item-ssr{/if}">
                                                <a href="#" class="dropdown-option" onclick="return false;" val="{$protocol}" data="protocol">
                                                    [{if URL::CanProtocolConnect($protocol) == 3}SS/SSD/SSR{else}SSR{/if}
                                                    で使用可能] {$protocol}
                                                </a>
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>

                            </div>

                            <div class="card-inner">
                                <p>現在のプラグイン：<code id="ajax-user-obfs" data-default="obfs">[{if URL::CanObfsConnect($user->obfs) >= 3}SS/SSD/SSR{elseif URL::CanObfsConnect($user->obfs) == 1}SSR{else}SS/SSD{/if}で使用可能] {$user->obfs}</code></p>
                                <p>SS/SSDとSSRで使用できるプラグインが違います。simple_obfs_* はSS/SSD のプラグインです。それ以外はSSRのプラグインです。</p>
                                <div class="form-group form-group-label control-highlight-custom dropdown">
                                    <label class="floating-label" for="obfs">プラグイン設定</label>
                                    <button id="obfs" class="form-control maxwidth-edit" data-toggle="dropdown" value="{$user->obfs}"></button>
                                    <ul class="dropdown-menu" aria-labelledby="obfs">
                                        {$obfs_list = $config_service->getSupportParam('obfs')}
                                        {foreach $obfs_list as $obfs}
                                            <li class="{if URL::CanObfsConnect($obfs) >= 3}filter-item-universal{else}{if URL::CanObfsConnect($obfs) == 1}filter-item-ssr{else}filter-item-ss{/if}{/if}">
                                                <a href="#" class="dropdown-option" onclick="return false;" val="{$obfs}" data="obfs">
                                                    [{if URL::CanObfsConnect($obfs) >= 3}SS/SSD/SSR{else}{if URL::CanObfsConnect($obfs) == 1}SSR{else}SS/SSD{/if}{/if}で使用可能] {$obfs}
                                                </a>
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>

                            <div class="card-inner">
                                <p>現在のプロトコルパラメーター：<code id="ajax-user-obfs-param">{$user->obfs_param}</code></p>
                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="obs-param">必要に応じてパラメーターを設定してください</label>
                                    <input class="form-control maxwidth-edit" id="obfs-param" type="text">
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

            </div>


            <div class="col-xx-12 col-sm-6">

                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">アカウントのログインパスワードの設定</div>
                                    <button class="btn btn-flat" id="pwd-update"><span class="icon">check</span>&nbsp;
                                    </button>
                                </div>
                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="oldpwd">現在のパスワードを入力</label>
                                    <input class="form-control maxwidth-edit" id="oldpwd" type="password">
                                </div>

                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="pwd">新しいパスワード</label>
                                    <input class="form-control maxwidth-edit" id="pwd" type="password">
                                </div>

                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="repwd">新しいパスワードの確認</label>
                                    <input class="form-control maxwidth-edit" id="repwd" type="password">
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">IPのブロック解除</div>
                                    <button class="btn btn-flat" id="unblock"><span class="icon">not_interested</span>&nbsp;
                                    </button>
                                </div>
                                <p>現在の状態：<code id="ajax-block">{$Block}</code></p>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">メール受信設定</div>
                                    <button class="btn btn-flat" id="mail-update"><span class="icon">check</span>&nbsp;
                                    </button>
                                </div>
                                <p class="card-heading"></p>
                                <p>現在の設定：<code id="ajax-mail" data-default="mail">{if $user->sendDailyMail==1}受信する{else}受信しない{/if}</code></p>
                                <div class="form-group form-group-label control-highlight-custom dropdown">
                                    <label class="floating-label" for="mail">受信設定</label>
                                    <button type="button" id="mail" class="form-control maxwidth-edit"
                                            data-toggle="dropdown" value="{$user->sendDailyMail}"></button>
                                    <ul class="dropdown-menu" aria-labelledby="mail">
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="1"
                                               data="mail">受信する</a></li>
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="0"
                                               data="mail">受信しない</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">連絡先の設定</div>
                                    <button class="btn btn-flat" id="wechat-update"><span class="icon">check</span>&nbsp;
                                    </button>
                                </div>
                                <p>連絡先の設定：
                                    <code id="ajax-im" data-default="imtype">
                                        {if $user->im_type==1}WeChat{/if}
                                        {if $user->im_type==2}QQ{/if}
                                        {if $user->im_type==3}Google+{/if}
                                        {if $user->im_type==4}Telegram{/if}
                                        {if $user->im_type==5}Discord{/if}
                                    </code>
                                </p>
                                <p>連絡先のユーザー名：
                                    <code>{$user->im_value}</code>
                                </p>
                                <div class="form-group form-group-label control-highlight-custom dropdown">
                                    <label class="floating-label" for="imtype">連絡先を選択してください</label>
                                    <button class="form-control maxwidth-edit" id="imtype" data-toggle="dropdown"
                                            value="{$user->im_type}"></button>
                                    <ul class="dropdown-menu" aria-labelledby="imtype">
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="1"
                                               data="imtype">WeChat</a></li>
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="2"
                                               data="imtype">QQ</a></li>
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="3"
                                               data="imtype">Facebook</a></li>
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="4"
                                               data="imtype">Telegram</a></li>
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="5"
                                               data="imtype">Discord</a></li>
                                    </ul>
                                </div>

                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="wechat">連絡先のユーザー名を入力してください</label>
                                    <input class="form-control maxwidth-edit" id="wechat" type="text">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <p class="card-heading">二段階認証</p>
                                <p>Google認証システムアプリを使用してQRコードをスキャンしてください</p>
                                <p><i class="icon icon-lg" aria-hidden="true">android</i><a
                                            href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2">&nbsp;Android</a>
                                </p>
                                <p><i class="icon icon-lg" aria-hidden="true">tablet_mac</i><a
                                            href="https://itunes.apple.com/cn/app/google-authenticator/id388497605?mt=8">&nbsp;iOS</a>
                                </p>
                                <p>設定が完了するまで完了ボタンを押さないでください。</p>
                                <p>現在の設定：<code data-default="ga-enable">{if $user->ga_enable==1} 使用する {else} 使用しない {/if}</code>
                                </p>
                                <p>現在の時刻：{date("Y-m-d H:i:s")}</p>
                                <div class="form-group form-group-label control-highlight-custom dropdown">
                                    <label class="floating-label" for="ga-enable">二段階認証設定</label>
                                    <button type="button" id="ga-enable" class="form-control maxwidth-edit"
                                            data-toggle="dropdown" value="{$user->ga_enable}"></button>
                                    <ul class="dropdown-menu" aria-labelledby="ga-enable">
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="0"
                                               data="ga-enable">使用しない</a></li>
                                        <li><a href="#" class="dropdown-option" onclick="return false;" val="1"
                                               data="ga-enable">使用する</a></li>
                                    </ul>
                                </div>

                                <div class="form-group form-group-label">
                                    <div class="text-center">
                                        <div id="ga-qr" class="qr-center"></div>
                                        トークン：{$user->ga_token}
                                    </div>
                                </div>

                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="code">テスト用コード</label>
                                    <input type="text" id="code" placeholder="二段階認証コードを入力してください"
                                           class="form-control maxwidth-edit">
                                </div>

                            </div>
                            <div class="card-action">
                                <div class="card-action-btn pull-left">
                                    <a class="btn btn-brand-accent btn-flat waves-attach" href="/user/gareset"><span
                                                class="icon">format_color_reset</span>&nbsp;リセット</a>
                                    <button class="btn btn-flat waves-attach" id="ga-test"><span
                                                class="icon">extension</span>&nbsp;テスト
                                    </button>
                                    <button class="btn btn-brand btn-flat waves-attach" id="ga-set"><span class="icon">perm_data_setting</span>&nbsp;設定する
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {if $config['port_price']>=0 || $config['port_price_specify']>=0}
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                {if $config['port_price']>=0}
                                    <div class="card-inner">
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">ポートのリセット</div>
                                            <button class="btn btn-flat" id="portreset"><span
                                                        class="icon">autorenew</span>&nbsp;
                                            </button>
                                        </div>
                                        <p>对号码不满意？来摇号吧～！</p>
                                        <p>随机更换一个端口使用，价格：<code>{$config['port_price']}</code>元/次</p>
                                        <p>重置后 1 分钟内生效</p>
                                        <p>当前端口：<code id="ajax-user-port">{$user->port}</code></p>
                                    </div>
                                {/if}

                                {if $config['port_price_specify']>=0}
                                    <div class="card-inner">
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">钦定端口</div>
                                            <button class="btn btn-flat" id="portspecify"><span
                                                        class="icon">call_made</span>&nbsp;
                                            </button>
                                        </div>
                                        <p>不想摇号？来钦定端口吧～！</p>
                                        <p>价格：<code>{$config['port_price_specify']}</code>元/次</p>
                                        <p>端口范围：<code>{$config['min_port']}～{$config['max_port']}</code></p>
                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="port-specify">在这输入想钦定的端口号</label>
                                            <input class="form-control maxwidth-edit" id="port-specify" type="num">
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/if}

                {if $config['enable_telegram'] == 'true' || $config['enable_discord'] == 'true'}
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    {if $user->telegram_id != 0}
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">Telegram 绑定</div>
                                            <div><a class="btn btn-flat btn-brand-accent"
                                                    href="/user/telegram_reset"><span class="icon">not_interested</span>&nbsp;</a>
                                            </div>
                                        </div>
                                    {/if}
                                    {if $user->discord != 0}
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">Discord 绑定</div>
                                            <div>
                                                <a class="btn btn-flat btn-brand-accent" href="/user/discord_reset">
                                                <span class="icon">not_interested</span>&nbsp;
                                                </a>
                                            </div>
                                        </div>
                                    {/if}

                                    {if $user->telegram_id == 0 || $user->discord == 0}
                                        <p>复制保存下方的二维码图片（有效期10分钟，超时请刷新本页面以重新获取，每张二维码只能使用一次）</p>
                                        {if $user->telegram_id == 0}
                                            <p>私聊发给 Telegram 机器人 <a href="https://t.me/{$telegram_bot}">@{$telegram_bot}</a> 以绑定
                                                Telegram</p>
                                        {/if}
                                        {if $user->discord == 0}
                                            <p>私聊发给 Discord 机器人 以绑定 Discord</p>
                                        {/if}
                                    {/if}
                                    <div class="form-group form-group-label">
                                        <div class="text-center">
                                            <div id="telegram-qr" class="qr-center"></div>
                                            {if $user->telegram_id != 0}
                                                <p>当前绑定Telegram账户：<a href="https://t.me/{$user->im_value}">@{$user->im_value}</a>
                                                </p>
                                            {/if}
                                            {if $user->discord != 0}
                                                <p>当前绑定Telegram账户：{$user->im_value}</p>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}

                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">テーマの切り替え(WIP)</div>
                                    <button class="btn btn-flat" id="theme-update"><span class="icon">check</span>&nbsp;
                                    </button>
                                </div>
                                <p>現在のテーマ：<code data-default="theme">{$user->theme}</code></p>
                                <div class="form-group form-group-label control-highlight-custom dropdown">
                                    <label class="floating-label" for="theme">テーマ</label>
                                    <button id="theme" type="button" class="form-control maxwidth-edit" data-toggle="dropdown" value="{$user->theme}">

                                    </button>
                                    <ul class="dropdown-menu" aria-labelledby="mail">
                                        {foreach $themes as $theme}
                                            <li>
                                                <a href="#" class="dropdown-option" onclick="return false;"
                                                   val="{$theme}" data="theme">{$theme}</a>
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {include file='dialog.tpl'}

        </section>
    </div>
</main>


{include file='user/footer.tpl'}

<script>
    $(function () {
        new Clipboard('.copy-text');
    });

    $(".copy-text").click(function () {
        $("#result").modal();
        $$.getElementById('msg').innerHTML = 'クリップボードにコピーされました。';
    });
</script>

{literal}
<script>
    /*
     * 筛选 SS/SSR 加密、混淆和协议的选项
     *
     * 引入三个按钮：
     * #filter-btn-ss 筛选 SS，点击以后隐藏 .filter-item-ssr，显示 .filter-item-ss 和 .filter-item-universal
     * #filter-btn-ssr 筛选 SSR，点击以后隐藏 .filter-item-ss，显示 .filter-item-ssr 和 .filter-item-universal
     * #filter-btn-universal 筛选必须同时兼容两者的，点击以后隐藏 .filter-item-ss 和 .filter-item-ssr，显示 .filter-item-universal
     *
     * 引入函数 hideFilterItem(itemType) 和 showFilterItem(itemType)，参数 item 可以是 ss ssr universal。
     */
    (() => {
        const hideFilterItem = (itemType) => {
            for (let i of $$.getElementsByClassName(`filter-item-${itemType}`)) {
                i.style.display = 'none';
            }
        };
        const showFilterItem = (itemType) => {
            for (let i of $$.getElementsByClassName(`filter-item-${itemType}`)) {
                i.style.display = 'block';
            }
        };

        const chooseSS = () => {
            hideFilterItem('ssr');
            showFilterItem('ss');
            showFilterItem('universal');
        };

        const chooseSSR = () => {
            hideFilterItem('ss');
            showFilterItem('ssr');
            showFilterItem('universal');
        };

        const chooseUniversal = () => {
            hideFilterItem('ss');
            hideFilterItem('ssr');
            showFilterItem('universal');
        };

        $$.getElementById('filter-btn-ss').addEventListener('click', chooseSS);
        $$.getElementById('filter-btn-ssr').addEventListener('click', chooseSSR);
        $$.getElementById('filter-btn-universal').addEventListener('click', chooseUniversal);
    })();
</script>
{/literal}

{literal}
<script>
    $(document).ready(function () {
        $("#portreset").click(function () {
            $.ajax({
                type: "POST",
                url: "resetport",
                dataType: "json",
                data: {},
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-user-port').innerHTML = data.msg;
                        $$.getElementById('msg').innerHTML = `新しいポート番号: ${
                                data.msg
                                }`;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } エラーが発生しました`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#portspecify").click(function () {
            $.ajax({
                type: "POST",
                url: "specifyport",
                dataType: "json",
                data: {
                    port: $$getValue('port-specify')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-user-port').innerHTML = $$getValue('port-specify');
                        $$.getElementById('msg').innerHTML = data.msg;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } エラーが発生しました`;
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#setpac").click(function () {
            $.ajax({
                type: "POST",
                url: "pacset",
                dataType: "json",
                data: {
                    pac: $("#pac").text()
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } エラーが発生しました`;
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "password",
                dataType: "json",
                data: {
                    oldpwd: $$getValue('oldpwd'),
                    pwd: $$getValue('pwd'),
                    repwd: $$getValue('repwd')
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } エラーが発生しました`;
                }
            })
        })
    })
</script>
{/literal}
<script>
    var ga_qrcode = '{$user->getGAurl()}',
            qrcode1 = new QRCode(document.getElementById("ga-qr"));

    qrcode1.clear();
    qrcode1.makeCode(ga_qrcode);

    {if $config['enable_telegram'] == 'true' || $config['enable_discord'] == 'true'}

    var telegram_qrcode = 'mod://bind/{$bind_token}';

    if ($$.getElementById("telegram-qr")) {
        let qrcode2 = new QRCode(document.getElementById("telegram-qr"));
        qrcode2.clear();
        qrcode2.makeCode(telegram_qrcode);
    }

    {/if}
</script>

{literal}
<script>
    $(document).ready(function () {
        $("#wechat-update").click(function () {
            $.ajax({
                type: "POST",
                url: "wechat",
                dataType: "json",
                data: {
                    wechat: $$getValue('wechat'),
                    imtype: $$getValue('imtype')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-im').innerHTML = `${$("#imtype").find("option:selected").text()} ${$$getValue('wechat')}`
                        $$.getElementById('msg').innerHTML = data.msg;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} エラーが発生しました`;
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#ssr-update").click(function () {
            $.ajax({
                type: "POST",
                url: "ssr",
                dataType: "json",
                data: {
                    protocol: $$getValue('protocol'),
                    obfs: $$getValue('obfs'),
                    obfs_param: $$getValue('obfs-param')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-user-protocol').innerHTML = $$getValue('protocol');
                        $$.getElementById('ajax-user-obfs').innerHTML = $$getValue('obfs');
                        $$.getElementById('ajax-user-obfs-param').innerHTML = $$getValue('obfs-param');
                        $$.getElementById('msg').innerHTML = data.msg;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} エラーが発生しました`;
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#relay-update").click(function () {
            $.ajax({
                type: "POST",
                url: "relay",
                dataType: "json",
                data: {
                    relay_enable: $$getValue('relay_enable'),
                    relay_info: $$getValue('relay_info')
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} エラーが発生しました`;
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        $("#unblock").click(function () {
            $.ajax({
                type: "POST",
                url: "unblock",
                dataType: "json",
                data: {},
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-block').innerHTML = `IP：${
                                data.msg
                                } ブロックされていません`;
                        $$.getElementById('msg').innerHTML = `IP：${
                                data.msg
                                } ブロック解除されました`;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} エラーが発生しました`;
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#ga-test").click(function () {
            $.ajax({
                type: "POST",
                url: "gacheck",
                dataType: "json",
                data: {
                    code: $$getValue('code')
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} エラーが発生しました`;
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#ga-set").click(function () {
            $.ajax({
                type: "POST",
                url: "gaset",
                dataType: "json",
                data: {
                    enable: $$getValue('ga-enable')
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} エラーが発生しました`;
                }
            })
        })
    })
</script>

<script>
    $(document).ready(function () {
        let newsspwd = Math.random().toString(36).substr(2);
        $("#ss-pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "sspwd",
                dataType: "json",
                data: {
                    sspwd: newsspwd
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-user-passwd').innerHTML = newsspwd;
                        $$.getElementById('msg').innerHTML = '設定が保存されました';
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = '設定に失敗しました';
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} エラーが発生しました`;
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#mail-update").click(function () {
            $.ajax({
                type: "POST",
                url: "mail",
                dataType: "json",
                data: {
                    mail: $$getValue('mail')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-mail').innerHTML = ($$getValue('mail') === '1') ? '受信する' : '受信しない'
                        $$.getElementById('msg').innerHTML = data.msg;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} エラーが発生しました`;
                }
            })
        })
    })
</script>
{/literal}
<script>
    $(document).ready(function () {
        $("#theme-update").click(function () {
            $.ajax({
                type: "POST",
                url: "theme",
                dataType: "json",
                data: {
                    theme: $$getValue('theme')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href='/user/edit'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
{literal}
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } エラーが発生しました`;
                }
            })
        })
    })
</script>


<script>
    $(document).ready(function () {
        $("#method-update").click(function () {
            $.ajax({
                type: "POST",
                url: "method",
                dataType: "json",
                data: {
                    method: $$getValue('method')
                },
                success: (data) => {
                    $$.getElementById('ajax-user-method').innerHTML = $$getValue('method');
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = '設定が保存されました';
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } エラーが発生しました`;
                }
            })
        })
    })
</script>
{/literal}
