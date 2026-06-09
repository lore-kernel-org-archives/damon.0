Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AB03914E5
	for <damon@lists.linux.dev>; Tue,  9 Jun 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015712; cv=none; b=otZwiNgz4RDwfyCYDBqyeO0F6+7BVQQOZEM5/YyN1yGltbx1gUPiRIMdhJX8a4S/YCIMzghpIpEuS8xDm8sUOKCxcDBCkpyBQR2ThgUnr8TUclXf38eO5tvAOEBu+fEZZW+hwz9h0XfiSpCOqU8p1Kp+2m+5VWe81p+I7+25dUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015712; c=relaxed/simple;
	bh=dKJTw/pWzSgsFSoh9sdSeMqMXIeULsdbhUL7MO3STow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5OVW1ppzzicbJshztBD0E5RKa7GKWc5fgxACw2qlkwkPcmqABojkp34v+sah4jzxes2DjHp6BsQfuA7ckgu1Nng9LVkTpxZ8kfrGwDd1vAaef/K3zZQHVB3Le5jZepVNDSyf+4CIwwzwa1mSXtavPmvJBRgjFHKIcvtG/iLaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aODwuKjx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aODwuKjx"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a7629453so4986645e9.0
        for <damon@lists.linux.dev>; Tue, 09 Jun 2026 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781015706; x=1781620506; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR5bp4H6LHad+wzaYaCmSZGg89XIDlJB7g1MmnBfpT4=;
        b=aODwuKjxMEP92JAkP0rH9/Ia+f349dz89KAgSVRpgrD3VfuijiNZg10I0T8niWKaGx
         EcUYFKVU1+vE6hSmKfJdOnNuZmAAjbe23FAwZmOeFxrk8KN04Wqf+sdofGKr37iy2ayN
         OXN/QzEBbqn3wKbfAv1dOKIy7OxtLMSYTE59od/hPTjOVe8LJOfOjMy3QsQCJPt8Ltk0
         Qg4VcFrgM76l7Vc02gNSQkt1SVTFAm8c7Cg19lHbPQ2WiIArbWrEuDu6x9lBzG6FMA5h
         VtVJTMcp8463tUwSIFfyw4/xZGozxhjp4297whz65tn7vygc1y5Zc3ntwklQy6hpspZo
         T+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015706; x=1781620506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kR5bp4H6LHad+wzaYaCmSZGg89XIDlJB7g1MmnBfpT4=;
        b=MOT77PHYqzBeXAMi5DCQzz95lscpCx4zgNivPfnw48yM7Bho0T4sKsBxChl3azEReC
         8bWjQaeeX25h03f3tNTpgOXVxk3cckdwCoHOFMynQb6LO6F80D7j+XuEq5yrv25PwvVf
         fAvL0/jbGKEWf02eM6QaMofLnWFr/ePvtVT9XJQeg6L4pajpS4GPQIXE3U7OUmF95nc5
         51eutMuapwYRFUgocWulRd4IR3IyIz3kBAlupNrPkRJ+uikFgIy1l6KPn05Y0g6RRiDq
         KryqUHcDuFv5yzG0abnRtNRyMBPcz94+9KK3gv7N/qLICaOE0PZ8BeeMQT3mbSd6Sor0
         gNlw==
X-Forwarded-Encrypted: i=1; AFNElJ/KSaJdzAwkyYgFfoBlSJt5w0hRC4rFPGNbzWFApjw5dP8SWngg6LVbDma4LJhin76s+Ljb4w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjetDz4Jt781+XHRfcai7wz4QWQGSpp49Ox6hsaQYwziSD+Oo3
	EFqYFlt/v9CmF6NC5B907ILXXQs+a28HC/tke39p08HO8BS/phfL1Yj+
X-Gm-Gg: Acq92OE2zq3bc4m+gZnYPGLAT2RJosUwG3ppKagz1rbSbuJjXRhTzJvE8I8AFxG37XI
	nV9kaI5iUu7HKNk5i1a8w3sQEOeNeuCVQ9vT3gfpNxA9g0A7vHuJlXM/qMfeVqsrwKESqKb7Noi
	lxKVTWyh1QXSmgYkqN1Ex3ALi2fnQ1koyNhwhYsXPqCbLvix1LsV5tNP+gBAqjBnIGXcnasb+Pv
	8RkoQC/sA4B8tvz1bGsBY5F85/vXaXam7gqsYBUzntLXXaOCyZZ7u+R/zpVy75M2MFmERCeCLj1
	23CiKjvlcQ8Wf4lYpwXTpJ767gJ0MMeD38f0OTP+e+VEU/yWTVFSKTyxklaur8qm0wWGDo6jOUC
	hn4Vo2fZ1pBAbR6AkCTJxIpYKiDXrjVof4f2kNTFafJ0HGhWUBpMRMD3GBKpDzPnO+OK1ffUwUh
	9zLQ2qJTpTeMm/91stH4BLIe8JtD0cE34AUyQTbL/SABxEfntFVr3GzbB24BjcauHLocw5EkWlE
	0JLwEPCQZUtUeiUwGiQQhZMX+3CH16WKf2wNQ==
X-Received: by 2002:a05:600c:3f0e:b0:490:b288:1a82 with SMTP id 5b1f17b1804b1-490c24ff262mr150218665e9.0.1781015704822;
        Tue, 09 Jun 2026 07:35:04 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm68670615f8f.5.2026.06.09.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:35:03 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	SeongJae Park <sj@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v4 2/2] docs/zh_CN: update DAMON documentation translation
Date: Tue,  9 Jun 2026 14:34:26 +0000
Message-ID: <ef9e2347564b2ffebe231b20e4da049cbceb2374.1781015560.git.doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781015560.git.doehyunbaek@gmail.com>
References: <cover.1781015560.git.doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the translation of .../admin-guide/mm/damon/usage.rst into Chinese.
Translate .../admin-guide/mm/damon/stat.rst into Chinese.
Update .../admin-guide/mm/damon/index.rst for the stat translation.
Translate selected .../mm/damon/design.rst sections into Chinese.

Update the translation through commit d9cfe515d36e
("Docs/admin-guide/mm/damon/usage: document goal_tuner sysfs file")

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 .../zh_CN/admin-guide/mm/damon/index.rst      |   1 +
 .../zh_CN/admin-guide/mm/damon/stat.rst       |  80 +++
 .../zh_CN/admin-guide/mm/damon/usage.rst      | 541 ++++++++++++------
 .../translations/zh_CN/mm/damon/design.rst    | 145 ++++-
 4 files changed, 603 insertions(+), 164 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
index 6f8676a50b38..39e8bac2ce59 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/index.rst
@@ -23,6 +23,7 @@
    usage
    reclaim
    lru_sort
+   stat
 
 
 
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
new file mode 100644
index 000000000000..8267fa2e5fd0
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/mm/damon/stat.rst
+
+:翻译:
+
+ Doehyun Baek <doehyunbaek@gmail.com>
+
+:校译:
+
+======================
+数据访问监测结果统计
+======================
+
+数据访问监测结果统计（DAMON_STAT）是一个静态内核模块，旨在用于简单的访问模式监测。它使用
+DAMON 监测系统整块物理内存上的访问，并提供简化的访问监测结果统计信息，即空闲时间百分位数和
+估计的内存带宽。
+
+.. _damon_stat_monitoring_accuracy_overhead_zh_CN:
+
+监测精度和开销
+==============
+
+DAMON_STAT 使用监测间隔 :ref:`自动调优 <damon_design_monitoring_intervals_autotuning_zh_CN>` 来提高
+精度并最小化开销。它会自动调优间隔，目标是在每个快照中捕获 4 % 的可观测访问事件，同时将所得
+采样间隔限制在最小 5 毫秒、最大 10 秒。在少数生产服务器系统上，它只消耗了 0.x % 的单 CPU
+时间，同时捕获了质量合理的访问模式。调优得到的间隔可以通过 ``aggr_interval_us`` :ref:`参数
+<damon_stat_aggr_interval_us_zh_CN>` 获取。
+
+接口：模块参数
+==============
+
+要使用这个功能，首先应确保你的系统运行在构建时启用了 ``CONFIG_DAMON_STAT=y`` 的内核上。通过
+将 ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` 设置为 true，可以在构建时默认启用该功能。
+
+为了让系统管理员在启动时和/或运行时启用或禁用它，并读取监测结果，DAMON_STAT 提供了模块参数。
+下面的章节描述各个参数。
+
+enabled
+-------
+
+启用或禁用 DAMON_STAT。
+
+你可以把该参数的值设置为 ``Y`` 来启用 DAMON_STAT。设置为 ``N`` 会禁用 DAMON_STAT。默认值由
+``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` 构建配置选项设置。
+
+请注意，该模块（damon_stat）不能与其他基于 DAMON 的专用模块同时运行。更多细节请参考
+:ref:`DAMON 设计文档的专用模块互斥性 <damon_design_special_purpose_modules_exclusivity_zh_CN>`。
+
+.. _damon_stat_aggr_interval_us_zh_CN:
+
+aggr_interval_us
+----------------
+
+自动调优后的聚集时间间隔，单位是微秒。
+
+用户可以读取 DAMON_STAT 使用的 DAMON 实例的聚集间隔。该值会被 :ref:`自动调优
+<damon_stat_monitoring_accuracy_overhead_zh_CN>`，因此会动态变化。
+
+estimated_memory_bandwidth
+--------------------------
+
+系统的估计内存带宽消耗（字节/秒）。
+
+DAMON_STAT 读取当前 DAMON 结果快照上的观测访问事件，并将其转换为以字节/秒为单位的内存带宽
+消耗估计。该结果指标通过这个只读参数向用户公开。由于 DAMON 使用采样，所以这只是访问强度的估计，
+而不是精确的内存带宽。
+
+memory_idle_ms_percentiles
+--------------------------
+
+系统的逐字节空闲时间（毫秒）百分位数。
+
+DAMON_STAT 基于当前 DAMON 结果快照，计算内存中每个字节到当前为止未被访问的时间（空闲时间）。
+对于访问频率（nr_accesses）大于零的区域，当前访问频率级别保持了多久再乘以 ``-1``，就是该区域
+每个字节的空闲时间。如果某个区域的访问频率（nr_accesses）为零，则该区域保持零访问频率的时间
+（age）就是该区域每个字节的空闲时间。然后，DAMON_STAT 通过这个只读参数公开这些空闲时间值的
+百分位数。读取该参数会返回 101 个以毫秒为单位、用逗号分隔的空闲时间值。每个值分别表示第 0、
+第 1、第 2、第 3、……、第 99 和第 100 百分位的空闲时间。
diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
index 9d7cb51be493..cc7ec144c2e2 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/usage.rst
@@ -13,32 +13,37 @@
 详细用法
 ========
 
-DAMON 为不同的用户提供了下面这些接口。
-
-- *DAMON用户空间工具。*
-  `这 <https://github.com/damonitor/damo>`_ 为有这特权的人， 如系统管理员，希望有一个刚好
-  可以工作的人性化界面。
-  使用它，用户可以以人性化的方式使用DAMON的主要功能。不过，它可能不会为特殊情况进行高度调整。
-  它同时支持虚拟和物理地址空间的监测。更多细节，请参考它的 `使用文档
+DAMON 为不同的用户提供如下接口。
+
+- *专用 DAMON 模块。*
+  :ref:`这 <damon_modules_special_purpose_zh_CN>` 适用于构建、发布和/或管理带有专用 DAMON 用法内核
+  的人员。使用该接口，用户可以在构建、启动或运行时，以简单的方式为给定目的使用 DAMON 的主要
+  功能。
+- *DAMON 用户空间工具。*
+  `这 <https://github.com/damonitor/damo>`_ 适用于系统管理员等希望获得开箱即用、人性化界面的
+  特权用户。使用该工具，用户可以以人性化的方式使用 DAMON 的主要功能。不过，它可能不会针对特殊
+  场景进行高度调优。更多细节请参考它的 `使用文档
   <https://github.com/damonitor/damo/blob/next/USAGE.md>`_。
-- *sysfs接口。*
-  :ref:`这 <sysfs_interface>` 是为那些希望更高级的使用DAMON的特权用户空间程序员准备的。
-  使用它，用户可以通过读取和写入特殊的sysfs文件来使用DAMON的主要功能。因此，你可以编写和使
-  用你个性化的DAMON sysfs包装程序，代替你读/写sysfs文件。  `DAMON用户空间工具
-  <https://github.com/damonitor/damo>`_ 就是这种程序的一个例子  它同时支持虚拟和物理地址
-  空间的监测。
+- *sysfs 接口。*
+  :ref:`这 <sysfs_interface_zh_CN>` 适用于希望更优化地使用 DAMON 的特权用户空间程序员。使用该
+  接口，用户可以通过读取和写入特殊的 sysfs 文件来使用 DAMON 的主要功能。因此，你可以编写并使用
+  个性化的 DAMON sysfs 包装程序，由它代替你读写 sysfs 文件。`DAMON 用户空间工具
+  <https://github.com/damonitor/damo>`_ 就是这类程序的一个例子。
 - *内核空间编程接口。*
-  :doc:`这 </mm/damon/api>` 这是为内核空间程序员准备的。使用它，用户可以通过为你编写内
-  核空间的DAMON应用程序，最灵活有效地利用DAMON的每一个功能。你甚至可以为各种地址空间扩展DAMON。
-  详细情况请参考接口 :doc:`文件 </mm/damon/api>`。
+  :doc:`这 </mm/damon/api>` 适用于内核空间程序员。使用该接口，用户可以通过为自己编写内核空间
+  DAMON 应用程序，以最灵活、最高效的方式利用 DAMON 的每一项功能。你甚至可以为各种地址空间扩展
+  DAMON。详细信息请参考接口 :doc:`文档 </mm/damon/api>`。
+
+.. _sysfs_interface_zh_CN:
+
+sysfs 接口
+==========
 
-sysfs接口
-=========
-DAMON的sysfs接口是在定义 ``CONFIG_DAMON_SYSFS`` 时建立的。它在其sysfs目录下创建多
-个目录和文件， ``<sysfs>/kernel/mm/damon/`` 。你可以通过对该目录下的文件进行写入和
-读取来控制DAMON。
+定义 ``CONFIG_DAMON_SYSFS`` 时会构建 DAMON sysfs 接口。它会在自己的 sysfs 目录
+``<sysfs>/kernel/mm/damon/`` 下创建多个目录和文件。你可以通过写入和读取该目录下的文件来控制
+DAMON。
 
-对于一个简短的例子，用户可以监测一个给定工作负载的虚拟地址空间，如下所示::
+作为一个简短示例，用户可以如下监测给定工作负载的虚拟地址空间。::
 
     # cd /sys/kernel/mm/damon/admin/
     # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
@@ -50,258 +55,441 @@ DAMON的sysfs接口是在定义 ``CONFIG_DAMON_SYSFS`` 时建立的。它在其s
 文件层次结构
 ------------
 
-DAMON sysfs接口的文件层次结构如下图所示。在下图中，父子关系用缩进表示，每个目录有
-``/`` 后缀，每个目录中的文件用逗号（","）分开。 ::
+DAMON sysfs 接口的文件层次结构如下所示。在下图中，父子关系用缩进表示，每个目录都带有 ``/``
+后缀，每个目录中的文件用逗号（","）分隔。
 
-    /sys/kernel/mm/damon/admin
-    │ kdamonds/nr_kdamonds
-    │ │ 0/state,pid
-    │ │ │ contexts/nr_contexts
-    │ │ │ │ 0/operations
-    │ │ │ │ │ monitoring_attrs/
+.. parsed-literal::
+
+    :ref:`/sys/kernel/mm/damon <sysfs_root_zh_CN>`/admin
+    │ :ref:`kdamonds <sysfs_kdamonds_zh_CN>`/nr_kdamonds
+    │ │ :ref:`0 <sysfs_kdamond_zh_CN>`/state,pid,refresh_ms
+    │ │ │ :ref:`contexts <sysfs_contexts_zh_CN>`/nr_contexts
+    │ │ │ │ :ref:`0 <sysfs_context_zh_CN>`/avail_operations,operations,addr_unit
+    │ │ │ │ │ :ref:`monitoring_attrs <sysfs_monitoring_attrs_zh_CN>`/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
+    │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
     │ │ │ │ │ │ nr_regions/min,max
-    │ │ │ │ │ targets/nr_targets
-    │ │ │ │ │ │ 0/pid_target
-    │ │ │ │ │ │ │ regions/nr_regions
-    │ │ │ │ │ │ │ │ 0/start,end
+    │ │ │ │ │ :ref:`targets <sysfs_targets_zh_CN>`/nr_targets
+    │ │ │ │ │ │ :ref:`0 <sysfs_target_zh_CN>`/pid_target,obsolete_target
+    │ │ │ │ │ │ │ :ref:`regions <sysfs_regions_zh_CN>`/nr_regions
+    │ │ │ │ │ │ │ │ :ref:`0 <sysfs_region_zh_CN>`/start,end
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
-    │ │ │ │ │ schemes/nr_schemes
-    │ │ │ │ │ │ 0/action
-    │ │ │ │ │ │ │ access_pattern/
+    │ │ │ │ │ :ref:`schemes <sysfs_schemes_zh_CN>`/nr_schemes
+    │ │ │ │ │ │ :ref:`0 <sysfs_scheme_zh_CN>`/action,target_nid,apply_interval_us
+    │ │ │ │ │ │ │ :ref:`access_pattern <sysfs_access_pattern_zh_CN>`/
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
     │ │ │ │ │ │ │ │ age/min,max
-    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
+    │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas_zh_CN>`/ms,bytes,reset_interval_ms,effective_bytes,goal_tuner
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
-    │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
-    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
-    │ │ │ │ │ │ │ tried_regions/
-    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
+    │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals_zh_CN>`/nr_goals
+    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
+    │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks_zh_CN>`/metric,interval_us,high,mid,low
+    │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters_zh_CN>`/nr_filters
+    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
+    │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests_zh_CN>`/nr_dests
+    │ │ │ │ │ │ │ │ 0/id,weight
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats_zh_CN>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
+    │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions_zh_CN>`/total_bytes
+    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ ...
     │ │ ...
 
+.. _sysfs_root_zh_CN:
+
 根
 --
 
-DAMON sysfs接口的根是 ``<sysfs>/kernel/mm/damon/`` ，它有一个名为 ``admin`` 的
-目录。该目录包含特权用户空间程序控制DAMON的文件。拥有根权限的用户空间工具或deamons可以
-使用这个目录。
+DAMON sysfs 接口的根是 ``<sysfs>/kernel/mm/damon/``，它有一个名为 ``admin`` 的目录。该目录
+包含供特权用户空间程序控制 DAMON 的文件。具有 root 权限的用户空间工具或守护进程可以使用该目录。
+
+.. _sysfs_kdamonds_zh_CN:
 
 kdamonds/
 ---------
 
-与监测相关的信息包括请求规格和结果被称为DAMON上下文。DAMON用一个叫做kdamond的内核线程
-执行每个上下文，多个kdamonds可以并行运行。
+在 ``admin`` 目录下，存在一个名为 ``kdamonds`` 的目录，其中包含控制 kdamonds 的文件（更多细节
+请参考 :doc:`设计文档 </mm/damon/design>`）。开始时，该目录只有一个文件 ``nr_kdamonds``。向该
+文件写入一个数字（``N``）会创建 ``0`` 到 ``N-1`` 这些子目录。
+每个目录代表一个 kdamond。
 
-在 ``admin`` 目录下，有一个目录，即``kdamonds``，它有控制kdamonds的文件存在。在开始
-时，这个目录只有一个文件，``nr_kdamonds``。向该文件写入一个数字（``N``），就会创建名为
-``0`` 到 ``N-1`` 的子目录数量。每个目录代表每个kdamond。
+.. _sysfs_kdamond_zh_CN:
 
 kdamonds/<N>/
 -------------
 
-在每个kdamond目录中，存在两个文件（``state`` 和 ``pid`` ）和一个目录( ``contexts`` )。
+每个 kdamond 目录中存在三个文件（``state``、``pid`` 和 ``refresh_ms``）以及一个目录
+（``contexts``）。
+
+读取 ``state`` 时，如果 kdamond 当前正在运行，则返回 ``on``，否则返回 ``off``。
+
+用户可以向 ``state`` 文件写入以下命令来控制 kdamond。
+
+- ``on``：开始运行。
+- ``off``：停止运行。
+- ``commit``：重新读取除 ``state`` 文件以外的 sysfs 文件中的用户输入。如果没有指定目标区域，
+  监测 :ref:`目标区域 <sysfs_regions_zh_CN>` 输入也会被忽略。
+- ``update_tuned_intervals``：使用自动调优后的 ``采样间隔`` 和 ``聚集间隔`` 更新该 kdamond 的
+  ``sample_us`` 和 ``aggr_us`` 文件内容。更多细节请参考 :ref:`intervals_goal 小节
+  <damon_usage_sysfs_monitoring_intervals_goal_zh_CN>`。
+- ``commit_schemes_quota_goals``：读取基于 DAMON 的操作方案的 :ref:`配额目标
+  <sysfs_schemes_quota_goals_zh_CN>`。
+- ``update_schemes_stats``：更新该 kdamond 的每个基于 DAMON 的操作方案的统计文件内容。关于统计
+  信息的细节，请参考 :ref:`stats 小节 <sysfs_schemes_stats_zh_CN>`。
+- ``update_schemes_tried_regions``：更新该 kdamond 的每个基于 DAMON 的操作方案的动作尝试区域目
+  录。关于基于 DAMON 的操作方案动作尝试区域目录的细节，请参考 :ref:`tried_regions 小节
+  <sysfs_schemes_tried_regions_zh_CN>`。
+- ``update_schemes_tried_bytes``：只更新 ``.../tried_regions/total_bytes`` 文件。
+- ``clear_schemes_tried_regions``：清除该 kdamond 的每个基于 DAMON 的操作方案的动作尝试区域目
+  录。
+- ``update_schemes_effective_quotas``：更新该 kdamond 的每个基于 DAMON 的操作方案的
+  ``effective_bytes`` 文件内容。更多细节请参考 :ref:`quotas 目录 <sysfs_quotas_zh_CN>`。
 
-读取 ``state`` 时，如果kdamond当前正在运行，则返回 ``on`` ，如果没有运行则返回 ``off`` 。
-写入 ``on`` 或 ``off`` 使kdamond处于状态。向 ``state`` 文件写 ``update_schemes_stats`` ，
-更新kdamond的每个基于DAMON的操作方案的统计文件的内容。关于统计信息的细节，请参考
-:ref:`stats section <sysfs_schemes_stats>`. 将 ``update_schemes_tried_regions`` 写到
-``state`` 文件，为kdamond的每个基于DAMON的操作方案，更新基于DAMON的操作方案动作的尝试区域目录。
-将`clear_schemes_tried_regions`写入`state`文件，清除kdamond的每个基于DAMON的操作方案的动作
-尝试区域目录。 关于基于DAMON的操作方案动作尝试区域目录的细节，请参考:ref:tried_regions 部分
-<sysfs_schemes_tried_regions>`。
+如果状态为 ``on``，读取 ``pid`` 会显示 kdamond 线程的 pid。
 
-如果状态为 ``on``，读取 ``pid`` 显示kdamond线程的pid。
+用户可以要求内核周期性地更新显示自动调优参数和 DAMOS 统计信息的文件，而不是手动向 ``state``
+文件写入 ``update_tuned_intervals`` 等关键字。为此，用户应向 ``refresh_ms`` 文件写入期望的更新
+时间间隔（毫秒）。如果间隔为零，则禁用周期性更新。读取该文件会显示当前设置的时间间隔。
 
-``contexts`` 目录包含控制这个kdamond要执行的监测上下文的文件。
+``contexts`` 目录包含用于控制该 kdamond 将执行的监测上下文的文件。
+
+.. _sysfs_contexts_zh_CN:
 
 kdamonds/<N>/contexts/
 ----------------------
 
-在开始时，这个目录只有一个文件，即 ``nr_contexts`` 。向该文件写入一个数字( ``N`` )，就会创
-建名为``0`` 到 ``N-1`` 的子目录数量。每个目录代表每个监测背景。目前，每个kdamond只支持
-一个上下文，所以只有 ``0`` 或 ``1`` 可以被写入文件。
+开始时，该目录只有一个文件 ``nr_contexts``。向该文件写入一个数字（``N``）会创建名为 ``0`` 到
+``N-1`` 的子目录。每个目录代表一个监测上下文（更多细节请参考 :doc:`设计文档 </mm/damon/design>`）。
+目前，每个 kdamond 只支持一个上下文，因此只能向该文件写入 ``0`` 或 ``1``。
+
+.. _sysfs_context_zh_CN:
 
 contexts/<N>/
 -------------
 
-在每个上下文目录中，存在一个文件(``operations``)和三个目录(``monitoring_attrs``,
-``targets``, 和 ``schemes``)。
+每个上下文目录中存在三个文件（``avail_operations``、``operations`` 和 ``addr_unit``）以及三个
+目录（``monitoring_attrs``、``targets`` 和 ``schemes``）。
+
+DAMON 支持多种监测操作，包括用于虚拟地址空间和物理地址空间的操作。读取 ``avail_operations``
+文件可以获取当前运行内核中可用的监测操作集列表。根据内核配置，该文件会列出不同的可用操作集。
+所有可用操作集及其简要说明请参考 :doc:`设计文档 </mm/damon/design>`。
+
+你可以向 ``operations`` 文件写入 ``avail_operations`` 文件中列出的关键字之一，并从
+``operations`` 文件读取，来设置和获取 DAMON 将为该上下文使用哪种监测操作。
 
-DAMON支持多种类型的监测操作，包括对虚拟地址空间和物理地址空间的监测。你可以通过向文件
-中写入以下关键词之一，并从文件中读取，来设置和获取DAMON将为上下文使用何种类型的监测操作。
+``addr_unit`` 文件用于设置和获取操作集的地址单位参数。
 
- - vaddr: 监测特定进程的虚拟地址空间
- - paddr: 监视系统的物理地址空间
+.. _sysfs_monitoring_attrs_zh_CN:
 
 contexts/<N>/monitoring_attrs/
 ------------------------------
 
-用于指定监测属性的文件，包括所需的监测质量和效率，都在 ``monitoring_attrs`` 目录中。
-具体来说，这个目录下有两个目录，即 ``intervals`` 和 ``nr_regions`` 。
+用于指定监测属性（包括所需监测质量和效率）的文件位于 ``monitoring_attrs`` 目录中。具体来说，
+该目录中存在两个目录：``intervals`` 和 ``nr_regions``。
+
+在 ``intervals`` 目录下，存在三个 DAMON 间隔文件：采样间隔（``sample_us``）、聚集间隔
+（``aggr_us``）和更新间隔（``update_us``）。你可以通过写入和读取这些文件来设置和获取以微秒为
+单位的值。
+
+在 ``nr_regions`` 目录下，存在两个用于 DAMON 监测区域下限和上限的文件（分别为 ``min`` 和
+``max``），它们控制监测开销。你可以通过写入和读取这些文件来设置和获取这些值。
+
+关于间隔和监测区域范围的更多细节，请参考设计文档（:doc:`/mm/damon/design`）。
+
+.. _damon_usage_sysfs_monitoring_intervals_goal_zh_CN:
 
-在 ``intervals`` 目录下，存在DAMON的采样间隔(``sample_us``)、聚集间隔(``aggr_us``)
-和更新间隔(``update_us``)三个文件。你可以通过写入和读出这些文件来设置和获取微秒级的值。
+contexts/<N>/monitoring_attrs/intervals/intervals_goal/
+-------------------------------------------------------
 
-在 ``nr_regions`` 目录下，有两个文件分别用于DAMON监测区域的下限和上限（``min`` 和 ``max`` ），
-这两个文件控制着监测的开销。你可以通过向这些文件的写入和读出来设置和获取这些值。
+在 ``intervals`` 目录下，还存在一个用于自动调优 ``sample_us`` 和 ``aggr_us`` 的目录，即
+``intervals_goal`` 目录。该目录下有四个用于自动调优控制的文件，即 ``access_bp``、``aggrs``、
+``min_sample_us`` 和 ``max_sample_us``。关于调优机制的内部细节，请参考该功能的 :ref:`设计文档
+<damon_design_monitoring_intervals_autotuning_zh_CN>`。读取和写入 ``intervals_goal`` 目录下的这四个
+文件，会显示和更新 :ref:`设计文档 <damon_design_monitoring_intervals_autotuning_zh_CN>` 中描述的同名
+调优参数。调优从用户设置的 ``sample_us`` 和 ``aggr_us`` 开始。向 ``state`` 文件写入
+``update_tuned_intervals`` 后，可以从 ``sample_us`` 和 ``aggr_us`` 文件读取应用调优后的两个当前
+间隔值。
 
-关于间隔和监测区域范围的更多细节，请参考设计文件 (:doc:`/mm/damon/design`)。
+.. _sysfs_targets_zh_CN:
 
 contexts/<N>/targets/
 ---------------------
 
-在开始时，这个目录只有一个文件 ``nr_targets`` 。向该文件写入一个数字(``N``)，就可以创建
-名为 ``0`` 到 ``N-1`` 的子目录的数量。每个目录代表每个监测目标。
+开始时，该目录只有一个文件 ``nr_targets``。向该文件写入一个数字（``N``）会创建名为 ``0`` 到
+``N-1`` 的子目录。每个目录代表一个监测目标。
+
+.. _sysfs_target_zh_CN:
 
 targets/<N>/
 ------------
 
-在每个目标目录中，存在一个文件(``pid_target``)和一个目录(``regions``)。
+每个目标目录中存在两个文件（``pid_target`` 和 ``obsolete_target``）以及一个目录
+（``regions``）。
+
+如果你向 ``contexts/<N>/operations`` 写入了 ``vaddr``，则每个目标都应该是一个进程。你可以通过
+向 ``pid_target`` 文件写入进程 pid 来指定 DAMON 要监测的进程。
 
-如果你把 ``vaddr`` 写到 ``contexts/<N>/operations`` 中，每个目标应该是一个进程。你
-可以通过将进程的pid写到 ``pid_target`` 文件中来指定DAMON的进程。
+用户可以向 ``obsolete_target`` 文件写入非零值并提交它（向 ``state`` 文件写入 ``commit``），
+从目标数组中间选择性地删除目标。DAMON 会从它的内部目标数组中删除匹配的目标。用户负责重新构造
+目标目录，使它们正确表示改变后的内部目标数组。
+
+.. _sysfs_regions_zh_CN:
 
 targets/<N>/regions
 -------------------
 
-当使用 ``vaddr`` 监测操作集时（ ``vaddr`` 被写入 ``contexts/<N>/operations`` 文
-件），DAMON自动设置和更新监测目标区域，这样就可以覆盖目标进程的整个内存映射。然而，用户可
-能希望将初始监测区域设置为特定的地址范围。
+对于 ``fvaddr`` 或 ``paddr`` 监测操作集，用户需要设置监测目标地址范围。对于 ``vaddr`` 操作集，
+这不是强制要求，但用户可以选择性地将初始监测区域设置为特定地址范围。更多细节请参考
+:ref:`设计文档 <damon_design_vaddr_target_regions_construction_zh_CN>`。
 
-相反，当使用 ``paddr`` 监测操作集时，DAMON不会自动设置和更新监测目标区域（ ``paddr``
-被写入 ``contexts/<N>/operations`` 中）。因此，在这种情况下，用户应该自己设置监测目标
+在这些情况下，用户可以按照自己的意愿，通过向该目录下的文件写入适当的值来显式设置初始监测目标
 区域。
 
-在这种情况下，用户可以按照自己的意愿明确设置初始监测目标区域，将适当的值写入该目录下的文件。
+开始时，该目录只有一个文件 ``nr_regions``。向该文件写入一个数字（``N``）会创建名为 ``0`` 到
+``N-1`` 的子目录。每个目录代表一个初始监测目标区域。
+
+在线提交新的 DAMON 参数时（向 :ref:`kdamond <sysfs_kdamond_zh_CN>` 的 ``state`` 文件写入
+``commit``），如果 ``nr_regions`` 为零，提交逻辑会忽略目标区域。换句话说，会保留该目标当前的
+监测结果。
 
-开始时，这个目录只有一个文件， ``nr_regions`` 。向该文件写入一个数字(``N``)，就可以创
-建名为 ``0`` 到  ``N-1`` 的子目录。每个目录代表每个初始监测目标区域。
+.. _sysfs_region_zh_CN:
 
 regions/<N>/
 ------------
 
-在每个区域目录中，你会发现两个文件（ ``start``  和  ``end`` ）。你可以通过向文件写入
-和从文件中读出，分别设置和获得初始监测目标区域的起始和结束地址。
+在每个区域目录中，你会看到两个文件（``start`` 和 ``end``）。你可以通过写入和读取这些文件，分
+别设置和获取初始监测目标区域的起始地址和结束地址。
 
-每个区域不应该与其他区域重叠。 目录“N”的“结束”应等于或小于目录“N+1”的“开始”。
+各区域之间不应重叠。目录 ``N`` 的 ``end`` 应小于或等于目录 ``N+1`` 的 ``start``。
+
+.. _sysfs_schemes_zh_CN:
 
 contexts/<N>/schemes/
 ---------------------
 
-对于一版的基于DAMON的数据访问感知的内存管理优化，用户通常希望系统对特定访问模式的内存区
-域应用内存管理操作。DAMON从用户那里接收这种形式化的操作方案，并将这些方案应用于目标内存
-区域。用户可以通过读取和写入这个目录下的文件来获得和设置这些方案。
+这是用于基于 DAMON 的操作方案（DAMON-based Operation Schemes，DAMOS）的目录。用户可以通过
+读取和写入该目录下的文件来获取和设置方案。更多背景请参考 :doc:`设计文档 </mm/damon/design>`。
+
+开始时，该目录只有一个文件 ``nr_schemes``。向该文件写入一个数字（``N``）会创建名为 ``0`` 到
+``N-1`` 的子目录。每个目录代表一个基于 DAMON 的操作方案。
 
-在开始时，这个目录只有一个文件，``nr_schemes``。向该文件写入一个数字(``N``)，就可以
-创建名为``0``到``N-1``的子目录的数量。每个目录代表每个基于DAMON的操作方案。
+.. _sysfs_scheme_zh_CN:
 
 schemes/<N>/
 ------------
 
-在每个方案目录中，存在五个目录(``access_pattern``、``quotas``、``watermarks``、
-``stats`` 和 ``tried_regions``)和一个文件(``action``)。
+每个方案目录中存在九个目录（``access_pattern``、``quotas``、``watermarks``、
+``core_filters``、``ops_filters``、``filters``、``dests``、``stats`` 和 ``tried_regions``）
+以及三个文件（``action``、``target_nid`` 和 ``apply_interval_us``）。
+
+``action`` 文件用于设置和获取方案的动作。可写入和读取该文件的关键字及其含义与 :doc:`设计文档
+</mm/damon/design>` 中的列表相同。
+
+``target_nid`` 文件用于设置迁移目标节点。只有当 ``action`` 为 ``migrate_hot`` 或
+``migrate_cold`` 时，该文件才有意义。
 
-``action`` 文件用于设置和获取你想应用于具有特定访问模式的内存区域的动作。可以写入文件
-和从文件中读取的关键词及其含义如下。
+``apply_interval_us`` 文件用于以微秒为单位设置和获取方案的 ``apply_interval``。
 
- - ``willneed``: 对有 ``MADV_WILLNEED`` 的区域调用 ``madvise()`` 。
- - ``cold``: 对具有 ``MADV_COLD`` 的区域调用 ``madvise()`` 。
- - ``pageout``: 为具有 ``MADV_PAGEOUT`` 的区域调用 ``madvise()`` 。
- - ``hugepage``: 为带有 ``MADV_HUGEPAGE`` 的区域调用 ``madvise()`` 。
- - ``nohugepage``: 为带有 ``MADV_NOHUGEPAGE`` 的区域调用 ``madvise()``。
- - ``lru_prio``: 在其LRU列表上对区域进行优先排序。
- - ``lru_deprio``: 对区域的LRU列表进行降低优先处理。
- - ``stat``: 什么都不做，只计算统计数据
+.. _sysfs_access_pattern_zh_CN:
 
 schemes/<N>/access_pattern/
 ---------------------------
 
-每个基于DAMON的操作方案的目标访问模式由三个范围构成，包括以字节为单位的区域大小、每个
-聚合区间的监测访问次数和区域年龄的聚合区间数。
+该目录用于给定的基于 DAMON 的操作方案的目标访问模式。
 
-在 ``access_pattern`` 目录下，存在三个目录（ ``sz``, ``nr_accesses``, 和 ``age`` ），
-每个目录有两个文件（``min`` 和 ``max`` ）。你可以通过向  ``sz``, ``nr_accesses``, 和
-``age``  目录下的 ``min`` 和 ``max`` 文件分别写入和读取来设置和获取给定方案的访问模式。
+在 ``access_pattern`` 目录下，存在三个目录（``sz``、``nr_accesses`` 和 ``age``），每个目录都有
+两个文件（``min`` 和 ``max``）。你可以分别向 ``sz``、``nr_accesses`` 和 ``age`` 目录下的
+``min`` 和 ``max`` 文件写入并读取，以设置和获取给定方案的访问模式。注意，``min`` 和 ``max`` 构
+成闭区间。
+
+.. _sysfs_quotas_zh_CN:
 
 schemes/<N>/quotas/
 -------------------
 
-每个 ``动作`` 的最佳 ``目标访问模式`` 取决于工作负载，所以不容易找到。更糟糕的是，将某些动作
-的方案设置得过于激进会造成严重的开销。为了避免这种开销，用户可以为每个方案限制时间和大小配额。
-具体来说，用户可以要求DAMON尽量只使用特定的时间（``时间配额``）来应用动作，并且在给定的时间间
-隔（``重置间隔``）内，只对具有目标访问模式的内存区域应用动作，而不使用特定数量（``大小配额``）。
+该目录用于给定的基于 DAMON 的操作方案的配额。
+
+在 ``quotas`` 目录下，存在五个文件（``ms``、``bytes``、``reset_interval_ms``、
+``effective_bytes`` 和 ``goal_tuner``）以及两个目录（``weights`` 和 ``goals``）。
+
+你可以分别向这三个文件写入数值，设置以毫秒为单位的 ``时间配额``、以字节为单位的 ``大小配额``
+以及以毫秒为单位的 ``重置间隔``。随后，DAMON 会尝试最多只使用 ``时间配额`` 毫秒，将 ``action``
+应用于符合 ``access_pattern`` 的内存区域，并且在 ``reset_interval_ms`` 内最多只对 ``bytes`` 字
+节的内存区域应用该动作。如果 ``ms`` 和 ``bytes`` 都设置为零，除非至少设置了一个 :ref:`目标
+<sysfs_schemes_quota_goals_zh_CN>`，否则会禁用配额限制。
+
+你可以通过向 ``goal_tuner`` 文件写入算法名称，设置要使用的基于目标的有效配额自动调优算法。读
+取该文件会返回当前选择的调优器算法。关于该功能的背景设计和可选算法名称，请参考
+:doc:`设计文档 </mm/damon/design>` 中的自动配额调优目标。关于目标设置，请参考 :ref:`goals 目录
+<sysfs_schemes_quota_goals_zh_CN>`。
+
+时间配额会在内部转换为大小配额。在转换后的大小配额和用户指定的大小配额之间，会应用较小者。基
+于用户指定的 :ref:`目标 <sysfs_schemes_quota_goals_zh_CN>`，有效大小配额会被进一步调整。读取
+``effective_bytes`` 会返回当前有效大小配额。该文件不会实时更新，因此用户应要求 DAMON sysfs 接
+口更新该文件内容：向相关的 ``kdamonds/<N>/state`` 文件写入特殊关键字
+``update_schemes_effective_quotas``。
+
+在 ``weights`` 目录下，存在三个文件（``sz_permil``、``nr_accesses_permil`` 和 ``age_permil``）。
+你可以通过向 ``weights`` 目录下的这三个文件写入数值，以千分之一为单位设置大小、访问频率和年龄
+的优先级权重。
+
+.. _sysfs_schemes_quota_goals_zh_CN:
+
+schemes/<N>/quotas/goals/
+-------------------------
 
-当预计超过配额限制时，DAMON会根据 ``目标访问模式`` 的大小、访问频率和年龄，对找到的内存区域
-进行优先排序。为了进行个性化的优先排序，用户可以为这三个属性设置权重。
+该目录用于给定的基于 DAMON 的操作方案的自动配额调优目标。
 
-在 ``quotas`` 目录下，存在三个文件（``ms``, ``bytes``, ``reset_interval_ms``）和一个
-目录(``weights``)，其中有三个文件(``sz_permil``, ``nr_accesses_permil``, 和
-``age_permil``)。
+开始时，该目录只有一个文件 ``nr_goals``。向该文件写入一个数字（``N``）会创建名为 ``0`` 到
+``N-1`` 的子目录。每个目录代表一个目标及其当前达成情况。在多个反馈中，会使用最好的一个。
 
-你可以设置以毫秒为单位的 ``时间配额`` ，以字节为单位的 ``大小配额`` ，以及以毫秒为单位的 ``重
-置间隔`` ，分别向这三个文件写入数值。你还可以通过向 ``weights`` 目录下的三个文件写入数值来设
-置大小、访问频率和年龄的优先权，单位为千分之一。
+每个目标目录包含五个文件，即 ``target_metric``、``target_value``、``current_value``、``nid``
+和 ``path``。用户可以通过写入和读取这些文件，设置和获取 :doc:`设计文档 </mm/damon/design>` 中
+指定的配额自动调优目标的五个参数。注意，用户还应向 :ref:`kdamond 目录 <sysfs_kdamond_zh_CN>` 的
+``state`` 文件写入 ``commit_schemes_quota_goals``，
+以将反馈传递给 DAMON。
+
+.. _sysfs_watermarks_zh_CN:
 
 schemes/<N>/watermarks/
 -----------------------
 
-为了便于根据系统状态激活和停用每个方案，DAMON提供了一个称为水位的功能。该功能接收五个值，称为
-``度量`` 、``间隔`` 、``高`` 、``中`` 、``低`` 。``度量值`` 是指可以测量的系统度量值，如
-自由内存比率。如果系统的度量值 ``高`` 于memoent的高值或 ``低`` 于低值，则该方案被停用。如果
-该值低于 ``中`` ，则该方案被激活。
+该目录用于给定的基于 DAMON 的操作方案的水位。
 
-在水位目录下，存在五个文件(``metric``, ``interval_us``,``high``, ``mid``, and ``low``)
-用于设置每个值。你可以通过向这些文件的写入来分别设置和获取这五个值。
+在 ``watermarks`` 目录下，存在五个文件（``metric``、``interval_us``、``high``、``mid`` 和
+``low``），用于设置度量、检查该度量的时间间隔以及三个水位。你可以通过写入这些文件分别设置并获
+取这五个值。
 
-可以写入 ``metric`` 文件的关键词和含义如下。
+可写入 ``metric`` 文件的关键字及其含义如下。
 
- - none: 忽略水位
- - free_mem_rate: 系统的自由内存率（千分比）。
+ - none：忽略水位
+ - free_mem_rate：系统空闲内存率（千分比）
 
 ``interval`` 应以微秒为单位写入。
 
+.. _sysfs_filters_zh_CN:
+
+schemes/<N>/{core\_,ops\_,}filters/
+-----------------------------------
+
+这些目录用于给定的基于 DAMON 的操作方案的过滤器。
+
+``core_filters`` 和 ``ops_filters`` 目录分别用于由 DAMON 核心层和操作集层处理的过滤器。
+``filters`` 目录可用于安装不区分处理层的过滤器。通过 ``core_filters`` 和 ``ops_filters`` 请求
+的过滤器会在 ``filters`` 的过滤器之前安装。三个目录具有相同的文件。
+
+使用 ``filters`` 目录时，通过目录下文件预期给定过滤器的求值顺序可能会有些混乱。因此，建议用户
+使用 ``core_filters`` 和 ``ops_filters`` 目录。``filters`` 目录未来可能会被弃用。
+
+开始时，该目录只有一个文件 ``nr_filters``。向该文件写入一个数字（``N``）会创建名为 ``0`` 到
+``N-1`` 的子目录。每个目录代表一个过滤器。过滤器按数字顺序求值。
+
+每个过滤器目录包含九个文件，即 ``type``、``matching``、``allow``、``memcg_path``、
+``addr_start``、``addr_end``、``min``、``max`` 和 ``target_idx``。可以向 ``type`` 文件写入过滤
+器类型。可用类型名称、含义以及它们由哪一层处理，请参考 :doc:`设计文档 </mm/damon/design>`。
+
+对于 ``memcg`` 类型，可以通过向 ``memcg_path`` 文件写入从 cgroups 挂载点开始的内存 cgroup 路径
+来指定关注的内存 cgroup。对于 ``addr`` 类型，可以分别向 ``addr_start`` 和 ``addr_end`` 文件写入
+范围（开区间）的起始和结束地址。对于 ``hugepage_size`` 类型，可以分别向 ``min`` 和 ``max`` 文件
+写入范围（闭区间）的最小和最大大小。对于 ``target`` 类型，可以向 ``target_idx`` 文件写入 DAMON
+上下文监测目标列表中的目标索引。
+
+可以向 ``matching`` 文件写入 ``Y`` 或 ``N``，指定过滤器是否用于匹配 ``type`` 的内存。可以向
+``allow`` 文件写入 ``Y`` 或 ``N``，指定是否允许对满足 ``type`` 和 ``matching`` 的内存应用动作。
+
+下面的示例将一个 DAMOS 动作限制为只应用于所有内存 cgroup 中的非匿名页，但排除
+``/having_care_already``。::
+
+    # cd ops_filters/0/
+    # echo 2 > nr_filters
+    # # disallow anonymous pages
+    echo anon > 0/type
+    echo Y > 0/matching
+    echo N > 0/allow
+    # # further filter out all cgroups except one at '/having_care_already'
+    echo memcg > 1/type
+    echo /having_care_already > 1/memcg_path
+    echo Y > 1/matching
+    echo N > 1/allow
+
+更多细节，包括多个不同 ``allow`` 的过滤器如何工作、每个过滤器何时受支持以及统计信息差异，请参考
+:doc:`DAMOS 过滤器设计文档 </mm/damon/design>`。
+
+.. _damon_sysfs_dests_zh_CN:
+
+schemes/<N>/dests/
+------------------
+
+该目录用于指定给定的基于 DAMON 的操作方案动作的目标。如果给定方案的动作不支持多个目标，则忽略
+该目录。只有 ``DAMOS_MIGRATE_{HOT,COLD}`` 动作支持多个目标。
+
+开始时，该目录只有一个文件 ``nr_dests``。向该文件写入一个数字（``N``）会创建名为 ``0`` 到
+``N-1`` 的子目录。每个目录代表一个动作目标。
+
+每个目标目录包含两个文件，即 ``id`` 和 ``weight``。用户可以向 ``id`` 文件写入目标标识符，也可
+以从该文件读取目标标识符。对于 ``DAMOS_MIGRATE_{HOT,COLD}`` 动作，应向 ``id`` 文件写入迁移目
+标节点的节点 id。用户可以向 ``weight`` 文件写入和读取给定目标之间的目标权重。权重可以是任意整
+数。当 DAMOS 对内存区域中的每个实体应用动作时，它会基于这些目标的相对权重选择动作目标。
+
+.. _sysfs_schemes_stats_zh_CN:
+
 schemes/<N>/stats/
 ------------------
 
-DAMON统计每个方案被尝试应用的区域的总数量和字节数，每个方案被成功应用的区域的两个数字，以及
-超过配额限制的总数量。这些统计数据可用于在线分析或调整方案。
+DAMON 会统计每个方案的信息。这些统计信息可用于方案的在线分析或调优。关于统计信息的更多细节，
+请参考 :doc:`设计文档 </mm/damon/design>`。
 
-可以通过读取 ``stats`` 目录下的文件(``nr_tried``, ``sz_tried``, ``nr_applied``,
-``sz_applied``, 和 ``qt_exceeds``)）分别检索这些统计数据。这些文件不是实时更新的，所以
-你应该要求DAMON sysfs接口通过在相关的 ``kdamonds/<N>/state`` 文件中写入一个特殊的关键字
-``update_schemes_stats`` 来更新统计信息的文件内容。
+可以通过读取 ``stats`` 目录下的文件分别检索这些统计信息：``nr_tried``、``sz_tried``、
+``nr_applied``、``sz_applied``、``sz_ops_filter_passed``、``qt_exceeds``、``nr_snapshots`` 和
+``max_nr_snapshots``。
+
+这些文件默认不会实时更新。用户应要求 DAMON sysfs 接口使用 ``refresh_ms`` 周期性地更新这些文件，
+或者通过向相关的 ``kdamonds/<N>/state`` 文件写入特殊关键字 ``update_schemes_stats`` 来执行一次
+性更新。更多细节请参考 :ref:`kdamond 目录 <sysfs_kdamond_zh_CN>`。
+
+.. _sysfs_schemes_tried_regions_zh_CN:
 
 schemes/<N>/tried_regions/
 --------------------------
 
-当一个特殊的关键字 ``update_schemes_tried_regions`` 被写入相关的 ``kdamonds/<N>/state``
-文件时，DAMON会在这个目录下创建从 ``0`` 开始命名的整数目录。每个目录包含的文件暴露了关于每个
-内存区域的详细信息，在下一个 :ref:`聚集区间 <sysfs_monitoring_attrs>`，相应的方案的 ``动作``
-已经尝试在这个目录下应用。这些信息包括地址范围、``nr_accesses`` 以及区域的 ``年龄`` 。
+该目录开始时有一个文件 ``total_bytes``。
+
+当向相关的 ``kdamonds/<N>/state`` 文件写入特殊关键字 ``update_schemes_tried_regions`` 时，
+DAMON 会更新 ``total_bytes`` 文件，使读取该文件返回方案尝试区域的总大小，并在该目录下创建从
+``0`` 开始命名的整数目录。每个目录包含的文件会暴露对应方案的 ``action`` 在下一个对应方案的
+应用间隔中，已经尝试应用到的每个内存区域的详细信息。该信息包括区域的地址范围、``nr_accesses``
+和 ``age``。
+
+向相关的 ``kdamonds/<N>/state`` 文件写入 ``update_schemes_tried_bytes`` 只会更新
+``total_bytes`` 文件，而不会创建子目录。
 
-当另一个特殊的关键字 ``clear_schemes_tried_regions`` 被写入相关的 ``kdamonds/<N>/state``
-文件时，这些目录将被删除。
+当向相关的 ``kdamonds/<N>/state`` 文件写入另一个特殊关键字 ``clear_schemes_tried_regions`` 时，
+这些目录会被删除。
+
+该目录的预期用途是调查方案行为，以及像查询一样高效地检索数据访问监测结果。特别是对于后一种用
+例，用户可以将 ``action`` 设置为 ``stat``，并将 ``access pattern`` 设置为他们想查询的感兴趣模
+式。
+
+.. _sysfs_schemes_tried_region_zh_CN:
 
 tried_regions/<N>/
 ------------------
 
-在每个区域目录中，你会发现四个文件(``start``, ``end``, ``nr_accesses``, and ``age``)。
-读取这些文件将显示相应的基于DAMON的操作方案 ``动作`` 试图应用的区域的开始和结束地址、``nr_accesses``
-和 ``年龄`` 。
+在每个区域目录中，你会看到五个文件（``start``、``end``、``nr_accesses``、``age`` 和
+``sz_filter_passed``）。读取这些文件会显示对应的基于 DAMON 的操作方案 ``action`` 已经尝试应用
+到的区域属性。
 
-用例
+示例
 ~~~~
 
-下面的命令应用了一个方案：”如果一个大小为[4KiB, 8KiB]的内存区域在[10, 20]的聚合时间间隔内
-显示出每一个聚合时间间隔[0, 5]的访问量，请分页该区域。对于分页，每秒最多只能使用10ms，而且每
-秒分页不能超过1GiB。在这一限制下，首先分页出具有较长年龄的内存区域。另外，每5秒钟检查一次系统
-的可用内存率，当可用内存率低于50%时开始监测和分页，但如果可用内存率大于60%，或低于30%，则停
-止监测。“ ::
+以下命令会应用一个方案，其含义是：“如果一个大小在 [4KiB, 8KiB] 之间的内存区域，在 [10, 20]
+个聚集间隔内，每个聚集间隔显示 [0, 5] 次访问，则换出该区域。对于换出操作，每秒最多只使用 10ms，
+并且每秒换出的内存不超过 1GiB。在这些限制下，优先换出年龄更长的内存区域。同时，每 5 秒检查一
+次系统空闲内存率；当空闲内存率低于 50% 时开始监测和换出，但如果空闲内存率高于 60% 或低于 30%，
+则停止。”::
 
     # cd <sysfs>/kernel/mm/damon/admin
     # # populate directories
@@ -327,19 +515,46 @@ tried_regions/<N>/
     # echo 500 > watermarks/mid
     # echo 300 > watermarks/low
 
-请注意，我们强烈建议使用用户空间的工具，如 `damo <https://github.com/damonitor/damo>`_ ，
-而不是像上面那样手动读写文件。以上只是一个例子。
+请注意，强烈建议使用像 `damo <https://github.com/damonitor/damo>`_ 这样的用户空间工具，而不是像
+上面那样手动读取和写入文件。上面的内容只是一个示例。
 
+.. _tracepoint_zh_CN:
 
 监测结果的监测点
 ================
 
-DAMON通过一个tracepoint ``damon:damon_aggregated`` 提供监测结果.  当监测开启时，你可
-以记录追踪点事件，并使用追踪点支持工具如perf显示结果。比如说::
+用户可以通过 :ref:`tried_regions <sysfs_schemes_tried_regions_zh_CN>` 获取监测结果。该接口对获
+取快照很有用，但用于完整记录所有监测结果时可能效率较低。为此，DAMON 提供两个 tracepoint，即
+``damon:damon_aggregated`` 和 ``damon:damos_before_apply``。``damon:damon_aggregated`` 提供
+完整监测结果，而 ``damon:damos_before_apply`` 提供每个基于 DAMON 的操作方案（DAMOS）即将应用
+到的区域的监测结果。因此，``damon:damos_before_apply`` 更适合记录 DAMOS 的内部行为，或者基于
+DAMOS 目标访问模式进行类似查询的高效监测结果记录。
 
-    # echo on > monitor_on_DEPRECATED
+监测开启时，你可以记录 tracepoint 事件，并使用支持 tracepoint 的工具（如 ``perf``）显示结果。
+例如::
+
+    # echo on > kdamonds/0/state
     # perf record -e damon:damon_aggregated &
     # sleep 5
     # kill 9 $(pidof perf)
-    # echo off > monitor_on_DEPRECATED
+    # echo off > kdamonds/0/state
     # perf script
+    kdamond.0 46568 [027] 79357.842179: damon:damon_aggregated: target_id=0 nr_regions=11 122509119488-135708762112: 0 864
+    [...]
+
+perf 脚本输出中的每一行代表一个监测区域。前五个字段与通常的 tracepoint 输出相同。第六个字段
+（``target_id=X``）显示该区域所属监测目标的 id。第七个字段（``nr_regions=X``）显示该目标的监测
+区域总数。第八个字段（``X-Y:``）显示该区域以字节为单位的起始地址（``X``）和结束地址（``Y``）。
+第九个字段（``X``）显示该区域的 ``nr_accesses`` （关于该计数器的更多细节请参考 :ref:`设计文档
+<damon_design_region_based_sampling_zh_CN>`）。最后，第十个字段（``X``）显示该区域的 ``age`` （关于该
+计数器的更多细节请参考 :ref:`设计文档 <damon_design_age_tracking_zh_CN>`）。
+
+如果事件是 ``damon:damos_before_apply``，perf 脚本输出大致如下::
+
+    kdamond.0 47293 [000] 80801.060214: damon:damos_before_apply: ctx_idx=0 scheme_idx=0 target_idx=0 nr_regions=11 121932607488-135128711168: 0 136
+    [...]
+
+输出中的每一行代表在跟踪时刻每个基于 DAMON 的操作方案即将应用到的每个监测区域。前五个字段与
+通常情况相同。除了 ``damon_aggregated`` tracepoint 的输出外，它还显示该方案所属 DAMON 上下文
+在该上下文所属 kdamond 的上下文列表中的索引（``ctx_idx=X``），以及该方案在该上下文的方案列表
+中的索引（``scheme_idx=X``）。
diff --git a/Documentation/translations/zh_CN/mm/damon/design.rst b/Documentation/translations/zh_CN/mm/damon/design.rst
index 16e3db34a7dd..cb6479783863 100644
--- a/Documentation/translations/zh_CN/mm/damon/design.rst
+++ b/Documentation/translations/zh_CN/mm/damon/design.rst
@@ -38,6 +38,8 @@ DAMON提供了数据访问监控功能，同时使其准确性和开销可控。
 DAMON目前为物理和虚拟地址空间提供了基元的实现。下面两个小节描述了这些工作的方式。
 
 
+.. _damon_design_vaddr_target_regions_construction_zh_CN:
+
 基于VMA的目标地址范围构造
 -------------------------
 
@@ -103,6 +105,8 @@ DAMON的输出显示了在给定的时间内哪些页面的访问频率是多少
 这种机制的监测开销将随着目标工作负载规模的增长而任意增加。
 
 
+.. _damon_design_region_based_sampling_zh_CN:
+
 基于区域的抽样调查
 ------------------
 
@@ -115,6 +119,8 @@ DAMON的输出显示了在给定的时间内哪些页面的访问频率是多少
 然而，如果假设没有得到保证，这个方案就不能保持输出的质量。
 
 
+.. _damon_design_adaptive_regions_adjustment_zh_CN:
+
 适应性区域调整
 --------------
 
@@ -128,6 +134,17 @@ DAMON的输出显示了在给定的时间内哪些页面的访问频率是多少
 
 通过这种方式，DAMON提供了其最佳的质量和最小的开销，同时保持了用户为其权衡设定的界限。
 
+.. _damon_design_age_tracking_zh_CN:
+
+年龄跟踪
+--------
+
+通过分析监测结果，用户还可以发现某个区域当前的访问模式已经保持了多长时间。这可用于更好地理解
+访问模式。例如，可以利用访问频率和时近性实现页面放置算法。为了让这种访问模式保持时间分析更容
+易，DAMON 在每个区域中维护另一个名为 ``age`` 的计数器。对于每个 ``聚集间隔``，DAMON 检查该
+区域的大小和访问频率（``nr_accesses``）是否发生了显著变化。如果发生了变化，该计数器会被重置为
+零。否则，该计数器会增加。
+
 
 动态目标空间更新处理
 --------------------
@@ -137,4 +154,130 @@ DAMON的输出显示了在给定的时间内哪些页面的访问频率是多少
 
 由于在某些情况下变化可能相当频繁，DAMON允许监控操作检查动态变化，包括内存映射变化，
 并仅在用户指定的时间间隔（ ``更新间隔`` ）中的每个时间段，将其应用于监控操作相关的
-数据结构，如抽象的监控目标内存区。
\ No newline at end of file
+数据结构，如抽象的监控目标内存区。
+
+
+.. _damon_design_monitoring_params_tuning_guide_zh_CN:
+
+监测参数调优指南
+----------------
+
+简而言之，应设置 ``聚集间隔``，使其能够为使用目的捕获有意义数量的访问。访问数量可以用聚集后
+监测结果快照中各区域的 ``nr_accesses`` 和 ``age`` 来衡量。该间隔的默认值 ``100ms`` 在许多情况
+下被证明过短。应按 ``聚集间隔`` 的比例设置 ``采样间隔``。默认推荐比例为 ``1/20``。
+
+``聚集间隔`` 应设置为工作负载可在该间隔内为监测目的产生一定数量访问的时间间隔。如果该间隔过短，
+只能捕获少量访问。结果是，监测结果会看起来像所有内容都同样只是很少被访问。对许多目的而言，这
+将毫无用处。不过，如果该间隔过长，根据给定目的的时间尺度，区域通过 :ref:`区域调整机制
+<damon_design_adaptive_regions_adjustment_zh_CN>` 收敛所需的时间可能过长。如果工作负载实际只产生
+很少访问，而用户却认为监测目的所需的访问数量很高，就可能发生这种情况。对于这种情况，应仔细重
+新考虑每个 ``聚集间隔`` 要捕获的目标访问数量。还要注意，捕获的访问数量不仅用 ``nr_accesses``
+表示，也用 ``age`` 表示。例如，即使监测结果中的每个区域都显示 ``nr_accesses`` 为零，仍然可以
+用 ``age`` 值作为时近性信息来区分区域。
+
+因此，``聚集间隔`` 的最佳值取决于工作负载的访问密集程度。用户应根据每个聚集后的监测结果快照
+中捕获的访问数量来调优该间隔。
+
+请注意，该间隔的默认值是 100 毫秒，在许多情况下都太短，尤其是在大型系统上。
+
+``采样间隔`` 定义每次聚集的分辨率。如果它设置得过大，监测结果会看起来像每个区域都同样很少被
+访问，或者同样频繁地被访问。也就是说，区域将无法根据访问模式区分，因此结果在许多用例中都会无
+用。如果 ``采样间隔`` 过小，它不会降低分辨率，但会增加监测开销。如果它已经足以为给定目的提供
+足够的监测结果分辨率，就不应再不必要地降低。建议将它按 ``聚集间隔`` 的比例设置。默认比例设为
+``1/20``，并且仍然推荐该比例。
+
+基于手动调优指南，DAMON 提供了更直观的、基于调节项的间隔自动调优机制。更多细节请参考
+:ref:`该功能的设计文档 <damon_design_monitoring_intervals_autotuning_zh_CN>`。
+
+基于上述指南的示例调优，请参考 Documentation/mm/damon/monitoring_intervals_tuning_example.rst。
+
+
+.. _damon_design_monitoring_intervals_autotuning_zh_CN:
+
+监测间隔自动调优
+----------------
+
+DAMON 基于 :ref:`调优指南的思路 <damon_design_monitoring_params_tuning_guide_zh_CN>`，提供了
+对 ``采样间隔`` 和 ``聚集间隔`` 的自动调优机制。该调优机制允许用户设置希望 DAMON 在给定时间间隔
+内观测到的访问事件数量目标。用户可以把该目标指定为 DAMON 观测到的访问事件数量与理论最大事件数
+量之间的比例（``access_bp``），该比例在给定数量的聚集中测量（``aggrs``）。
+
+DAMON 观测到的访问事件基于 DAMON :ref:`区域假设 <damon_design_region_based_sampling_zh_CN>`
+按字节粒度计算。例如，如果发现大小为 ``X`` 字节、``nr_accesses`` 为 ``Y`` 的区域，就意味着
+DAMON 观测到了 ``X * Y`` 个访问事件。该区域的理论最大访问事件也以相同方式计算，但会把 ``Y``
+替换为理论最大 ``nr_accesses``，即 ``聚集间隔 / 采样间隔``。
+
+该机制会计算 ``aggrs`` 次聚集期间的访问事件比例。如果观测到的访问比例低于或高于目标值，就按
+相同比例增大或减小 ``采样间隔`` 和 ``聚集间隔``。间隔变化比例按当前采样比例与目标比例之间的
+距离决定。
+
+用户还可以通过两个参数（``min_sample_us`` 和 ``max_sample_us``）进一步设置调优机制可设置的
+最小和最大 ``采样间隔``。由于调优机制总是以相同比例改变 ``采样间隔`` 和 ``聚集间隔``，所以
+每次调优变化后的最小和最大 ``聚集间隔`` 也可以自动一起设置。
+
+该调优默认关闭，需要由用户显式设置。根据经验法则和帕累托原则，推荐使用 4% 的访问样本比例目标。
+请注意，这里应用了两次帕累托原则（80/20 规则）。也就是说，假设以 4%（20% 的 20%）的 DAMON
+观测访问事件比例（来源），捕获 64%（80% 乘以 80%）的真实访问事件（结果）。
+
+要了解用户空间如何通过 :ref:`DAMON sysfs 接口 <sysfs_interface_zh_CN>` 使用该功能，请参考文档
+的 :ref:`intervals_goal <damon_usage_sysfs_monitoring_intervals_goal_zh_CN>` 部分。
+
+
+.. _damon_modules_zh_CN:
+
+模块
+====
+
+由于 DAMON 的核心是供内核组件使用的框架，它本身不向用户空间提供任何直接接口。相反，这些接口
+应由每个使用 DAMON API 的内核组件来实现。DAMON 子系统本身实现了这类 DAMON API 用户模块，
+它们分别用于通用目的的 DAMON 控制和特定目的的数据访问感知系统操作，并为用户空间提供稳定的应
+用二进制接口（ABI）。用户空间可以使用这些接口构建高效的数据访问感知应用程序。
+
+
+通用目的用户接口模块
+--------------------
+
+DAMON 模块为运行时的通用目的 DAMON 用法提供用户空间 ABI。
+
+与许多其他 ABI 一样，这些模块会在类似 ``sysfs`` 的伪文件系统上创建文件，允许用户通过写入和读
+取这些文件来向 DAMON 指定请求并获取回答。作为这类 I/O 的响应，DAMON 用户接口模块会通过 DAMON
+API 按用户请求控制 DAMON 并获取结果，然后把结果返回给用户空间。
+
+这些 ABI 是为用户空间应用程序开发而设计的，而不是为人工手动操作而设计的。建议人工用户使用这类
+用户空间工具。一个用 Python 编写的此类用户空间工具可在 Github
+（https://github.com/damonitor/damo）、Pypi（https://pypistats.org/packages/damo）以及多个发行
+版（https://repology.org/project/damo/versions）中获取。
+
+目前，该类型有一个模块可用，即 ``DAMON sysfs interface``。关于接口细节，请参考 ABI
+:ref:`文档 <sysfs_interface_zh_CN>`。
+
+
+.. _damon_modules_special_purpose_zh_CN:
+
+专用访问感知内核模块
+--------------------
+
+DAMON 模块为特定目的的 DAMON 用法提供用户空间 ABI。
+
+DAMON 用户接口模块用于在运行时完整控制所有 DAMON 功能。对于每种专用的、系统范围的数据访问感知
+系统操作，例如主动回收或 LRU 链表均衡，可以通过移除该特定目的不需要的调节项来简化接口，并扩展
+为启动时甚至编译时控制。用于该用途的 DAMON 控制参数默认值也需要针对该目的进行优化。
+
+为支持这些场景，DAMON 还提供了更多使用 DAMON API 的内核模块，它们提供更简单且更优化的用户空间
+接口。目前提供了用于访问监测统计、主动回收和 LRU 链表操作的三个模块。更多细节请阅读这些模块的
+使用文档（:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim` 和
+:doc:`/admin-guide/mm/damon/lru_sort`）。
+
+.. _damon_design_special_purpose_modules_exclusivity_zh_CN:
+
+请注意，这些模块当前以互斥方式运行。如果其中一个模块已经在运行，其他模块在收到启动请求时将返回
+``-EBUSY``。
+
+示例 DAMON 模块
+----------------
+
+DAMON 模块提供 DAMON 内核 API 用法示例。
+
+内核程序员可以使用 DAMON 内核 API 构建自己的专用或通用目的 DAMON 模块。为了帮助他们容易理解
+如何使用 DAMON 内核 API，Linux 源码树的 ``samples/damon/`` 目录下提供了一些示例模块。请注意，
+这些模块不是为实际产品使用而开发的，而只是为了展示如何以简单方式使用 DAMON 内核 API。
-- 
2.43.0

