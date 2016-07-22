# Rails4 + PostGISのサンプル

基本的にはこんな感じ
https://openbook4.me/users/1/sections/449

`rake db:gis:setup`の前にPostGISをインストールして`CREATE DATABASE`しておく必要がある。

アダプタの公式サイト
https://github.com/rgeo/activerecord-postgis-adapter


```
    create_table :my_spatial_table do |t|
      t.column :shape1, :geometry
      t.geometry :shape2
      t.line_string :path, srid: 3785
      t.st_point :lonlat, geographic: true
      t.st_point :lonlatheight, geographic: true, has_z: true
    end
```

↓


```
rails4_postgis_sample=# \d my_spatial_table
                                    テーブル "public.my_spatial_table"
      列      |            型             |                            修飾語                             
--------------+---------------------------+---------------------------------------------------------------
 id           | integer                   | not null default nextval('my_spatial_table_id_seq'::regclass)
 shape1       | geometry                  | 
 shape2       | geometry                  | 
 path         | geometry(LineString,3785) | 
 lonlat       | geography(Point,4326)     | 
 lonlatheight | geography(PointZ,4326)    | 
インデックス:
    "my_spatial_table_pkey" PRIMARY KEY, btree (id)
```

```
# WKTを使う方法
record.lonlat = 'POINT(-122 47)'

# RGeoのfactoryを使う方法
record.lonlat = record.lonlat.factory.point(-122, 47)

# factoryを取得する別の方法
factory= RGeo::Geographic.spherical_factory(srid: 4326)
```
