{if $return_info.extra.gift_certificates}
    <div class="control-group">
        <label class="control-label">{__("gift_certificates")}</label>
        <div class="controls">
        {assign var="return_current_url" value=$config.current_url|escape:"url"}
        {foreach from=$return_info.extra.gift_certificates item="gift_cert" key="gift_cert_key"}
            <div><a class="cm-post" href="{"gift_certificates.delete?gift_cert_id=`$gift_cert_key`&extra[return_id]=`$smarty.request.return_id`&return_url=`$return_current_url`"|fn_url}">{include_ext file="common/icon.tpl" class="icon-trash"}</a>&nbsp;<a class="text-button-link" href="{"gift_certificates.update?gift_cert_id=`$gift_cert_key`"|fn_url}">{$gift_cert.code}</a>&nbsp;({include file="common/price.tpl" value=$gift_cert.amount})</div>
        {/foreach}
        </div>
    </div>
{/if}
