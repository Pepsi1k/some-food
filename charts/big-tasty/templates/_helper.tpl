

{{/*
Return the target Kubernetes version
*/}}
{{- define "some-food.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride }}
{{- end -}}

{{/*
Return the appropriate apiVersion for ingress
*/}}
{{- define "some-food.ingress.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "some-food.kubeVersion" $) -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" (include "some-food.kubeVersion" $) -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return fqdn of some-food ClusterIP
*/}}
{{- define "some-food.svc.fullname" -}}
{{- $svcName := required "Field bigTasty.someFood.fullnameOverride must be set" .Values.bigTasty.someFood.fullnameOverride -}}
{{- printf "%s.%s.svc.cluster.local" $svcName .Release.Namespace -}}
{{- end -}}