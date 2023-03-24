# docker-manifest-buildkite-plugin

Provides a simple way to create a Docker image manifest from a series of images.

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - command: ls
    plugins:
      - cultureamp/docker-manifest#v1.0.0:
          image-name: "full-image-name-and-tag"
          source-image-names:
            - "full-image-name-and-tag-1"
            - "full-image-name-and-tag-2"
```

## Configuration

### `image-name` (Required, string)

The full name of the manifest image to create, including the repository and label as required.

### `source-image-names` (Required, string or array)

The set of full image names to include in the manifest.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```
