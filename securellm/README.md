# SecureLLM
Chart to install SecureLLM product.

## Installation
##### Add dkubex-helm repo
```bash
helm repo add dkubex-helm https://oneconvergence.github.io/dkubex-helm
```
##### Install with values.yaml
1. Download values.yaml locally
```bash
helm show values dkubex-helm/securellm > values.yaml
```
2. Update with required details. 

3. Run helm install with values.yaml
```bash
helm install -f values.yaml <release-name> -helm/securellm
```	

##### Basic Install with DKubex
we can use helm --set option to override input paramater values defined in values.yaml during install.
```bash

helm install <release-name> dkubex-helm/securellm -n securellm --create-namespace \
--set global.db.internal.nfs.enabled=true \
--set global.db.internal.nfs.server=<nfsip> \
--set global.db.internal.nfs.path=<nfspath> \
--set sllmAdminUser="admin@dkubex.ai" \
--set sllmAdminPassword=<adminpasswd> \
--set ingress.oauth.enabled=false \
--set ingress.className="d3x" \
--set imageCredentials.username="dkubex123" \
--set imageCredentials.password=<crtoken> \
--set global.db.wipedata=true \
--set sllmOpenaiKey=<openaikey> \
--version 0.2 --wait
```

##### check status
```bash
helm status <release-name> -n securellm
```

##### Install with External Database
- `db.externalDB=true` :> To use external postgres databases like amazonRDS
- Please see below command to see the other parameters that can be set for external DB.

```bash

helm install <release-name> dkubex-helm/securellm -n securellm --create-namespace \
--set global.db.externalDB=true \
--set global.db.external.dbUser=<dbuser> \
--set global.db.external.dbPassword=<dbpassword> \
--set global.db.external.dbHost=<dbhost> \
--set global.db.external.dbPort=<dbport> \
--set global.db.external.dbName=<dbname> \
--set global.db.external.dbSSL=<if db needs ssl to access> \
--set global.db.internal.dbUser=<dbuser> \
--set global.db.internal.dbPassword=<dbpassword> \
--set global.db.internal.nfs.enabled=true \
--set global.db.internal.nfs.server=<nfsip> \
--set global.db.internal.nfs.path=<nfspath> \
--set sllmAdminUser="admin@dkubex.ai" \
--set sllmAdminPassword=<admin-password> \
--set ingress.oauth.enabled=true \
--set ingress.className="d3x" \
--set ingress.host="" \
--set imageCredentials.username="dkubex123" \
--set imageCredentials.password=<crtoken> \
--set global.db.wipedata=true \
--set sllmOpenaiKey=<oaikey> \
--version 0.2 --wait

```


## Upgrade
To upgrade securellm, please use the below command with the newly available version of securellm.
```bash
helm get values <deployed-release-name> --all  > values-upgrade.yaml
helm upgrade -f values-upgrade.yaml <deployed-release-name> dkubex-helm/securellm --set version=<new-version> --timeout 1500s
```

## Uninstallation
To uninstall securellm, please run below command:
```bash
helm uninstall <release-name> -n securellm --wait --cascade=foreground
```

## Build chart and release to dkube-helm repo
```bash
Prerequisites- chart releaser(cr) tools (v1.2.1) and helm binary should be installed.

0. Install chart releaser
      wget https://github.com/helm/chart-releaser/releases/download/v1.2.1/chart-releaser_1.2.1_linux_amd64.tar.gz
      tar -xf chart-releaser_1.2.1_linux_amd64.tar.gz
      sudo mv cr /usr/local/bin/
1. If building release with existing version then delete release and tag from github first.
2. git checkout <new-release-branch>
3. Change the chart version on Chart.yaml available in securellm folder (incremental version based on last release)
3. helm package securellm --destination .deploy
4. cr upload -o oneconvergence -r dkubex-helm -p .deploy --token <github-token>
5. git checkout gh-pages
6. cr index -i ./index.yaml -p .deploy --owner oneconvergence -r dkubex-helm -c https://oneconvergence.github.io/dkubex-helm
7. git add index.yaml
8. git commit -m "release message"
9. git push origin gh-pages
```

