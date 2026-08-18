Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DF385D82
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036711; cv=none; b=hk3DUL2veFKUztRzDQ3Z1dveM6u6TQ1ek5Jtw2o/VugoUuQkX8A5JxpredgaimQFlRC24I1bTDHDv1ENVodD48qMlfvAmwU3gEkeZ3pdCURkFcQIGaM/wpn7Gr+a0r43jObEB9f/aB5rOz56PP2hIMeGCQppWB9RfyGXSMihfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036711; c=relaxed/simple;
	bh=B3epYLxfoVoXfinQU6yOnyaTqA1uv7xJ3fU2PNRA69A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2rSNhRJ08trvhKJfO9pf7kQo5wGUn1txVpSksyG5IIScd7Rd1rfdH4h7ihasAHUnXauY+ujyYbtlBpjr+9PKY4HhYMC9Iycr1uYr0pl3i4tfEDRVf53uVRR71DvFQ2c7MihBi69gCZ+7JW2Om1mTIvbORig8HLXslQ4KH4DytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTdQ0gzM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTdQ0gzM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49987367394so2721125e9.0
        for <damon@lists.linux.dev>; Tue, 18 Aug 2026 00:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787036707; x=1787641507; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zz4SgHtAmy0qQncUtL+GMZmlzcvWPiSx3o95/DRT6g4=;
        b=hTdQ0gzMvpOV+GtCVV50VRsKt9nPknNn7WrSThyAHLQVpIiAdSxrz+CulrZtzhjuq8
         kSV+r8qj//T8NhjJrCePhI7HuE0OeHyNKWNEjSrYkcyU3iIpD/BZCIE9RqcV1dCPT6dM
         eEk0eMsCrHo01kOV1eSWGVXiTvoexqofviKABBlcujCDiv6mAxRYTiqPd8t402vmW2A5
         dtdd0PiVUS5bZlvR5NpT6A7lP8/XFPjtJH27qWPAzetSwVivSl61x0z58jliffVA/zOa
         cs/tGPBF+5bukaXLmra0X0fZfcr0LM+AGlSGdwG/CQdh8V7Q5Bbnr6MMgvNZ1CwIXajp
         WsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036707; x=1787641507;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zz4SgHtAmy0qQncUtL+GMZmlzcvWPiSx3o95/DRT6g4=;
        b=DejAtpWtCTYACo9+Ju6AbiNnfGOw/XMqxXmmGKSLgTo8/NDSEwoZfvUlhE5DJqoFuV
         CxG/e5UpZNJ0Ld1mq6aeQeeO+iNlkBMc20KG5/U4uYPji5U2193QnN1Eu2yA9qkrk9y8
         lQhAHrVG9QnpSrvDVSrplxOToQBuZAwO+NxavIp9blog9iH4UabeQYPCYu8z17W8PMTv
         5KY1BXSHgI/2eS7KHELTnTB3oJnV1WBdP4imkFyGfDpVkEEuGurPcxsgMYLYXipofdci
         6ftUZafvDc2j30vb64T9jm3mPZho8twxl74XzSMnTmCEojf5BzyoSOds63TCp6SS9ORM
         X12Q==
X-Forwarded-Encrypted: i=1; AHgh+RqsnVzeSDibHJ3HFjWi6Ltvwkq16h6xYBvElqgf75l8Mi4sAinlxV51QwmkpIYcHRCNezPhxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtL9x3DOhcilR4GcCIN/rcbzWZT1m3UhiJLHczUCM/ONmrEZJx
	nO53OBjpTKHZ5QlOi6lPqHowcTHMNAgNVbrK9qCYoflFtYsMahV6CxmS
X-Gm-Gg: AR+sD10B5YXPKm74qBUTdhydY3UdvMy5dC7Ai1xYYt2HNilN4S7pO8eCNfD3QQJ5dxR
	/6pJ6oPoVHXdFFYPZCVRpqU8RixUszJ0PFwkKi1rJN8N8O720XOEvAiJ0QhJmSfAm9QowZnfAFM
	WjJuug0eJo9Zocz45MGs4rcO2gZmdcfNvVvDEhySTp3twEjFCtT+xq2b7YV1B9ZVw2NmKEAsalP
	RVDKkB3+6BOSl+5UJC7o+n4VWkE5UZ77+SnedqSvZ21m73YwfbDhYqbTkJyqKzAwiux9lDWFWOR
	5lATXrF3tCgrUx5DfJj5nFYvO3b/hPdO960OP5pdliFe5MKhJvvSFdyRzr4SeXGLeg8r02mI2mW
	oq0rrrmcTlaN2GjnPeVKiImB0ZEygAitt1RToIkBKsrYXFVzy4+t7v9LzMQhRKgmeuDeU1bo+3I
	elVD+DJnncOajJ6CZUjIi/rkMWjNzhuHRqOgGS0mgrXWOTl6WSQSMB4jT7iw+J2b1JwLuR1I7c8
	fbPgUUU8quPOR1XdnoQvTlSznR97pXNRz8Mh10XNmHK5RkvYIzmVPRQfU6XWuJrOS/81SdVi0+c
	C/BRg5FsxmopE/zpuIqG/oP3Yuy+jLtxh3AWOwJh1TNCuQ==
X-Received: by 2002:a05:600c:3b1f:b0:490:ec79:3046 with SMTP id 5b1f17b1804b1-499878d463cmr231824665e9.0.1787036707142;
        Tue, 18 Aug 2026 00:05:07 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm495557495e9.13.2026.08.18.00.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 00:05:06 -0700 (PDT)
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
Subject: [PATCH v8 2/7] docs/zh_CN: add DAMON_STAT usage translation
Date: Tue, 18 Aug 2026 07:03:44 +0000
Message-ID: <20260818070358.455768-3-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818070358.455768-1-doehyunbaek@gmail.com>
References: <20260818070358.455768-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate .../admin-guide/mm/damon/stat.rst into Chinese.

Update the translation through commit c9380cdd949d
("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 .../zh_CN/admin-guide/mm/damon/stat.rst       | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
new file mode 100644
index 000000000000..129748a5ea1f
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst
@@ -0,0 +1,94 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../../../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/mm/damon/stat.rst
+
+:翻译:
+
+ Doehyun Baek <doehyunbaek@gmail.com>
+
+====================
+数据访问监测结果统计
+====================
+
+数据访问监测结果统计（DAMON_STAT）是一个静态内核模块，旨在用于简单的
+访问模式监测。它使用 DAMON 监测系统整个物理内存上的访问，并提供简化的
+访问监测结果统计，即空闲时间百分位数和估计的内存带宽。
+
+.. _damon_stat_monitoring_accuracy_overhead_zh_CN:
+
+监测精度和开销
+==============
+
+DAMON_STAT 使用监测间隔
+:ref:`自动调优 <damon_design_monitoring_intervals_autotuning_zh_CN>` 来提高
+精度并最小化开销。它会自动调优间隔，目标是在每个快照中捕获 4 % 的
+可观测访问事件，同时将得到的采样间隔限制在最小 5 毫秒、最大 10 秒。
+在少数生产服务器系统上，它的结果是只消耗 0.x % 的单个 CPU 时间，同时
+捕获质量合理的访问模式。调优得到的间隔可以通过
+``aggr_interval_us`` :ref:`参数 <damon_stat_aggr_interval_us_zh_CN>` 获取。
+
+接口：模块参数
+==============
+
+要使用这个功能，首先应确保你的系统运行在构建时启用了
+``CONFIG_DAMON_STAT=y`` 的内核上。通过将
+``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` 设置为 true，可以在构建时默认
+启用该功能。
+
+为了让系统管理员在启动时和/或运行时启用或禁用它，并读取监测结果，
+DAMON_STAT 提供了模块参数。下面的章节描述这些参数。
+
+enabled
+-------
+
+启用或禁用 DAMON_STAT。
+
+你可以将该参数的值设置为 ``Y`` 来启用 DAMON_STAT。设置为 ``N`` 会
+禁用 DAMON_STAT。默认值由 ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` 构建
+配置选项设置。
+
+请注意，该模块（damon_stat）不能与其他基于 DAMON 的专用模块同时运行。
+更多细节请参考 :ref:`DAMON 设计文档的专用模块互斥性 <damon_design_special_purpose_modules_exclusivity_zh_CN>`。
+
+.. _damon_stat_aggr_interval_us_zh_CN:
+
+aggr_interval_us
+----------------
+
+自动调优后的聚集时间间隔，单位是微秒。
+
+用户可以读取 DAMON_STAT 使用的 DAMON 实例的聚集间隔。它会被
+:ref:`自动调优 <damon_stat_monitoring_accuracy_overhead_zh_CN>`，因此该值
+会动态变化。
+
+estimated_memory_bandwidth
+--------------------------
+
+系统的估计内存带宽消耗（字节/秒）。
+
+DAMON_STAT 读取当前 DAMON 结果快照上的观测访问事件，并将其转换为以
+字节/秒为单位的内存带宽消耗估计。得到的指标通过这个只读参数向用户
+公开。由于 DAMON 使用采样，所以这只是访问强度的估计，而不是精确的
+内存带宽。
+
+memory_idle_ms_percentiles
+--------------------------
+
+系统的逐字节空闲时间（毫秒）百分位数。
+
+DAMON_STAT 基于当前 DAMON 结果快照，计算内存中每个字节到现在为止未被
+访问的时间（空闲时间）。对于访问频率（nr_accesses）大于零的区域，当前
+访问频率水平保持的时间乘以 ``-1``，就是该区域每个字节的空闲时间。如果
+某个区域的访问频率（nr_accesses）为零，则该区域保持零访问频率的时间
+（age）就是该区域每个字节的空闲时间。然后，DAMON_STAT 通过这个只读参数
+公开空闲时间值的百分位数。读取该参数会返回 101 个以毫秒为单位、用逗号
+分隔的空闲时间值。每个值分别表示第 0、第 1、第 2、第 3、……、第 99 和
+第 100 百分位的空闲时间。
+
+kdamond_pid
+-----------
+
+DAMON 线程的 PID。
+
+如果 DAMON_STAT 已启用，这将成为工作线程的 PID。否则为 -1。
-- 
2.43.0

