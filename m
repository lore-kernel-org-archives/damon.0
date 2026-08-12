Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E739CCFF
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517980; cv=none; b=NKm5qrwy6XXaqb0wH3J1oetoBHS/xxcU/f+wcj0Xzd0wqSrRYhn8ti6Rn4jB7RsSYzNFXujzx3CqIMfSpgzZ4CH3knokhoRtDpSwmO9Z9BfBky+/dhCIYEvhzfKZayUYheHwtEL2Bn0rCN9RrSJLT4hhffHi8OlAXiLCK9KyaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517980; c=relaxed/simple;
	bh=Io2+2DoyZ+/tP/NSGU5iQkRUwbQAexl+mSKZsuY3WBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzmBJHg5zv/QRKJZLPr3mm/WlESmifaqDErg3tQBEnelOIEv0R6wKiZh9HWOdLly1Kx77qpwCUCV6OUED9hC3JzaD485tSQbSXghH7POlbWbReylSpCl5qY076EOHRjZLBQfOVmWXTaQMPIlhuMJHftCCyuB1N+2SEilWXfVp4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iuic2p6x; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iuic2p6x"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49967f24eedso1444195e9.0
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786517976; x=1787122776; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s31nZQVBL8BUGSoys1iksqFJSqf6kbi1kgLlk3gjtUc=;
        b=Iuic2p6xRIs9dluZiQ+7I7SqXT4lFH8VldxtMuwZlPQL+w4h9PvuvDMa7IW20DyP+X
         8aqiyH48H5lFnMt9Sqhqn+kdJvleP5IzY8e/XrAvWHsS10s+SzZUQ1VUXitIYYTHZf7K
         8MHVRNt4VAKxuums6GnO+zz0gAPRplFFxteFSew6Zk5MLpdMosRf8P1A83KP6irENToS
         EPUy4rqiim3wCNO6GIPrFEBu1y3mqcHN3Gboo+rM9TbVFfNrNvqkRVPSwf7/WJtaV9+j
         JyS0slf/WEtUTkbVREhbvFghrUyRU8XLFR9C0iwhcGW+DisdjlWZ9PzjPFMjm/RMT52i
         1Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517976; x=1787122776;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s31nZQVBL8BUGSoys1iksqFJSqf6kbi1kgLlk3gjtUc=;
        b=X1TJukRCjGCEj1H+eyjRR+nEZfeTsCdzlXEj1dh6yH+poJJ93v2634Vfp6A0Y/6eTL
         zyxP5SAp2xIHsGhXspfXbGDf7AJT/wWahZxa/Xr8RkmQlwBWkUVcMNSo+ucmiK9kuwKO
         fh/hRbhfHODVKTQdmfQdj7PB2Wak3XxC/8U/CyeP8vFOpztLIN/4vqFreG3dEOsrxkPC
         a6YKRGpjEpgl/Pqwo9+X+gyaqF8ZMhYcmQQQz5xJjtLKxI90rFEWV95QOlfd1Xyn/8Gl
         kT+cV+5QMnGM+TEZ+x4eNp3kE1aUgQCUvdKEQ6ucJj/4Z3qpT5MjK17MZd0GdaAuJjU2
         p1rA==
X-Forwarded-Encrypted: i=1; AHgh+RrVm9Ghye6cdFXx8+Bj4Xr/oeWl2Gw8dkVCYOdtt011yfQbi7fBnlUvlE++aBFpPtQABs4Aug==@lists.linux.dev
X-Gm-Message-State: AOJu0YyB9iYaDqsGcLBz+ZPcMCLqixhQtLXXzmVQFMNKYUC8eWD/Rji1
	gboAJ+UunRm8hhIz4cKAn6+c75Lt0qtAr8Fn8S4P0KREQOOerdtHoylp
X-Gm-Gg: AR+sD1253n90QRWFifVOIb65ripFjtrPFB5Wis+qCH9GHYjhKbEhrwFE2kaKGaTeUoL
	Lwl+LnMOWssjLofqG6y8NR+dGQpx8aFGle5O7JWusBPxX/vTC7TGcx0BWGuZcm5atMNks2gj6LN
	vD2YsZc/Sb6yME+du68NDW2Bf/XW8NagG8O8JKvxjlBuAP2cYfXpTN+pZkLBEopKlyHsVH0PQjL
	L+FKrf30g+Nhodm14cvlqT/Eo/8l8hO+cn8NCjKaUoi3Y7W1Hurb08WxF1AsG9RFBe52i8ZxNuC
	Gid0W+7kccnReX5UEhMfF7b0uFK8AcISpkLtwQDHpaeouFXBsQSXHw8ThsVQW9JF9DDIYquPZWL
	++Crf3QttsgEhVNw7j5SGMxjZ+UdK6z1V/byyNzKqym8vsqIMa5oDi/auuRoiA5hDMq01jmElet
	AavTXyHHNKhMBVqlF523MAvMTqrDMSuJrLLIfJPXruE7ecJ4SiocfoX9r5mINM+8Ws0rC2v1gFl
	2Bfgw0TFCWyPlmDZZhQvZfzMk7fEJY38U+GRbVPK0uUlfMI9/nhyVqxhO7tfcmfGBQhgWitbsKp
	qWRk/yBB9uwJLGr6QoXh/j0U/eQnmdH3n+YPp3OUqwgn8Q==
X-Received: by 2002:a05:600c:c8d:b0:495:7561:a9cc with SMTP id 5b1f17b1804b1-4997c16802amr16814285e9.4.1786517976305;
        Tue, 11 Aug 2026 23:59:36 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b15b807sm73628005e9.7.2026.08.11.23.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:59:35 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Doehyun Baek <doehyunbaek@gmail.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/7] docs/zh_CN: update DAMON LRU sort translation
Date: Wed, 12 Aug 2026 06:59:11 +0000
Message-ID: <20260812065914.3071433-8-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812065914.3071433-1-doehyunbaek@gmail.com>
References: <20260812065914.3071433-1-doehyunbaek@gmail.com>
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

