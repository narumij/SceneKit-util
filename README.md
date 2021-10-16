# SceneKit-util

配列やMTLBufferからSCNGeometryを生成します。

## Prepare

### Vertex

``` Metal
typedef struct {
    vector_float3 texcoord;
    vector_float3 position;
} Vertex;
```

## Adding Protocol Conformance

### case 1

``` Swift
extension Vertex: Position, Texcoord, BasicInterleave
{
    static var positionKeyPath: PartialKeyPath<Self> { \Self.position }
    static var texcoordKeyPath: PartialKeyPath<Self> { \Self.texcoord }
}
```

### case 2

``` Swift
extension Vertex: MetalInterleave
{
    public static var metalAttributeDetails: [MetalAttribute]
    {
        [ Attrb<SIMD3<Float>>( .vertex, \Self.position ),
          Attrb<SIMD3<Float>>( .normal, \Self.normal   ) ]
    }
}
```

### case 3

``` Swift
extension Vertex: BasicInterleave, MetalInterleave
{
    public static var basicAttributeDetails: [BasicAttribute]
    {
        metalAttributeDetails
    }
    public static var metalAttributeDetails: [MetalAttribute]
    {
        [ MetalAttrb( .vertex, .float3, \Self.position ),
          MetalAttrb( .normal, .float3, \Self.normal   ) ]
    }
}
```

## Usage

### Interleaved - BasicInterleave

``` Swift
let array: [Vertex] = ...
let geometry: SCNGeometry = Interleaved(array: array)
                                .geometry(primitiveType: .point)
```

### Interleaved - MetalInterleave

``` Swift
let vertexBuffer: MTLBuffer = ...
let geometry: SCNGeometry = Interleaved<Vertex>(buffer: vertexBuffer)
                                .geometry(primitiveType: .point)
```

``` Swift
let elementBuffer: MTLBuffer = ...
let vertexBuffer: MTLBuffer = ...
let geometry: SCNGeometry = Interleaved<Vertex>(buffer: vertexBuffer)
                                .geometry(elements: [(elementBuffer, .point)])
```

### Separated

``` Swift
let vertex: [SIMD3<Float>] = ...
let normal: [SIMD3<Float>] = ...
let geometry: SCNGeometry = Seprated(vertex: vertex, normal: normal)
                                .geometry(primitiveType: .lineStrip)
```

## いつかやる

- ヘッダードックの追記
- ドキュメントの英語化
- テストコードの追加
