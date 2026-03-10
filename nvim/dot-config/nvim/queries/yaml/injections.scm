; extends
; Dockerfile snippets for AIM pipeline
(block_mapping_pair
  key: (flow_node) @_template
  (#eq? @_template "template")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "dockerfile")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_template
  (#eq? @_template "entrypoint")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))
