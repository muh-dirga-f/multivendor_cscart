{$have_supplier=false}
{foreach from=$order_info.products item="item"}
	{if $item.extra.supplier_id}
		{$have_supplier=true}
	{/if}
{/foreach}
{if $have_supplier}
    <li><a><input type="checkbox" name="notify_supplier" id="notify_supplier" value="Y" form="order_info_form" />
            {__("notify_supplier")}</a></li>
{/if}
