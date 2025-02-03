{{- define "imagePullSecret" }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.container_registry.uri (printf "%s:%s" .Values.container_registry.username .Values.container_registry.password | b64enc) | b64enc }}
{{- end }}
