# Shopify Web Components

# Overview

Re:do optionally provides free return shipping to customers that purchase the
Re:do Shopify product with their order.

To enable customers to purchase returns coverage, Re:do offers frontend
integration via
[Web Components custom elements](https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements).

# Functionality

Re:do displays a checkbox on the product detail page. Re:do’s backend merchant
configuration can optionally exclude certain customers or products.

When the customer adds a product to the cart and the Re:do checkbox is enabled,
the Re:do product is also added to the cart.

Only one Re:do product should be added to the cart. Once it has been added to
the cart, the checkbox is hidden.

# Install

Add the following script:

```jsx
<script
  async
  src="https://shopify-extension.getredo.com/web-components.js?widget_id=<widget_id>"
></script>
```

The parameter `widget_id` is an alphanumeric identifier corresponding to the
merchant.

# Elements

## redo-shopify-checkbox

### Attributes

- **context-product-id**: Sets contextProductId property.
- **customer-id:** Sets customerId property.
- **in-cart:** Sets inCart property. \*\*

### Properties

- **contextProductId** (`number | undefined`): ID of the current product,
  defaults to undefined.
- **customerId** (`number | undefined` ): ID of the current customer, defaults
  to undefined.
- **inCart** (`boolean`): Whether Re:do is in the cart, defaults to false.
- **value** (`boolean | undefined` , read-only): Selected state, or undefined if
  not initialized.
- **variantId** (`number | undefined`, read-only): ID of the Re:do product
  variant, or undefined if not initialized.

### Events

- **init** (Event): Fired when Re:do has initialized.
- **change** (Event)**:** Fired when the value of the checkbox has changed after
  initialization.

# Guide

1. Install the Re:do script.
2. Add `<redo-shopify-checkbox></redo-shopify-checkbox>` to the page, usually
   underneath the “Add to Cart” button.
3. Optionally, specify the current customer and product ID.
4. Whenever the init event is fired, check for the existence of the Re:do
   variant in the cart.
5. Whenever a product is added to the cart, inspect the value of the Re:do
   checkbox, and add the Re:do product if applicable.
6. Maintain the inCart property to reflect whether Re:do is in the cart.

# Example

The example is representative; there may be preferable patterns for integrating
with your UI framework.

```html
<script
  async
  src="https://shopify-extension.getredo.com/web-component.js?widget_id=<widget_id>"
></script>

<button id="add-to-cart" type="button">Add to Cart</button>

<redo-shopify-checkbox
  context-product-id="123"
  customer-id="456"
  id="redo"
></redo-shopify-checkbox>
```

```jsx
const addToCart = document.getElementById("add-to-cart");

const redo = document.getElementById("redo");

const redoInCart = (cart) => {
  return cart.items.some((item) => item.variantId == redo.variantId);
};

redo.addEventListener("init", async (e) => {
  const cart = await getCart();
  redo.inCart = redoInCart(cart);
});

addToCart.addEventListener("click", async () => {
  const cart = await getCart();
  cart.items.push({
    quantity: selectedQuantity(),
    variantId: selectedVariantId(),
  });
  if (redo.value && !redoInCart(cart)) {
    cart.items.push({ quantity: 1, variantId: redo.variantId });
    redo.inCart = true;
  }
  await setCart(cart);
});
```

# Demos

See https://github.com/redoapp/redo-examples.
