# PricePulse 🚀

**Next-Generation Decentralized Prediction Protocol**

![Stacks](https://img.shields.io/badge/Stacks-Blockchain-purple)
![Clarity](https://img.shields.io/badge/Smart_Contract-Clarity-blue)
![Version](https://img.shields.io/badge/Version-1.0.0-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📊 Overview

PricePulse is a revolutionary decentralized prediction marketplace that leverages blockchain transparency to create fair, automated betting markets on cryptocurrency price movements. Built on the Stacks blockchain for Bitcoin-level security, PricePulse offers instant settlements and proportional reward distribution through smart contract automation.

### 🎯 Key Features

- **🔮 Binary Price Predictions**: Stake on "up" or "down" price movements
- **⚡ Instant Settlements**: Oracle-verified automatic settlements
- **💰 Proportional Rewards**: Fair distribution based on stake proportions
- **🛡️ Secure & Transparent**: Built on Stacks for Bitcoin security
- **🔧 Programmable Markets**: Automated market creation and management
- **💎 Low Fees**: Transparent fee structure with minimal costs

---

## 🏗️ Architecture

### Smart Contract Components

| Component | Description |
|-----------|-------------|
| **Market Creation** | Owner-controlled market initialization with price/block parameters |
| **Prediction System** | Binary prediction mechanism with stake validation |
| **Oracle Integration** | Trusted price feed for market resolution |
| **Reward Distribution** | Mathematical proportional payout system |
| **Administrative Controls** | Fee management and parameter updates |

### Data Structures

```clarity
;; Market Structure
{
  start-price: uint,
  end-price: uint,
  total-up-stake: uint,
  total-down-stake: uint,
  start-block: uint,
  end-block: uint,
  resolved: bool
}

;; User Prediction
{
  prediction: (string-ascii 4), ;; "up" or "down"
  stake: uint,
  claimed: bool
}
```

---

## 🚀 Quick Start

### Prerequisites

- [Clarinet CLI](https://docs.hiro.so/stacks/clarinet)
- [Node.js](https://nodejs.org/) (v16+)
- [Git](https://git-scm.com/)

### Installation

```bash
# Clone the repository
git clone https://github.com/kingsley-akpan/price-pulse.git
cd price-pulse

# Install dependencies
npm install

# Check contract syntax
clarinet check

# Run tests
npm test
```

### Development Setup

```bash
# Format contracts
clarinet fmt --in-place

# Start local blockchain
clarinet integrate

# Run tests with coverage
npm run test:report

# Watch mode for continuous testing
npm run test:watch
```

---

## 📋 Smart Contract API

### Core Functions

#### `create-market`

Creates a new prediction market (Owner only)

```clarity
(create-market (start-price uint) (start-block uint) (end-block uint))
```

#### `make-prediction`

Submit prediction with stake

```clarity
(make-prediction (market-id uint) (prediction (string-ascii 4)) (stake uint))
```

#### `resolve-market`

Oracle resolves market with final price

```clarity
(resolve-market (market-id uint) (end-price uint))
```

#### `claim-winnings`

Claim proportional rewards from won predictions

```clarity
(claim-winnings (market-id uint))
```

### Read-Only Functions

#### `get-market`

Retrieve market information

```clarity
(get-market (market-id uint))
```

#### `get-user-prediction`

Get user's prediction details

```clarity
(get-user-prediction (market-id uint) (user principal))
```

#### `get-contract-balance`

Check contract STX balance

```clarity
(get-contract-balance)
```

### Administrative Functions

- `set-oracle-address`: Update oracle principal
- `set-minimum-stake`: Modify minimum stake requirement
- `set-fee-percentage`: Adjust platform fee (0-100%)
- `withdraw-fees`: Extract accumulated fees

---

## 🧪 Testing

The project uses Vitest with Clarinet SDK for comprehensive testing:

```bash
# Run all tests
npm test

# Generate coverage report
npm run test:report

# Continuous testing
npm run test:watch
```

### Test Categories

- **Unit Tests**: Individual function validation
- **Integration Tests**: End-to-end workflow testing
- **Edge Cases**: Boundary condition testing
- **Security Tests**: Access control and validation

---

## 🔧 Configuration

### Network Settings

Configure different networks in the `settings/` directory:

- `Devnet.toml`: Local development configuration
- `Testnet.toml`: Testnet deployment settings
- `Mainnet.toml`: Production deployment configuration

### Contract Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `minimum-stake` | 1,000,000 | Minimum STX stake (1 STX) |
| `fee-percentage` | 2% | Platform fee on winnings |
| `oracle-address` | Owner | Trusted price oracle |

---

## 🔒 Security Features

### Access Controls

- **Owner-only functions**: Market creation, parameter updates
- **Oracle authorization**: Price resolution restricted to trusted oracle
- **Stake validation**: Minimum stake and balance checks

### Safety Mechanisms

- **Market time windows**: Predictions only during active periods
- **Double-claim prevention**: One-time reward claiming
- **Parameter validation**: Input sanitization and bounds checking

---

## 📈 Economic Model

### Fee Structure

- **Platform Fee**: 2% of winnings (configurable)
- **Gas Costs**: Standard Stacks transaction fees
- **Minimum Stake**: 1 STX (prevents spam)

### Reward Calculation

```
User Winnings = (User Stake × Total Pool) ÷ Winning Pool
Net Payout = Winnings - Platform Fee
```

---

## 🗺️ Roadmap

### Phase 1: Core Protocol ✅

- [x] Basic prediction markets
- [x] Oracle integration
- [x] Reward distribution
- [x] Administrative controls

### Phase 2: Enhanced Features 🚧

- [ ] Multiple asset support
- [ ] Dynamic fee structures
- [ ] Advanced market types
- [ ] Governance token integration

### Phase 3: Ecosystem Growth 📋

- [ ] Frontend interface
- [ ] Mobile application
- [ ] API documentation
- [ ] Community governance

---

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Commit** your changes: `git commit -m 'Add amazing feature'`
4. **Push** to the branch: `git push origin feature/amazing-feature`
5. **Open** a Pull Request

### Development Guidelines

- Follow Clarity best practices
- Write comprehensive tests
- Update documentation
- Use conventional commits

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Stacks Foundation** for blockchain infrastructure
- **Hiro Systems** for development tools
- **Clarity Community** for language development
- **Contributors** who make this project possible
