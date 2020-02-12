
<section>
  <div class="products">
  {assign "countNulls" 0}
  {while $countNulls < count($products)}
    {assign "cat_id" null}
    {assign "prodsToPrint" []}
    {foreach from=$products item="product" key="index"}
      {if $product != "null"}
        {if $cat_id == "null"}
          {assign "cat_id" $product.id_category_default}
        {/if}
        {if $cat_id==$product.id_category_default}
          {append "prodsToPrint" $product}
          {append "products" null index=$index}
          {assign "countNulls" $countNulls+1 }
        {/if} 
      {/if}
    {/foreach}
    
    {foreach from=$prodsToPrint item=item key=key }
      {if $key==0}
        {assign "cat_name" $item.category_default}
        <h2 class="collection-name ">{$cat_name}</h2>
        <div class="collection">
      {/if}
      <div class="collection-product {if $key % 2 !=0} collection-product-odd {/if}">
      {include file="catalog/_partials/miniatures/product.tpl" product=$item}
      {if $key ==0 }
        <div class="collection-product-flex-text">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque 
        laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto 
        beatae vitae dicta sunt explicabo.</div>
      {/if}
      </div>
    {/foreach}
    </div>
  {/while}
  </div>
</section>
