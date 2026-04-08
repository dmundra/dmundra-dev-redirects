# Domain Redirects

This repository contains the Apache `.htaccess` routing rules for `dmundra.dev` and `eugtbp.org`, along with an automated Bash testing suite to ensure all redirects resolve correctly.

## Overview

The configurations handle:
1. **Canonical Domain Routing:** Forcing `www` traffic to non-`www` domains.
2. **Domain Migrations:** Seamlessly forwarding traffic from old domains (`danielmundra.dev`) to new domains (`dmundra.dev`).
3. **Marketing/UTM Tracking:** Catching specific short links (`/movies`, `/wkly`) and expanding them into full destination URLs with Google Analytics UTM parameters.

