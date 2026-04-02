# Cronometer Test Automation Suite

Automated tests for [Cronometer](https://cronometer.com) – a nutrition tracking **web application** and its **mobile app** (Android).  
This repository contains end-to-end test scenarios written in **Python** using **Robot Framework**, **Browser Library** (Playwright), and **Appium**.

## Repository Structure
Cronometer/
├── ADD_3Meals.robot # Web-only: add 3 meals + snack to diary
├── Web_App.robot # Cross-platform: web + mobile time sync test
├── Resources/
│ ├── VariablesFor3Meals.yaml # Credentials & selectors for ADD_3Meals
│ └── VariablesWeb_App.yaml # Credentials & selectors for Web_App
└── README.md


## Test Scenarios

### 1. Add 3 Meals To Diary (`ADD_3Meals.robot`)
**Platform:** Web only  
**What it does:**  
- Logs into Cronometer web app  
- Searches for 7 different foods (milk, oats, chicken, rice, yogurt, broccoli cheese soup, apple)  
- Adds each to the correct meal category (Breakfast, Lunch, Dinner, Snacks)  
- Verifies diary entries (via visual check – can be extended)  
- Logs out



**Key techniques:**  
- Role‑based locators (`Get Element By Role` with `exact=True`)  
- Reusable keywords with arguments (`Search For Food`, `Add Food To Diary`)  
- External YAML variables for credentials and selectors


---

### 2. Web & App Time Sync Test (`Web_App.robot`)
**Platform:** Web + Mobile (Android) – cross‑platform integration  
**What it does:**  
- Logs into Cronometer **web app** (Browser/Playwright)  
- Adds a specific food to diary  
- Captures current time from web  
- Logs out  
- Launches Cronometer **mobile app** (Appium)  
- Logs in with same credentials  
- Navigates to diary and captures time from app  
- Calculates time difference between web and mobile entries

**Key techniques:**  
- Hybrid automation: `BrowserLibrary` (web) + `AppiumLibrary` (mobile) in one test case  
- Session continuity across platforms  
- Manual pause (`Pause Execution`) for OTP/biometric – can be automated  
- DateTime calculations

---

## 🛠️ Tools & Frameworks

| Tool | Purpose |
|------|---------|
| **Python** | Core scripting language |
| **Robot Framework** | Test automation framework (keyword‑driven) |
| **Browser Library** | Web automation (Playwright‑based) – faster & more reliable than Selenium |
| **AppiumLibrary** | Mobile automation (Android) |
| **YAML** | External configuration (credentials, selectors, device settings) |
| **DateTime Library** | Time calculations for sync testing |

---

##  Setup & Execution

### Prerequisites
- Python 3.8+
- pip
- Android emulator or real device (for mobile tests)
- Appium server (for mobile tests)
- Chrome/Firefox (for web tests)

