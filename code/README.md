## Introduction

SO3 is a decentralized Web3 social application with perpetual self-operation and negative feedback mechanism.

## Product Philosophy

After several rounds of market testing and reflection, we have summarized the following two basic laws of the crypto world:

- 1. The development of cryptocurrencies is still in its early stages, and the number of participants will continue to grow and expand, but very few projects can sustain through bull and bear markets.

- 2. Making money is the first priority for crypto participants.

Web3 is a bridge connecting the crypto and traditional fields. Web3 products with vitality have the opportunity to achieve the goal of both making money and sustaining through bull and bear markets.

At the same time, based on the Occam's Razor principle and the principle of fairness and transparency, we tend to design only necessary basic rules rather than restrictions. We believe that in the Web3 world, everyone should have an equal opportunity to earn rewards, not just whales or scientists.

Therefore, we propose a new mining mechanism: social mining.

## Product Rules

We believe that every user has their own basic value and can bring benefits to others.

**Social Mining**

Users can buy other users as their miners to mine for them.

Unlike other mining forms, social mining is a mining model that emphasizes more on user interaction.

At the same time, each user has two attributes: value and computing power, with a basic value of 0.1 ETH and a basic computing power of 100.

**Forced Transactions**

Users can purchase any miner by paying the miner's value, without the owner having to place an order or give permission.

**Exponential Growth**

After each transaction, the value of the traded miner will increase by 10%.

Computing Power = 100 \* Total Transaction Volume + 100

**Claim**

Based on the time of the last Claim, obtain all SO3 rewards from all miners.

If the miner is stolen, the SO3 rewards accumulated during the period when not Claimed will be accumulated until the next Claim.

**Gifts**

Users can give any miner a gift. Giving a heart costs 100 SO3, and the miner who receives the gift will receive a bonus of 1 computing power. The SO3 consumed for giving gifts will be burned.

**Discount Sale**

Users can set a price below the value to sell the miner at a discount. The miner sold at a discount will be marked as "x% off".

When the discounted miner is purchased, its computing power will also increase based on the transaction amount.

## Allocation Rules

## Claim Reward Allocation:

Each time of Claim, 90% of the reward goes to the miner owner, 2% goes into the treasury, and 8% goes to the miner.

Transaction Revenue Allocation:

Each time of transaction, 97% of the transaction amount goes to the former miner owner, 2% goes into the treasury, and 1% goes to the person who was traded.

## Product Features

**Growth Flywheel**

When the price of SO3 rises, the threshold for users to enter remains the same, which will attract more users to participate in mining. The treasury will receive more income, and more SO3 will be repurchased and burned, thus stimulating further price increases.

## Negative Feedback Mechanism

When the price of SO3 falls, users who cannot get the expected rewards may sell miners at a discount. Compared with other miners with the same computing power, the discounted miner will have a better cost-effectiveness ratio. At the same time, users can enhance their computing power at a lower cost by giving gifts, thus achieving a stable state.

## Continuous Income

Technically, as long as you find someone to buy you, you will always have an Owner, and when they Claim, you can receive income that lasts forever.

**Fully on-chain**

All actions of SO3 are fully on-chain, and each user has their own exclusive value and computing power on the chain. Third parties can implement customized presentation and more social gaming methods.

## Token Economy

SO3 is based on the ERC20 token standard, with a 100% fair launch from zero supply, no pre-mining, no admin keys or original wallets, no investors, no team reservations, and only minted by participating communities.

There is no maximum supply for SO3, with a first-year production of 1 billion tokens, halving annually, and fixed at 100 million tokens per year starting in the fifth year.

| Year | Production |
| ---- | ---------- |
| 1    | 1000000000 |
| 2    | 500000000  |
| 3    | 250000000  |
| 4    | 125000000  |
| 5+   | 100000000  |

## Treasury

Used for project operations, liquidity incentives, buyback and burning, contract auditing, etc., and open for community governance decisions after the community has matured.

## Roadmap

In the future, we will introduce NFT-related system gameplay, and the specific gameplay rules will be temporarily kept confidential to avoid affecting early user behavior and judgment.

Of course, we will also listen carefully to the voices of the community and open up community governance decisions after the community has matured.

## Who We Are

We are a group of crypto maximalists who have enjoyed the profits that crypto has brought us, as well as suffered from the pains. We firmly believe that Web3 is an important ladder to the bright future of crypto, and now we are trying to create a Web3 universal world with long-term value that can sustain through bull and bear markets.

## MATA

## Deployment Process

- 1. bash ./script/deploy.sh deployChef
- 2. bash ./script/deploy.sh

### deploySO3Market

- 1. bash ./script/op.sh initialize
- 2. Enable whitelist and add whitelist users.
