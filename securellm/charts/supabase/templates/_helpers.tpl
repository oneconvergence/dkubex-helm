{{/*
Expand the name of the chart.
*/}}
{{- define "supabase.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "supabase.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "supabase.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "supabase.labels" -}}
helm.sh/chart: {{ include "supabase.chart" . }}
{{ include "supabase.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supabase.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supabase.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supabase.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "supabase.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Prepare db details
*/}}
{{- define "dbUser" -}}
{{- if eq .Values.global.db.externalDB true }}
{{- .Values.global.db.external.dbUser }}
{{- else }}
{{- if .Values.global.db.internal.dbUser }}
{{- .Values.global.db.internal.dbUser }}
{{- else }}
{{- "securellm" }}
{{- end }}
{{- end }}
{{- end }}
{{- define "dbPassword" -}}
{{- if .Values.global.db.externalDB }}
{{- .Values.global.db.external.dbPassword }}
{{- else }}
{{- if .Values.global.db.internal.dbPassword }}
{{- .Values.global.db.internal.dbPassword }}
{{- else }}
{{- randAlphaNum 8 }}
{{- end }}
{{- end }}
{{- end }}
{{- define "dbHost" -}}
{{- if .Values.global.db.externalDB }}
{{- .Values.global.db.external.dbHost }}
{{- else }}
{{- "supabase-db.securellm.svc.cluster.local" }}
{{- end }}
{{- end }}
{{- define "dbPort" -}}
{{- if .Values.global.db.externalDB }}
{{- .Values.global.db.external.dbPort }}
{{- else }}
{{- "5432" }}
{{- end }}
{{- end }}
{{- define "dbName" -}}
{{- if .Values.global.db.externalDB }}
{{- .Values.global.db.external.dbName }}
{{- else }}
{{- "postgres" }}
{{- end }}
{{- end }}
