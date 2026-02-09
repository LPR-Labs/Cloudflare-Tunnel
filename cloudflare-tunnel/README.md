# Cloudflare Tunnel with DNS for Home Assistant

This add-on provides secure remote access to Home Assistant using **Cloudflare Tunnel**, with **automatic DNS configuration** and **no open firewall ports**.

All connections are outbound-only and encrypted end-to-end.

---

## ✨ Features

- 🔐 Secure remote access via Cloudflare Tunnel
- 🌍 Automatic DNS record creation in Cloudflare
- 🚫 No port forwarding or firewall changes required
- 🧠 One-time setup, persistent configuration
- 🏠 Designed for Home Assistant OS & Supervised
- 🌐 Works behind CGNAT and restrictive ISPs

---

## 🧩 How It Works

On first start, the add-on:
1. Authenticates to Cloudflare using an API token
2. Creates a Cloudflare Tunnel
3. Creates a DNS record for your chosen hostname
4. Generates a tunnel configuration
5. Starts the tunnel

On subsequent starts, the tunnel is reused and no changes are made.

---

## ⚙️ Configuration

All configuration is done via the **Home Assistant Add-on UI**.

### Required Options

| Option        | Description |
|--------------|-------------|
| `api_token`  | Cloudflare API token with Tunnel and DNS permissions |
| `domain`     | Your Cloudflare-managed domain (e.g. `example.com`) |
| `subdomain`  | Subdomain for Home Assistant (e.g. `home`) |
| `tunnel_name`| Name of the Cloudflare Tunnel |

Your Home Assistant will be available at:

