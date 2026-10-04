# LibreChat Remote Code Worker — Fly.io

This repository is a deployment wrapper for a LibreChat attached/personal
Code Environment worker.

## Important

This is NOT a standalone public Code Interpreter API.

The current LibreChat architecture supports attached environments where the
`@librechat/code` worker connects outbound to the Code API/control plane.
The worker does not need a public inbound worker port.

## 1. Create the Fly app

Install and authenticate Fly CLI:

```bash
fly auth login
```

Create the app:

```bash
fly launch --no-deploy --name ragib-librechat-code
```

Or deploy using the included `fly.toml`:

```bash
fly deploy
```

## 2. Pair the worker

In LibreChat:

```text
Settings
  -> Code environments
  -> Connect VM
```

LibreChat generates a short-lived one-time pairing command.

Run that command on the Fly machine.

Do not put the pairing token into GitHub.

## 3. Check the machine

```bash
fly status
fly logs
```

## 4. Important sandbox security

The worker transport is NOT itself a sandbox boundary.

The Code Interpreter deployment must use an appropriate isolation mode
(NsJail or microVM/libkrun) for untrusted code.

A normal Fly machine without the required kernel/KVM capabilities should
not be treated as a secure microVM sandbox.

## 5. LibreChat

Your LibreChat deployment should use the Code Interpreter configuration
documented by LibreChat.

For a managed/attached Code Environment, configure the environment in
LibreChat rather than exposing an unauthenticated public Code API.

## 6. Persistent storage

The Fly volume at `/mnt/data` is for worker-side files. It is not a
replacement for the Code API's file server/object storage.

## 7. Do not enable public inbound execution

There is deliberately no `[http_service]` block in this `fly.toml`.

The intended model is:

LibreChat
    |
    | authenticated control/queue
    v
Code API / attached environment
    ^
    |
    | outbound worker connection
    |
Fly worker

## 8. If the worker exits

Check:

```bash
fly logs
```

The most common causes are:

- worker package/version mismatch with the Code API
- missing pairing/sandbox endpoint
- unsupported sandbox isolation mode
- insufficient memory
- missing required runtime capabilities

Always deploy a compatible `@librechat/code` worker with the same/current
Code Interpreter release family as the LibreChat Code API.
