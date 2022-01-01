# <h1 align="center"> Reverse Liquidity Split (RLS) </h1> 
### <p align="center"> (Implementation) </p>

## Idea

The **Reverse Liquidity Split** is inspired by the [Reverse Stock Split](https://www.investopedia.com/terms/r/reversesplit.asp).<br>
In TradFi, a company can consolidates the number of existing shares of stock into fewer (higher-priced) shares. This is usually a red flag, but 
there are advantages in terms of regulations/policies.

In DeFi, It seems completely unnecessary to divide the balance of every holders...

**Unless we only apply this mechanism on a liquidity pool** 🤔

## How it work?

We have the *$REV* token with some liquidity on Uniswap V2.<br>
**Liquidity =>** 1000 *$REV* / 1000 *$USDC*<br>
**Price =>** 1 *$REV* = 1 *$USDC*

If we start a 50% split (by calling the `split` token function), the smart contract will burn 50% of the UniswapV2Pair balance and call the `sync` function.

```javascript
 _burn(liquidityPool, liqAmount / divisor);

IUniswapV2Pair(liquidityPool).sync();
```

After that, we have in liquidity : 500 *$REV* and 1000 *$USDC*. This will change the price!<br>
**1 *$REV* = 2 *$USDC*. This is a 100% increase.**

## Conclusion

Great ! Your token is pumping. **But never forget that :**
- This is not a real solution (rather a red flag).
- It will increase volatility.

## Run the project

### Build project
```
forge build
```

### Run tests

```
forge test --fork-url https://eth-mainnet.alchemyapi.io/v2/your-key
```

*Tests are targeting mainnet Uniswap V2 Router and Factory*

## Installing the toolkit

This project is using [Foundry](https://github.com/gakonst/foundry)

### Install Rust and Cargo
```
curl https://sh.rustup.rs -sSf | sh
```

### Install forge
```
cargo install --git https://github.com/gakonst/foundry --bin forge --locked
```