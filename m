Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8803E8326
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 07:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496048; cv=none; b=UBL/Dsp4pn5fFOsfll4JaHJzWSZlfVlev9YLGgKjGk/ZySubmtUjj2/kPLzr/Y/x18HcTYtD0pdHyBJdMZYA9kvU4+E2kmH0wbdLeADGhQbKKF17DrOghlVyOfcfHUYJTKvi38UfGbARIFXcjB0nvp5wlC37L1+ykeef07paTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496048; c=relaxed/simple;
	bh=Io2+2DoyZ+/tP/NSGU5iQkRUwbQAexl+mSKZsuY3WBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLDEJs2GIrUwigGlD0yDa5itDUnByI7ZavFogis9J4BQ9ASli+Ft1K28A9GTsxM30BnE7vMrtRyl2OpFuFZsnFphCjvfKwAKcMar2+T5zs34wglB2sFTiFuvJ1ZfLT3OYkVFWoTIf46M7TuIWIu2fVH/ZMRJT7v6j64BIo+TYbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMb3u9FE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMb3u9FE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493c30f5347so381415e9.0
        for <damon@lists.linux.dev>; Wed, 08 Jul 2026 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496038; x=1784100838; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s31nZQVBL8BUGSoys1iksqFJSqf6kbi1kgLlk3gjtUc=;
        b=HMb3u9FExorf8HqHjkIB2EQKSwFN0tGLg7ef21EIGa0iEZ9TOTj2zciP9P5zOZQXXM
         nwkHnLmfC6htT3VB14IcaxB+ox/GTTsL2mqTe3yXX3h8M5SVCJ56Tdb/If44gRKIj0RN
         9gQScKhqDZL7LSeIkERRqD9YMO5ii5krhtiNRCQ2tEjGA8L4yXvMiEFsbgOhof6kv7J+
         nbUL5TrqhY9aaxi8dG7aFfJ7K6RMyk8oYQzSFCCZZCAZtgKNf7QKEo6s8vDc8GTcF8Yt
         lWGQ0YOHr1NPonVd0w/sDE/HX8UHKAi5lo/GSNvKU7fbTdr1nFlnoGaQsEN915m6sXGD
         A2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496038; x=1784100838;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s31nZQVBL8BUGSoys1iksqFJSqf6kbi1kgLlk3gjtUc=;
        b=dV8/3d5EXsa84yLEhfZvmVc7RpRsvwAbOvaXPThVBk9F/y/fsWgvvCoZBWA3hfND+y
         wuTA4I9OiuAMRftxtbREu0mlyEc9tIIZqhmqpXyGUgwPiBsN/yMxy8Dc8k0l1r447ap2
         O0LH/DtwqXOOkFGDBlUCJlvr/MPlpipv5t0OZBM7/eqpRKqjxmAUSq/EWmAAuAVkcYpi
         VB18EpvhyASMf1Gj7eGSxgRe2NbXbyAKxu0A+XJw2pNUJ0NxV4ofs38ZeJ8ifcZUaofT
         4So8Lw4vaiuo9HzSfiDZA1wy5Jb2QUitl619TYLlRdH8WNwhx0k34EyjjbQ65Yjz47yS
         sMDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTFLw3EU8RpzItsJ4MXzVkpdgbIMFgWFv0BbjZNpBY2/D+Ab+CL+c2tr2+EZbU3Fk2c7Idaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkUnPUrwdvdbAT8YLLa8zUvCKuqCojnrgxbkjGxJQ9vhwBqC0Y
	ec1lTyZK4fqEeLAWrmNOYr6ng517nG5GzOJ6+8AzTxy9U3llWoj9/h9v
X-Gm-Gg: AfdE7clzyB70DBrhEDzJMNb8boXSEo1c7J5sdIs4VqO+DwFgHtbagybOoLKpT6XYe0U
	17DWPESCcMaD76TRhZK3YvZJUlEpuY9Jt5bTmevqrQ1XU3gVJE9hFPbJIJmcYVLtDLJACTmM9rm
	J6WgeYJeTiLuqe8JbChpt14bB73MiX6D+Cs57wcpyr5YgsXBPHphhbfLudlayGw6NPxmh6SUr0o
	DN5ziSFrRz/dq/7EVUQBHBx2DqYXe+dWhfK9KMNX4UGticx+QLboPtDJSgc/jkB7G6o/wbFL6Y9
	o9LO/j1Am09QLXmjmRy1xFP3L8Zz7EpR4n+CwRPt7Y6gqL9ArigT1TW2vCWyb2Svfn5CgJriWKg
	3NPuQ++Qp+XwcteWNVHhh+cK7zM3ZfUF0bV5fykmlBZKHRkl/9/8L5JLBzsTjaVIOqhehe20n+L
	1d/BLRQfnhrDApOk7ozzutvXTNaSnMCdvsD0ch6olTdaj0LddwWf3y1fiZKc/q4v90ypckpmOkf
	Tbp2WpRkQfF0pQx
X-Received: by 2002:a05:600c:c172:b0:493:e4ca:8358 with SMTP id 5b1f17b1804b1-493e76a5647mr3439455e9.5.1783496037536;
        Wed, 08 Jul 2026 00:33:57 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e610532fsm32876355e9.0.2026.07.08.00.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:33:56 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v6 7/7] docs/zh_CN: update DAMON LRU sort translation
Date: Wed,  8 Jul 2026 07:32:46 +0000
Message-ID: <20260708073246.1652828-8-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708073246.1652828-1-doehyunbaek@gmail.com>
References: <20260708073246.1652828-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the Chinese translation of .../admin-guide/mm/damon/lru_sort.rst.

Update the translation through commit c9380cdd949d
("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 .../zh_CN/admin-guide/mm/damon/lru_sort.rst   | 68 +++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/lru_sort.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/lru_sort.rst
index 03d33c710604..6af0dd59ef5d 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/lru_sort.rst
@@ -48,7 +48,7 @@ DAMON_LRU_SORT使用DAMON寻找热页（范围内的页面访问频率高于用
 
 为了让系统管理员打开或者关闭并且调节指定的系统，DAMON_LRU_SORT设计了模块参数。
 这意味着，你可以添加 ``damon_lru_sort.<parameter>=<value>`` 到内核的启动命令行
-参数，或者在 ``/sys/modules/damon_lru_sort/parameters/<parameter>`` 写入正确的
+参数，或者在 ``/sys/module/damon_lru_sort/parameters/<parameter>`` 写入正确的
 值。
 
 下边是每个参数的描述
@@ -71,6 +71,41 @@ commit_inputs
 ，DAMON_LRU_SORT会再次读取除了 ``enabled`` 之外的参数。读取完成后，这个参数会被
 设置为 ``N`` 。如果在读取时发现有无效参数，DAMON_LRU_SORT会被关闭。
 
+一旦向该参数写入 ``Y``，用户在再次读取 ``commit_inputs`` 返回 ``N`` 之前，
+不得写入任何参数。如果用户违反该规则，内核可能表现出未定义行为。
+
+active_mem_bp
+-------------
+
+期望的活跃内存与[非]活跃内存比率，单位为 bp（1/10,000）。
+
+在保持其他配额设置的上限的同时，DAMON_LRU_SORT 会自动增减配额的有效水平，
+目标是让热/冷内存的 LRU [降低]优先级处理产生该活跃内存与[非]活跃内存比率。
+值为零表示禁用该自动调优功能。
+
+默认禁用。
+
+autotune_monitoring_intervals
+-----------------------------
+
+如果该参数设置为 ``Y``，DAMON_LRU_SORT 会自动调优 DAMON 的采样和聚集间隔。
+自动调优的目标是在每个 DAMON 快照中捕获有意义数量的访问事件，同时将采样
+间隔限制在最小 5 毫秒、最大 10 秒。将其设置为 ``N`` 会禁用自动调优。
+
+默认禁用。
+
+filter_young_pages
+------------------
+
+相应地为 LRU [降低]优先级处理过滤[非]年轻页。
+
+如果设置该参数，则在每次 LRU [降低]优先级处理操作前再次检查页级访问
+（年轻性）。如果该页自上次检查以来未被访问（不年轻），则跳过 LRU 提高
+优先级操作。如果该页自上次检查以来已被访问（年轻），则跳过 LRU 降低优先级
+操作。当该参数分别设置为 ``Y`` 或 ``N`` 时，会启用或禁用该功能。
+
+默认禁用。
+
 hot_thres_access_freq
 ---------------------
 
@@ -163,6 +198,8 @@ min_nr_regions
 对冷内存区域监测的最小数量。这个值可以作为监测质量的下限。不过，这个值设置的过
 大会增加开销。更多细节请参考DAMON文档 (:doc:`usage`) 。默认值为10。
 
+请注意，该值必须为 3 或更高。该下限的理由请参考设计文档的 :ref:`监测 <damon_design_monitoring_zh_CN>` 章节。
+
 max_nr_regions
 --------------
 
@@ -176,14 +213,34 @@ monitor_region_start
 
 目标内存区域的起始物理地址。
 
-DAMON_LRU_SORT要处理的目标内存区域的起始物理地址。默认，使用系统最大内存。
+DAMON_LRU_SORT要处理的目标内存区域的起始物理地址。默认，使用系统的整个物理内存。
 
 monitor_region_end
 ------------------
 
 目标内存区域的结束物理地址。
 
-DAMON_LRU_SORT要处理的目标内存区域的结束物理地址。默认，使用系统最大内存。
+DAMON_LRU_SORT要处理的目标内存区域的结束物理地址。默认，使用系统的整个物理内存。
+
+addr_unit
+---------
+
+内存地址和字节数的缩放因子。
+
+该参数用于设置和获取 DAMON_RECLAIM 的 DAMON 实例的 :ref:`地址单位 <damon_design_addr_unit_zh_CN>` 参数。
+
+``monitor_region_start`` 和 ``monitor_region_end`` 应以该单位提供。例如，
+假设 ``addr_unit``、``monitor_region_start`` 和 ``monitor_region_end``
+分别设置为 ``1024``、``0`` 和 ``10``。那么 DAMON_LRU_SORT 将处理从地址零
+开始、长度为 10 KiB 的物理地址范围（以字节表示为
+``[0 * 1024, 10 * 1024)``）。
+
+带有 ``bytes_`` 前缀的统计参数也使用该单位。例如，假设 ``addr_unit``、
+``bytes_lru_sort_tried_hot_regions`` 和 ``bytes_lru_sorted_hot_regions`` 的值
+分别为 ``1024``、``42`` 和 ``32``。那么这表示 DAMON_LRU_SORT 尝试对
+42 KiB 热内存进行 LRU 排序，并总共成功对其中 32 KiB 内存进行了 LRU 排序。
+
+如果不确定，只使用默认值（``1``）并忘记这个参数即可。
 
 kdamond_pid
 -----------
@@ -252,7 +309,7 @@ LRU的优先级的提升，同时降低那些超过120秒无人访问的内存
 进展且空闲内存低于20%，再次让DAMON_LRU_SORT停止工作，以此回退到以LRU链表为基础
 以页面为单位的内存回收上。 ::
 
-    # cd /sys/modules/damon_lru_sort/parameters
+    # cd /sys/module/damon_lru_sort/parameters
     # echo 500 > hot_thres_access_freq
     # echo 120000000 > cold_min_age
     # echo 10 > quota_ms
@@ -261,3 +318,6 @@ LRU的优先级的提升，同时降低那些超过120秒无人访问的内存
     # echo 400 > wmarks_mid
     # echo 200 > wmarks_low
     # echo Y > enabled
+
+请注意，该模块（damon_lru_sort）不能与其他基于 DAMON 的专用模块同时运行。
+更多细节请参考 :ref:`DAMON 设计文档的专用模块互斥性 <damon_design_special_purpose_modules_exclusivity_zh_CN>`。
-- 
2.43.0

