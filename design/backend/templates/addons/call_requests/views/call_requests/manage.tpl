{script src="js/addons/call_requests/bulk_edit.js"}

{capture name="mainbox"}

<form action="{""|fn_url}" method="post" name="manage_call_requests_form" class="form-horizontal form-edit cm-ajax" id="manage_call_requests_form">
<input type="hidden" name="result_ids" value="pagination_contents,tools_call_request_buttons" />

{include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id=$smarty.request.content_id}

{assign var="return_url" value=$config.current_url|escape:"url"}
{assign var="c_url" value=$config.current_url|fn_query_remove:"sort_by":"sort_order"}

{assign var="rev" value=$smarty.request.content_id|default:"pagination_contents"}
{include_ext file="common/icon.tpl" class="icon-`$search.sort_order_rev`" assign=c_icon}
{include_ext file="common/icon.tpl" class="icon-dummy" assign=c_dummy}


{if $call_requests}
    {capture name="call_requests_table"}
        <div class="table-responsive-wrapper longtap-selection">
            <table width="100%" class="table table-middle table-responsive">
            <thead
                    data-ca-bulkedit-default-object="true"
                    data-ca-bulkedit-component="defaultObject"
            >
                <tr>
                    <th class="left table__check-items-column">
                        {include file="common/check_items.tpl" check_statuses=$call_request_statuses meta="table__check-items"}

                        <input type="checkbox"
                               class="bulkedit-toggler hide"
                               data-ca-bulkedit-disable="[data-ca-bulkedit-default-object=true]"
                               data-ca-bulkedit-enable="[data-ca-bulkedit-expanded-object=true]"
                        />
                    </th>
                    <th width="10%">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("id")}{if $search.sort_by == "id"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    <th width="30%">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("date")}{if $search.sort_by == "date"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>
                    <th width="30%">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=name&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("call_requests.person_name_and_phone")}{if $search.sort_by == "name"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>
                    <th width="25%">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=order&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("order")}{if $search.sort_by == "order"}{$c_icon nofilter}{/if}</a>
                        /
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=order_status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by == "order_status"}{$c_icon nofilter}{/if}</a>
                    </th>
                    <th width="10%">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=user&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("call_requests.responsible")}{if $search.sort_by == "user"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>
                    <th>&nbsp;</th>
                    <th width="10%" class="right">
                        <a class="cm-ajax" href="{"`$c_url`&sort_by=status&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status")}{if $search.sort_by == "status"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a>
                    </th>
                </tr>
            </thead>
            {foreach $call_requests as $request}
                <tbody class="cm-row-item cm-row-status-{$request.status|lower} cm-longtap-target"
                       data-ca-longtap-action="setCheckBox"
                       data-ca-longtap-target="input.cm-item"
                       data-ca-id="{$request.request_id}"
                >
                    <tr>
                        <td class="left mobile-hide table__check-items-cell">
                            <input type="checkbox" name="request_ids[]" value="{$request.request_id}" class="cm-item cm-item-status-{$request.status|lower} hide" />
                        </td>
                        <td data-th="{__("id")}">
                            {$request.request_id}
                            {include file="views/companies/components/company_name.tpl" object=$request}
                        </td>
                        <td data-th="{__("date")}">{$request.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</td>
                        <td data-th="{__("call_requests.person_name_and_phone")}">
                            {if $request.name}
                                <strong>{$request.name}</strong><br>
                            {else}
                                <div>
                                    <i>{__("call_requests.no_name_specified")}</i>
                                </div>
                            {/if}
                            <span><bdi><a href="tel:{$request.phone}">{$request.phone}</a></bdi></span>
                        </td>
                        <td data-th="{__("order")}" class="nowrap">
                            <div class="cr-table-status">
                                <input type="text" name="call_requests[{$request.request_id}][order_id]" size="3" value="{if {$request.order_id}}{$request.order_id}{/if}" class="input-mini input-hidden right" />
                                {if $request.order_id}
                                    / <a href="{fn_url("orders.details?order_id={$request.order_id}")}">{$order_statuses[$request.order_status].description}</a>
                                {/if}
                            </div>
                        </td>
                        <td data-th="{__("call_requests.responsible")}">
                            <select name="call_requests[{$request.request_id}][user_id]" class="input-medium input-hidden">
                                <option> -- </option>
                                {foreach $responsibles as $user_id => $name}
                                    <option value="{$user_id}"{if $user_id == $request.user_id} selected="selected"{/if}>{$name}</option>
                                {/foreach}
                            </select>
                        </td>
                        <td class="nowrap">
                            <div class="hidden-tools">
                                {capture name="tools_list"}
                                    <li>{btn type="list" text=__("delete") href="call_requests.delete?request_id=`$request.request_id`" class="cm-confirm" method="POST"}</li>
                                {/capture}
                                {dropdown content=$smarty.capture.tools_list}
                            </div>
                        </td>
                        <td data-th="{__("status")}" class="right nowrap">
                            <div id="call_requests_status_{$request.request_id}">
                                {include file="common/select_popup.tpl" popup_additional_class="dropleft" id=$request.request_id status=$request.status update_controller="call_requests" items_status=$call_request_statuses btn_meta="btn btn-info btn-small cr-btn-status-{$request.status}"|lower extra="&return_url={$return_url}" st_result_ids="call_requests_status_{$request.request_id}"}
                            <!--call_requests_status_{$request.request_id}--></div>
                        </td>
                    </tr>
                    <tr class="cr-table-detail">
                        <td class="mobile-hide">&nbsp;</td>
                        <td colspan="3" valign="top" {if !$request.product_id && !$request.cart_products}class="mobile-hide"{/if}>
                            {if $request.product_id}
                                <div>
                                    <span>{__("call_requests.requested_product")}:</span><br>
                                    <a href="{fn_url("products.update?product_id={$request.product_id}")}">{$request.product}</a>
                                </div>
                            {/if}
                            {if $request.cart_products}
                                <div>
                                    <button type="button"
                                        class="cm-combination cr-switch"
                                        id="sw_call_req_{$request.request_id}"
                                    >
                                        {__("products_in_cart")}
                                    </button>
                                    {include_ext file="common/icon.tpl"
                                        class="icon-caret-down cm-combination"
                                        id="on_call_req_`$request.request_id`"
                                    }
                                    {include_ext file="common/icon.tpl"
                                        class="icon-caret-up cm-combination hidden"
                                        id="off_call_req_`$request.request_id`"
                                    }
                                </div>
                            {/if}
                        </td>

                        <td colspan="3" valign="top" class="noborder--mobile cr-table-products-note">
                            <textarea name="call_requests[{$request.request_id}][notes]" class="input-hidden" cols="20" rows="3" placeholder="{__("call_requests.notes")}">{$request.notes}</textarea>
                            <div class="cr-time">
                                <span>{__("call_requests.convenient_time")}:</span>
                                <span>{$request.time_from|default:"09:00"}</span> - <span>{$request.time_to|default:"20:00"}</span>
                            </div>
                        </td>

                        <td class="mobile-hide">&nbsp;</td>
                    </tr>
                    {if $request.cart_products}
                        <tr id="call_req_{$request.request_id}" class="hidden cr-table-products">
                            <td class="mobile-hide">&nbsp;</td>
                            <td colspan="6" class="cr-table-products__body">
                                <div class="table-responsive-wrapper">
                                    <table width="100%" class="table table-middle table-responsive table-rq-products">
                                        <thead>
                                            <tr>
                                                <th>{__("product")}</th>
                                                <th class="nowrap center" width="10%">{__("quantity")}</th>
                                                <th class="right" width="20%">{__("price")}</th>
                                            </tr>
                                        </thead>
                                        {foreach $request.cart_products as $product}
                                            <tr>
                                                <td data-th="{__("product")}">
                                                    <a href="{fn_url("products.update?product_id={$product.product_id}")}">{$product.product}</a>
                                                </td>
                                                <td data-th="{__("quantity")}" class="center">{$product.amount}</td>
                                                <td data-th="{__("price")}" class="right">{include file="common/price.tpl" value=$product.price}</td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                </div>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    {/if}
                </tbody>
            {/foreach}
            </table>
        </div>
    {/capture}

    {include file="common/context_menu_wrapper.tpl"
        form="manage_call_requests_form"
        object="call_requests"
        items=$smarty.capture.call_requests_table
    }
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{capture name="buttons"}
    {if $call_requests}
        {include file="buttons/save.tpl" but_name="dispatch[call_requests.m_update]" but_role="submit-link" but_target_form="manage_call_requests_form"}
    {/if}
{/capture}

<div class="clearfix">
    {include file="common/pagination.tpl" div_id=$smarty.request.content_id}
</div>

</form>
{/capture}

{capture name="sidebar"}
    {include file="common/saved_search.tpl" dispatch="call_requests.manage" view_type="call_requests"}
    {include file="addons/call_requests/views/call_requests/components/requests_search_form.tpl" dispatch="call_requests.manage"}
{/capture}

{include file="common/mainbox.tpl" title=__("call_requests") content=$smarty.capture.mainbox buttons=$smarty.capture.buttons sidebar=$smarty.capture.sidebar content_id="call_request"}
