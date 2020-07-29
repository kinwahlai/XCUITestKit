#!/bin/bash

set -eu

# Make protoc-gen-grpc-swift before running script
swift build --product protoc-gen-grpc-swift -c release

HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Where products will be built; this is the SPM default.
SWIFT_BUILD_PATH=${HERE}/.build

# protoc plugins.
PROTOC_GEN_SWIFT=${SWIFT_BUILD_PATH}/release/protoc-gen-swift
PROTOC_GEN_GRPC_SWIFT=${SWIFT_BUILD_PATH}/release/protoc-gen-grpc-swift

# Directory to read .proto files from and store the generated swift.
MODEL_DIR="${HERE}/Classes/Shared/Model"

function prepare {
  rm -rf "${MODEL_DIR}/*.swift"
}

function generate {
  prepare

  # generate protobuf file
  protoc \
    --proto_path="${MODEL_DIR}" \
    --plugin="${PROTOC_GEN_SWIFT}" \
    --swift_out=Visibility=Public:"${MODEL_DIR}" \
    "${MODEL_DIR}"/*.proto

  # generate grpc client/server file
  protoc \
    --proto_path="${MODEL_DIR}" \
    --plugin="${PROTOC_GEN_GRPC_SWIFT}" \
    --grpc-swift_out=Client=true,Server=true,Visibility=Public:"${MODEL_DIR}" \
    "${MODEL_DIR}"/*.proto
}

generate