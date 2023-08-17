# dkubex/SecureGPT
Holds SecureGPT charts of DKubex product

## Installation
##### Add dkubex-helm repo
```bash
helm repo add dkubex-helm https://oneconvergence.github.io/dkubex-helm
```
##### Install with values.yaml
1. Download values.yaml locally
```bash
helm show values dkubex-helm/securegpt > values.yaml
```
2. Update with required details. 

3. Run helm install with values.yaml
```bash
helm install -f values.yaml <release-name> dkubex-helm/securegpt
```	

##### Install with --set option
we can also use helm --set option to override input paramater values defined in values.yaml during install.
```bash

helm install <release-name> dkubex-helm/securegpt \
--set global.persistence.enabled=true \
--set global.persistence.nfs.server="" \
--set global.persistence.nfs.path="" \
--set dkubex_sgpt_pwd="" \
--set ingress.oauth.enabled=false \
--set ingress.className="" \
--set ingress.host="" \
--set imageCredentials.username="" \
--set imageCredentials.password="" \
--set global.wipedata=true \
--set openaikey=""
```

##### check status
```bash
helm status <release-name> -n dkubex
```

## Upgrade
To upgrade dkubex/securegpt, please use the below command with the newly available version of dkubex/securegpt.
```bash
helm get values <deployed-release-name> --all  > values-upgrade.yaml
helm upgrade -f values-upgrade.yaml <deployed-release-name> dkubex-helm/securegpt --set version=<new-version> --timeout 1500s
```

## Uninstallation
To uninstall dkubex/securegpt, please run below command:
```bash
helm uninstall <release-name>
```

## Build chart and release to dkube-helm repo
```bash
Prerequisites- chart releaser(cr) tools (v1.2.1) and helm binary should be installed.

1. If building release with existing version then delete release and tag from github first.
2. git checkout <new-release-branch>
3. Change the chart version on Chart.yaml available in securegpt folder (incremental version based on last release)
3. helm package securegpt --destination .deploy
4. cr upload -o oneconvergence -r dkubex-helm -p .deploy --token <github-token>
5. git checkout gh-pages
6. cr index -i ./index.yaml -p .deploy --owner oneconvergence -r dkubex-helm -c https://oneconvergence.github.io/dkubex-helm
7. git add index.yaml
8. git commit -m "release message"
9. git push origin gh-pages
```
