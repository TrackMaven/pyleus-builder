This container is a builder and submitter for [Pyleus]() Storm topologies. It can be used either with vanilla Docker or fig to turn a Pyleus topology into a packaged `.jar` file, or to submit said `.jar` to a Storm cluster.
This package is intended to be used if you don't wish to install Storm natively.

## Docker Usage

Pull the image from the Docker registry:

```bash
docker pull trackmaven/pyleus-builder
```

### Building Topologies

Navigate to the directory where your Pyleus topology lives. You'll need to bind your topology's directory to the `/topology` directory in the container using Docker's `-v` flag, and point the `build` command to your `pyleus_topology.yaml`:

```bash
docker run -v /absolute/path/to/my/topology:/topology 'trackmaven/pyleus-builder' build pyleus_topology.yaml
```

This will create a `.jar` file in your topology directory, containing your built Pyleus topology. The name of the topology `.jar` will be generated from the `name` field in your `pyleus_topology.yaml`.

### Submitting Topologies

Once you have built your topology, you can submit it to a running Storm cluster using the following command, replacing `NIMBUS_HOST` and `NIMBUS_PORT` with their equivalents for your cluster.

```bash
docker run -v /absolute/path/to/my/topology:/topology 'trackmaven/pyleus-builder' submit -n <NIMBUS_HOST> -p <NIMBUS_PORT> my-topology.jar
```

This will upload your topology to your Storm cluster!


## Fig Usage

Using `fig` (soon to be `docker-compose`) makes using this image even easier!

Add the following to your `fig.yml` at the root of your topology directory:

```yml
builder:
    image: trackmaven/pyleus-builder
    volumes:
        - .:/topology
```

### Building Topologies

To build a topology:

```bash
fig run builder build pyleus_topology.yaml
```

As with the Docker example, you will end up with a `.jar` of your topology in your topology directory.

### Submitting Topologies

To submit a topology to a running Storm cluster:

```bash
fig run builder submit my-topology.jar
```



