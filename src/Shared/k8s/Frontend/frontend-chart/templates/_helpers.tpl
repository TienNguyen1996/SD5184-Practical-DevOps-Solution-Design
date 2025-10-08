{{- define "frontend.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "frontend.fullname" -}}
{{ .Release.Name }}-{{ include "frontend.name" . }}
{{- end }}

{{- define "frontend.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
