---
id: 5p0vnhjeekzgwktq8kq3jp9
title: Keycloak
desc: ''
updated: 1676451682873
created: 1676451673638
---

```bash
# https://www.keycloak.org/getting-started/getting-started-docker
docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:20.0.1 start-dev
```

Best source: 
https://stackoverflow.com/questions/48855122/keycloak-adaptor-for-golang-application

Go library
https://github.com/Nerzal/gocloak


- https://www.keycloak.org/guides#server
  - https://www.keycloak.org/docs/latest/securing_apps/index.html#installing-middleware
- https://www.g2.com/products/keycloak/reviews#survey-response-4491310
- https://www.g2.com/categories/single-sign-on-sso
- https://medium.com/codeshakeio/configure-keycloak-to-use-google-as-an-idp-4e3c59583345
- https://blog.hcltechsw.com/versionvault/how-to-configure-microsoft-azure-active-directory-as-keycloak-identity-provider-to-enable-single-sign-on-for-hcl-compass/?referrer=blog.hcltechsw.com
- https://keycloakthemes.com/blog/how-to-setup-sign-in-with-google-using-keycloak
- https://github.com/Nerzal/gocloak
- https://levelup.gitconnected.com/building-micro-services-in-go-using-keycloak-for-authorisation-e00a29b80a43
- https://stackoverflow.com/questions/48855122/keycloak-adaptor-for-golang-application
- https://blog.bitsrc.io/integrating-keycloak-with-angular-for-sso-authentication-9d1c6c2d2742
- https://ramandeep-singh-1983.medium.com/enterprise-web-app-authentication-using-keycloak-and-node-js-c10b0e26b80d
- 