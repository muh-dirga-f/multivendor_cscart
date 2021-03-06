{if $product_options}
    {foreach from=$product_options item=po}
        {$option_value = $po.value|trim}
        {if isset($option_value) && $option_value|strlen}
            {assign var="has_option" value=true}
            {break}
        {/if}
    {/foreach}

    {if $has_option}
        <strong>{__("options")}: </strong><br />
        {strip}
        <ul class="unstyled">
            {foreach from=$product_options item=po name=po_opt}
            
                {if ($po.option_type == "ProductOptionTypes::SELECTBOX"|enum || $po.option_type == "ProductOptionTypes::RADIO_GROUP"|enum || $po.option_type == "ProductOptionTypes::CHECKBOX"|enum) && !$po.value}
                    {continue}
                {/if}

                <li>
                    <strong>{$po.option_name}: </strong><bdi>{$po.variant_name}</bdi>

                    {if $oi.extra.custom_files[$po.option_id] || $cp.extra.custom_files[$po.option_id]}
                        {foreach from=$oi.extra.custom_files[$po.option_id] item="file" name="po_files"}
                            {assign var="filename" value=$file.name|rawurlencode}
                            <a href="{"orders.get_custom_file?order_id=`$order_info.order_id`&file=`$file.file`&filename=`$filename`"|fn_url}">{$file.name}</a>
                            {if !$smarty.foreach.po_files.last},&nbsp;{/if}
                        {foreachelse}
                            {foreach from=$cp.extra.custom_files[$po.option_id] item="file" name="po_files"}
                                {$file.name}
                                {if !$smarty.foreach.po_files.last},&nbsp;{/if}
                            {/foreach}
                        {/foreach}
                    {/if}

                    {if $settings.General.display_options_modifiers == "Y"}
                        {if $po.modifier|floatval}
                            &nbsp;<bdi>({include file="common/modifier.tpl" mod_type=$po.modifier_type mod_value=$po.modifier display_sign=true})</bdi>
                        {/if}
                    {/if}
                    {$option_displayed = true}
                </li>

            {/foreach}
        </ul>
        {/strip}
    {/if}
{else}
    &nbsp;
{/if}
