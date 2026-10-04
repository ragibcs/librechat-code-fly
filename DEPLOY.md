# Deployment notes

## 1. Remove the old machine if necessary

    fly machine list -a librechat-code-fly

## 2. Create persistent volume

    fly volumes create code_data --size 10 --region sin -a librechat-code-fly

## 3. Deploy

    fly deploy -a librechat-code-fly

## 4. Do NOT set a fake endpoint

Wrong:

    fly secrets set LIBRECHAT_CODE_SANDBOX_ENDPOINT=https://librechat-code-fly.fly.dev

Correct:

    fly secrets set LIBRECHAT_CODE_SANDBOX_ENDPOINT="<endpoint-from-pairing-workflow>"

## 5. Logs

    fly logs -a librechat-code-fly

## 6. If using the full Code Interpreter service

LibreChat should point to the Code Interpreter API with:

    LIBRECHAT_CODE_BASEURL=https://YOUR-CODEAPI-DOMAIN/v1

The full service also needs matching LibreChat JWT authentication unless
you deliberately use an API-key-compatible deployment.
