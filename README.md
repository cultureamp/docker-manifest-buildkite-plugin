# docker-manifest-buildkite-plugin

Provides a simple way to create a Docker image manifest from a series of images.

> ⚠️ **Note well:** by default, this plugin **disables checkout of the source
> repository**. This should work well in most cases, as the operation does not
> require any reference to the source.
>
> However, if other plugins are in use for whatever reason that do require the
> source tree, set the `allow-checkout` parameter to `true`.

## Basic example

Add the following to your `pipeline.yml`:

```yml
steps:
  - label: ":docker: create manifest image"
    plugins:
      - cultureamp/docker-manifest#v2.0.0:
          image-name: "full-image-name-and-tag"
          source-image-names:
            - "full-image-name-and-tag-1"
            - "full-image-name-and-tag-2"
```

The names can of course use variable interpolation (or matrix variables), as is
standard in pipelines:

## Example allowing repository checkout

Note the use of the `allow-checkout` parameter:

```yml
steps:
  - label: ":docker: create manifest image"
    plugins:
      - cultureamp/docker-manifest#v2.0.0:
          image-name: "full-image-name-and-tag"
          source-image-names:
            - "full-image-name-and-tag-1"
            - "full-image-name-and-tag-2"
          allow-checkout: true
```

## Configuration

### `image-name` (Required, string)

The full name of the manifest image to create, including the repository and label as required.

### `source-image-names` (Required, string or array)

The set of full image names to include in the manifest.

### `allow-checkout` (Optional, boolean)

**Default false.** When true, allows the current pipeline repository checkout to
continue.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

To check the plugin metadata:

```shell
docker-compose run --rm lint
```
