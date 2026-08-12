Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C83264F9
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517971; cv=none; b=Q547jmvU0ejtgLQC0BgBPQFlbBDN7TKLllAAQxXzCFBvykMBLVMElg+k2AhRMXZm4uMYcY3oc5vQORGFYvoU0mRbW3B7Z7WD/4vccgeI8aJh0F8EhEbg60SlEtQJCL12gloMzknDqEKhbKDrDm2SmCMQBFk9qK2qvyA9nKDRlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517971; c=relaxed/simple;
	bh=B3epYLxfoVoXfinQU6yOnyaTqA1uv7xJ3fU2PNRA69A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a20ipnCUKMkG/hg2YGSBJxqFzd0kB/fOWcbrA6m0iFL/K0GGHPpSHHKYmt567HKeMdz6YokJS66DnqPgzJ2lf6CKWDVdXqBV0wbX2VYcB/YSdvQ7m/SWJPTXMW5M9S3yG4DbBRkrI6pI0S3Mr+WtSChV0PeRx1a54NHYDGKBOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlrHcXi7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlrHcXi7"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495522bc0e2so195115e9.2
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 23:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786517968; x=1787122768; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zz4SgHtAmy0qQncUtL+GMZmlzcvWPiSx3o95/DRT6g4=;
        b=NlrHcXi79W+3UG6RhqOlioCXpXArmRTYsoTQgHT3zryPSbZAT0lrQDtj6IYE74OgLY
         ua5YRldVMVT4aDc1AIcwxeLv0H/P7FMpcSLpaHXiu6frNTcV3GFi+R2kn+9NcvzaRVmw
         8iOt/8m2qmQLFDrSYdV1KOKBe3Iqy909PFg1IbEhEqUF5m9IybqxFrBTUpIAYNvcREvK
         LzNAlaQi3M4Hmj/6qlQtbDCEYH//dK2sz9C0MbaUtPVI5GX0PrrZ5fZ/XQlRmez9JsOF
         yoCojZmx97aBz9H49P7QrVI01hBzvwcQP/hvZWPCWDY0ozhxMNsdeaEQ76fyw+j1oZrb
         1ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517968; x=1787122768;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zz4SgHtAmy0qQncUtL+GMZmlzcvWPiSx3o95/DRT6g4=;
        b=EbarD/n+LCeCpK2enTkDA2wpPf78ammpz2PqvQ/xgsBeWIUPCzCyH1b/oeaNC9gs7l
         d7jXH828bwkEnwHzHctI98Bp4Dbb6+n9q8A0gRRIdhGZSlUX6phJCawmiXn4tL4985lQ
         i+kvx7cP5gddg+g4azj/MJtRRy00GqgP8jFJFibzI1QD8PaYcO66DYkvCjQ1+WAfkf3O
         6/j74ThrGK7X2xb4ZrYybr6pghFnfj5FZxGFeNuC8V5yg5bB7fDOy42wOPZAC7RJnR/B
         PRO3vUfsz1VCvNBgtWFjf1fjCeeLADLJtG6fn0eln4BnM16+YKuR4Pyh0om7qFTblURS
         xVbA==
X-Forwarded-Encrypted: i=1; AHgh+RqHfe38G1J8+sUi4IRzRfrbEo9dllfFwBhRuWgU+MWELabnJdcr1FmYczvMi19G8iunw1gSSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9WQroXGLdslyCVJY9eYa37ioT27x080Z04dwDj4kd9OSccckN
	VLsEMmBpYI74xmJnhOIYqb7hcXodSsXAxOnDbHoYt76KDGy759mBWHFZ
X-Gm-Gg: AR+sD12dOeyQTd3oxHywRyG7J+Cs2gB1YqRGqOt0M3vEF94GThDYnYU4OkwZAiTBVan
	TtH5EdBbGegAZM4kZy44tqEQs4fQdR3SSb4nC92xlTAWuOXmbfVZHEHRjuB+AdFtkAG/p2KRyL9
	Zzzz14q0I5FPkzpXiFrC0g8EeYep2AEXeYhBm+Ov4K6O85UG8qH2VhYDsx75NHam9B4af/byy4r
	bzlhjO8/W3dF0pPiba7/3u05MpjfcHZ+0z9SZdWABoZHPHGFH1ehBXs0XZxW3yNrjqbkuodwxad
	mNRSdXouTBpXCJWYmX2Yz4eYD29CqjB6qsc4Fa58GFTiz1WCO1s8YbcenFm200yyckyZhuQxdSg
	b8BzhlrTP9NEyc+a0tfCCqppqA3fmC/2k92p23Uwg/kTXR2I+MHiVCA085peZb4gwNyfN+cVZDL
	UACiUgZCDdRsGojyLo96E9ZHjfKUezrLbCjPMrdeEhG3Dugjn0adVEKQykDueE9u0leQGgbqFU5
	7qTEwV8YwUzib8hmGCtfJ6ENt007pK8SNFucYThb6cw89hgakXqbs1oT+XPnIoctuNLViUmKb40
	xzNTDiIpZGPSR8LRjkXJzcZori3FDAUFTBhNbjLueZpYsw==
X-Received: by 2002:a05:600c:1c25:b0:498:1371:660c with SMTP id 5b1f17b1804b1-4997bf8879dmr16236365e9.0.1786517967920;
        Tue, 11 Aug 2026 23:59:27 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b15b807sm73628005e9.7.2026.08.11.23.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:59:27 -0700 (PDT)
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
Subject: [PATCH v7 2/7] docs/zh_CN: add DAMON_STAT usage translation
Date: Wed, 12 Aug 2026 06:59:06 +0000
Message-ID: <20260812065914.3071433-3-doehyunbaek@gmail.com>
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

