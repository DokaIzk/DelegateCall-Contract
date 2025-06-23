# 🔁 Delegatecall vs Call – Solidity Classwork

This project demonstrates the difference between `call` and `delegatecall` in Solidity by deploying two contracts (`A` and `B`) with identical storage layouts and observing how storage is affected when calling functions across them.

---

## 📦 Contracts

- [`ContractA.sol`](./src/A.sol): The main contract that performs `call` and `delegatecall`.
- [`ContractB.sol`](./src/B.sol): Contains the `setVars(uint256)` logic to be called/delegate-called.

---

## 🚀 Deployment Details

- **Network**: Local Anvil (Chain ID: 31337)
- **Deployed via**: Foundry script with broadcast enabled

### 📌 Addresses

- **Contract A**: `0x5FC8d32690cc91D4c39d9d3abcBD16989F875707`
- **Contract B**: `0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9`

---

## ✅ Test Summary

After calling both methods from Contract A:

### 🔸 `setVarsCall(address(B), 20)` (using `call`)

- **B.num =** `20`
- **B.sender =** `Contract A's address`
- **B.value =** `2 ether`
- **A remains unchanged**

### 🔹 `setVarsDelegateCall(address(B), 99)` (using `delegatecall`)

- **A.num =** `99`
- **A.sender =** `Deployer wallet`
- **A.value =** `2 ether`
- **B remains unchanged**

---

## ❓ Answers to Classwork Questions

### 1️⃣ What differences did you observe between `call` and `delegatecall`?

- `call` executes the target contract’s code in **its own context**, so storage changes affect the **target** (Contract B). `msg.sender` becomes Contract A.
- `delegatecall` runs the target’s code in **the calling contract’s context**, so all storage and `msg.sender` apply to Contract A.

---

### 2️⃣ Why must the storage layout in ContractA and ContractB be exactly the same when using `delegatecall`?

- `delegatecall` reuses the storage of the caller (Contract A), so if their layouts don’t match, variables will be **written to the wrong slots**.
- This causes data corruption and unexpected behavior.
- Matching layouts ensures code from Contract B updates the correct storage slots in A.

---

### 3️⃣ Which method would you use for creating upgradable contracts and why?

- **I would use `delegatecall`**.
- This allows separating **logic (Contract B)** from **storage (Contract A)**, which is essential for **upgradeable smart contracts**.
- It’s the foundation of upgradeable proxy patterns like **UUPS** or **Transparent Proxies**, where storage must persist but logic can change.

---

## 🧪 How to Run This Project

```bash
# 1. Start local anvil chain
anvil

# 2. In a new terminal, export RPC and private key
export RPC_URL=http://127.0.0.1:8545
export PRIVATE_KEY=<any key from anvil>

# 3. Run the deployment script
forge script script/Contract.s.sol:DeployAndRun --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
