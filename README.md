<div align="center">
    <h1>steam-idler</h1>
    <h4>Simple cross-platform Steam game idler with multi account support.</h4>
    <div>
        <a href="#-install">Install</a> •
        <a href="#-config">Config</a> •
        <a href="#-proxies">Proxies</a> •
        <a href="#-telegram">Telegram</a> •
        <a href="#-start">Start</a>
    </div>
</div>

&nbsp;

## ✨ Introduction
This is a fork of [3urobeat's steam-idler](https://github.com/3urobeat/steam-idler) with the following changes:

- **Unified config** — accounts and settings live in a single `config.json`. No more `accounts.txt`.
- **Telegram bot integration** — pass Steam Guard codes remotely via a Telegram bot instead of typing them in the terminal. Useful when running the idler on a headless server.
- **Steamladder integration** — periodically refreshes your account pages on [steamladder.com](https://steamladder.com).
- **Enhanced connection logic** — improved watchdog and relog handling to recover from cases where Steam silently drops the connection without firing a disconnect event.

For the original, see [3urobeat/steam-idler](https://github.com/3urobeat/steam-idler).

&nbsp;

## 🚀 Install
Make sure to have [node.js](https://nodejs.org/) installed.
Download this repository as `.zip`, extract the folder and open a Terminal/Power Shell/Console in the folder.

Type `npm install` to install all dependencies.

&nbsp;

## 📝 Config
All configuration lives in `shared/config.json`. Open it in a text editor and fill in your accounts and settings.

**Accounts** go in the `accounts` array. Each entry has:

- `login` / `password` — Steam credentials.
- `playingGames` — array of app IDs to idle. Up to 32 games. You can also put a string first to display a custom game name, e.g. `["Minecraft", 440, 730]`.
- `onlinestatus` — choose a number from [this list](https://github.com/DoctorMcKay/node-steam-user/blob/master/enums/EPersonaState.js). Set to `null` to leave your status unchanged.
- `afkMessage` — message to send when someone messages you while idling. Set to `null` to not reply.

Example:

```json
{
  "accounts": [
    {
      "login": "myaccount1",
      "password": "hunter2",
      "onlinestatus": 1,
      "afkMessage": null,
      "playingGames": [440, 730, 570]
    }
  ],
  "loginDelay": 2000,
  "relogDelay": 15000,
  "logPlaytimeToFile": true,
  "telegramToken": "token",
  "steamladderApiKey": "apikey"
}
```

**Global settings:**

`loginDelay` and `relogDelay` control the delay (ms) between logins and before a relog is attempted after a disconnection. The defaults are fine for most setups.

Set `logPlaytimeToFile` to `false` to disable session summaries being written to `shared/playtime.txt`.

Set `steamladderApiKey` to your [Steamladder API key](https://steamladder.com/api/) to have the bot refresh your profile page there periodically.

&nbsp;

## 📡 Proxies
If you are running many accounts you can add HTTP proxies to spread sessions across IPs. Open `proxies.txt` and put one proxy per line in the format `http://user:pass@1.2.3.4:8081`. Accounts are spread across proxies evenly. Note that Steam may block some proxy providers.

&nbsp;

## 📲 Telegram
If you're running the idler on a remote/headless server, you can have Steam Guard codes delivered via Telegram instead of entering them in the terminal.

1. Create a bot via [@BotFather](https://t.me/BotFather) and copy the token.
2. Set `telegramToken` in `config.json` to your bot token.
3. When a Steam Guard code is required on startup, the bot will listen for the next message you send it and use that as the code.

Leave `telegramToken` empty or omit it to use the default terminal prompt.

&nbsp;

## 🚀 Start
Then just type `node idler.js` to start the script.
The script will try to log in and ask you for your Steam Guard code if it needs one (via terminal or Telegram, depending on your config). When it is logged in a logged in message will be displayed.

Every time an account loses connection it will print a session summary to a text file "playtime.txt" (will be created automatically).
This also applies to when you stop the bot manually. To turn this whole feature off, set `logPlaytimeToFile` in the config to `false`.

&nbsp;

Thats it. A simple cross-platform Steam game idling script powered by [DoctorMcKay's steam-user library](https://github.com/DoctorMcKay/node-steam-user).

&nbsp;

## 📊 Results

<div align="center">
  <img src="assets/playtime-stats.jpg" width="300" alt="Playtime stats" />
  <br/><br/>
  <img src="assets/playtime-2weeks.jpg" width="400" alt="10,523 hours past 2 weeks" />
</div>
