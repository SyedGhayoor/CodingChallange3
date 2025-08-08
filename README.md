# CodingChallange3
# Acme Widget Co - Basket System

This is a Ruby implementation of a shopping basket with:

- Product catalog
- Delivery charge rules
- Offers (e.g. "Buy one red widget, get the second half price")

## Example

```bash
ruby example.rb
```

## Assumptions

- Prices are in USD
- Offers are pluggable strategies
- Delivery is calculated after discounts

## Run Tests

Install RSpec if not already installed:

```bash
gem install rspec
```

Then run:

```bash
rspec
```