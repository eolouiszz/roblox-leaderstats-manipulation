# Roblox — Leaderstats Manipulation

Security research and proof-of-concept documentation demonstrating
client-side manipulation of Roblox `leaderstats` and its effect on
race-related visual information in **Pumma Talladega**.

---

## 🎮 Tested Experience

**Game:** Pumma Talladega

**Platform:** Roblox

---

## 🔎 Finding — Client-Side Leaderstats Manipulation

### Classification

* **Type:** Client-Side State Manipulation
* **Category:** Local Leaderstats Manipulation
* **Affected component:** `leaderstats`
* **Observed impact:** Visual/UI manipulation
* **Server-side persistence:** Not demonstrated

---

## 📋 Description

The game exposes a `leaderstats` folder to the local player containing
values related to the race.

During testing, these values could be modified locally from the client.

For example:

```text
leaderstats
├── Wins
└── Laps
```

The values can be changed by modifying their local `Value` properties.

This can affect information displayed to the local player and may cause
race-related UI elements to show manipulated information.

---

## 🧪 Proof of Concept

```lua
--[[
    PoC: Local Leaderstats Manipulation

    Demonstrates the local modification of values inside leaderstats.

    During testing, these changes affected information displayed
    on the client, including race-related statistics.

    This PoC does not demonstrate server-side persistence.
]]

local player = game.Players.LocalPlayer
local leaderstats = player:FindFirstChild("leaderstats")

if not leaderstats then
    print("[-] leaderstats not found on LocalPlayer.")
    return
end

print("[PoC] Testing local leaderstats manipulation...")

pcall(function()
    local wins = leaderstats:FindFirstChild("Wins")
    local laps = leaderstats:FindFirstChild("Laps")

    -- Modify the local Wins value.
    if wins then
        wins.Value = 999999
        print("[+] Wins changed locally to 999999.")
    end

    -- Modify the local Laps value.
    if laps then
        laps.Value = 9
        print("[+] Laps changed locally to 9.")
    end
end)
```

---

## 👁️ Observed Behavior

The modification is performed on the **client-side representation**
of the values.

Depending on how the game's UI reads these values, manipulated
information can become visible to the local player.

Examples of race-related information that may be represented through
client-side values include:

* Wins
* Lap count
* Race position
* Race progress
* Other statistics displayed by the interface

The important distinction is that **changing a local value does not
automatically mean that the server accepted or persisted that value**.

---

## ⚠️ Impact

The demonstrated impact is primarily **visual/client-side**.

This PoC does not establish that:

* The server accepts the modified values.
* Other players see the modified values.
* Wins are permanently saved.
* The player actually receives rewards.
* Server-side race statistics are modified.

Further testing would be required to establish any server-side impact.

---

## 🧠 Why This Is Different

This finding differs from RemoteEvent abuse.

In the other research documented separately, the client interacts
directly with server-facing RemoteEvents.

Here, the demonstrated behavior is based on modifying a local object:

```text
Client
  ↓
leaderstats
  ↓
Local value
  ↓
Race UI / visual representation
```

This means the primary issue demonstrated by this PoC is the ability to
manipulate **client-side state**, rather than directly modifying
server-side data.

---

## 🛡️ Recommended Mitigations

Client-side values should never be treated as authoritative for
important game logic.

For statistics such as:

* Wins
* Rewards
* Race results
* Currency
* Rankings
* Progression

the server should maintain the authoritative state.

The client should primarily receive and display information provided by
the server rather than being trusted to determine the actual value.

For example:

```text
Client → displays race information
Server → determines actual race result
Server → validates rewards/statistics
```

Any important statistic should be validated and updated by trusted
server-side code.

---

## 🧪 Research Process

The finding was discovered through simple client-side testing.

The research involved:

1. Inspecting the local player's objects.
2. Identifying the `leaderstats` folder.
3. Examining its values.
4. Testing whether the values could be modified locally.
5. Observing changes in the race-related interface.
6. Determining whether the behavior was local or server-side.
7. Documenting the observed result.

No advanced exploitation framework or custom infrastructure was
required.

---

## 📚 Research Goals

This repository is intended for educational and defensive security
research involving:

* Roblox client-side state
* `leaderstats`
* Client-server architecture
* UI trust boundaries
* Server-side authority
* Input validation
* Secure Roblox development
* Vulnerability research
* Proof-of-concept development

---

## ⚠️ Responsible Use

This repository is provided **for educational and authorized security
research purposes only**.

Do not use this proof-of-concept to interfere with public games,
misrepresent statistics to other players, bypass game systems, or
perform unauthorized actions.

### No Responsibility for Misuse

I am **not responsible or liable for actions performed by other people
using the information or code contained in this repository**.

If someone copies, modifies, or repurposes this PoC to create another
exploit, interfere with a game, manipulate statistics, harass players,
or perform any other malicious or unauthorized activity, that person's
actions are their own responsibility.

I do not authorize, encourage, or endorse malicious use of this
research.

The purpose of this repository is to document the observed behavior
and help developers understand the importance of server-authoritative
game state.

---

## 📌 Important

This repository documents **client-side manipulation**.

It should not be interpreted as proof that the game's persistent
statistics or server-side state can be modified.

The severity of the finding depends on whether any server-side systems
trust or consume the manipulated client-side values.

All further testing should be performed only in an environment where
the researcher has permission.

---

## 📄 License

This repository is intended for educational and security research
purposes.

By using material from this repository, you acknowledge that you are
responsible for your own actions and for ensuring that your use
complies with applicable laws, platform rules, and the authorization
of the system being tested.
