# Prometheus Getting Started

## Install prometheus

参见`install_prometheus.sh`

Prometheus配置参见`config/prometheus/prometheus.yml`

## Start prometheus server
./prometheus

## Access prometheus
Access prometheus web ui in browser: <http://192.168.56.30:9090>

Open Status / Targets, the listed target is prometheus itself metrics endpoint.

View prometheus itsef exported metics:
- <http://192.168.56.30:9090/metrics>

## Using the expression browser

On prometheus web ui, open "Graph"

Expression examples:
```bash
# 某个指标，目标抓取之间的实际时间量
prometheus_target_interval_length_seconds

# 99%的延迟，P99 ？
prometheus_target_interval_length_seconds{quantile="0.99"}

# 计算指标的时间系列数量
count(prometheus_target_interval_length_seconds)

# Prometheus 中每秒创建块的速率
rate(prometheus_tsdb_head_chunks_created_total[1m])

```

切换“Graph”查看图表：
- 单击图表下方某个时间系列（series），就会只显示该时间系列的图形
- 按下Cmd + 单击就会恢复显示全部系列

表达式语言参考：
- <https://prometheus.io/docs/prometheus/latest/querying/basics/>

## Install node_exporter
参见`install_prometheus.sh`

## Start node_exporter for test some sample targets

Start node_exporter in different terminals:
```bash
./node_exporter --web.listen-address 127.0.0.1:8080
./node_exporter --web.listen-address 127.0.0.1:8081
./node_exporter --web.listen-address 127.0.0.1:8082
```

In vagrant vm access the above node_exporter metrics endpoints:
- `curl http://localhost:8080/metrics`
- `curl http://localhost:8081/metrics`
- `curl http://localhost:8082/metrics`

## Configure prometheus to monitor the samle targets

修改Prometheus配置参见`config/node_exporter/prometheus.yml`

重启Prometheus.

在Prometheus web ui上，打开Graph，输入node_exporter暴露的指标，比如`node_cpu_seconds_total`

在Prometheus web ui上，打开Status / Targets，可以看到node的3个endpoint。

## Configure rules for aggregating scraped data into new time series

在Prometheus web ui上，打开Graph，输入表达式：

```bash
# 在5分钟的窗口内测量的每个实例的所有 cpu 的平均每秒 cpu 时间
# the per-second rate of cpu time (node_cpu_seconds_total) averaged over all cpus per instance (but preserving the job, instance and mode dimensions) as measured over a window of 5 minutes
avg by (job, instance, mode) (rate(node_cpu_seconds_total[5m]))
```

Create a new metric by prometheus rule.
参见 `config/rule/prometheus.rules.yml`

修改Prometheus配置，让新创建的prometheus rule生效。
参见 `config/rule/prometheus.yml`

重新启动Prometheus。

在Prometheus web ui上，打开Graph，输入新创建的指标： `job_instance_mode:node_cpu_seconds:avg_rate5m`查询

## References
- <https://prometheus.io/docs/prometheus/latest/getting_started/>
