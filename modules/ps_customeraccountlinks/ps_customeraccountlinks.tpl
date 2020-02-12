<div id="block_myaccount_infos" class="customer">
    <a href="{$urls.pages.my_account}" title="{l s='Your account' d='Shop.Theme.Customeraccount'}" rel="nofollow">
        <img src="{$urls.base_url}/themes/eterestudio/assets/img/user_icon.png" alt="{$shop.name}" class="icon-layout {if isset($customer)} customer-logged {/if}">
    </a>
    <span class="customer-username">{$customer.firstname}</span>
</div>
