#!/bin/bash

set -e

echo "Generate deepcopy, openapi & client ..."

deepcopy-gen --input-dirs github.com/loft-sh/jspolicy/pkg/apis/... -o $GOPATH/src --go-header-file ./hack/boilerplate.go.txt -O zz_generated.deepcopy
#openapi-gen --input-dirs github.com/loft-sh/jspolicy/pkg/apis/... -o $GOPATH/src --go-header-file ./hack/boilerplate.go.txt -i k8s.io/apimachinery/pkg/apis/meta/v1,k8s.io/apimachinery/pkg/api/resource,k8s.io/apimachinery/pkg/runtime,k8s.io/apimachinery/pkg/util/intstr,k8s.io/api/admission/v1,k8s.io/api/admission/v1beta1,k8s.io/api/admissionregistration/v1,k8s.io/api/admissionregistration/v1beta1,k8s.io/api/apps/v1,k8s.io/api/apps/v1beta1,k8s.io/api/apps/v1beta2,k8s.io/api/authentication/v1,k8s.io/api/authentication/v1beta1,k8s.io/api/authorization/v1,k8s.io/api/authorization/v1beta1,k8s.io/api/autoscaling/v1,k8s.io/api/autoscaling/v2beta1,k8s.io/api/autoscaling/v2beta2,k8s.io/api/batch/v1,k8s.io/api/batch/v1beta1,k8s.io/api/batch/v2alpha1,k8s.io/api/certificates/v1beta1,k8s.io/api/coordination/v1,k8s.io/api/coordination/v1beta1,k8s.io/api/core/v1,k8s.io/api/discovery/v1alpha1,k8s.io/api/events/v1beta1,k8s.io/api/extensions/v1beta1,k8s.io/api/networking/v1,k8s.io/api/networking/v1beta1,k8s.io/api/node/v1alpha1,k8s.io/api/node/v1beta1,k8s.io/api/policy/v1beta1,k8s.io/api/rbac/v1,k8s.io/api/rbac/v1alpha1,k8s.io/api/rbac/v1beta1,k8s.io/api/scheduling/v1,k8s.io/api/scheduling/v1alpha1,k8s.io/api/scheduling/v1beta1,k8s.io/api/storage/v1,k8s.io/api/storage/v1alpha1,k8s.io/api/storage/v1beta1,k8s.io/client-go/pkg/apis/clientauthentication/v1alpha1,k8s.io/client-go/pkg/apis/clientauthentication/v1beta1,k8s.io/api/core/v1 --report-filename violations.report --output-package github.com/loft-sh/jspolicy/pkg/openapi
client-gen -o $GOPATH/src --go-header-file ./hack/boilerplate.go.txt --input-base github.com/loft-sh/jspolicy/pkg/apis --input policy/v1beta1 --clientset-path github.com/loft-sh/jspolicy/pkg/client/clientset_generated --clientset-name clientset

echo "Generate crd ..."
go run gen/main.go > chart/crds/crds.yaml
