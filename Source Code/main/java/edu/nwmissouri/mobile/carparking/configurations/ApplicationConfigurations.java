package edu.nwmissouri.mobile.carparking.configurations;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

@Configuration
@EnableAsync
@EnableAspectJAutoProxy(proxyTargetClass = true)
@EntityScan(basePackages = "edu.nwmissouri.mobile.carparking.beans")
@EnableJpaRepositories(basePackages = "edu.nwmissouri.mobile.carparking.repositories")
public class ApplicationConfigurations {

    /**
     * Application level common thread pool for all @{@link org.springframework.scheduling.annotation.Async} task
     * executions.
     *
     * @param poolSize         Pool size
     * @param maxPoolSize      Max pool size
     * @param queueCapacity    Max queue capacity
     * @param threadNamePrefix Prefix for thread names associated with this pool
     * @return Executor for executing tasks in allocated thread pool
     */
    @Bean(name = "asyncExecutionThreadPool")
    public Executor asyncExecutionThreadPool(
            @Value("${cp.thread-pool.pool-size:3}") int poolSize,
            @Value("${cp.thread-pool.max-pool-size:5}") int maxPoolSize,
            @Value("${cp.thread-pool.queue-capacity:100}") int queueCapacity,
            @Value("${cp.thread-pool.thread-name-prefix}") String threadNamePrefix) {

        ThreadPoolTaskExecutor threadPoolTaskExecutor = new ThreadPoolTaskExecutor();
        threadPoolTaskExecutor.setCorePoolSize(poolSize);
        threadPoolTaskExecutor.setMaxPoolSize(maxPoolSize);
        threadPoolTaskExecutor.setQueueCapacity(queueCapacity);
        threadPoolTaskExecutor.setThreadNamePrefix(threadNamePrefix);
        threadPoolTaskExecutor.initialize();
        return threadPoolTaskExecutor;
    }

}
