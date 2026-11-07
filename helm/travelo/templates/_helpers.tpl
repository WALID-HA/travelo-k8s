{{/* Nom de base des objets : le nom de la release (ex. "travelo") */}}
{{- define "travelo.name" -}}
{{- .Release.Name | trunc 40 | trimSuffix "-" -}}
{{- end -}}

{{/* Labels communs à tous les objets */}}
{{- define "travelo.labels" -}}
app.kubernetes.io/part-of: travelo
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}
