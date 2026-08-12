Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE7399375
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517979; cv=none; b=fZHfU6I6lgLS0BNQXvJKk4tMOuOm62zg3DKk4qhjA+EWU1Ha9vWWm/VxV87SZAgGPICSk0tLvAoNlcW4xDEJbdV4MeRgwx/i66vqEEZmsCMeMnhYBmc0SAh9djrYJSOsvZ7qEZgKo1FWgS39+cROl2AvoNbKovLhvW2X/VLd8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517979; c=relaxed/simple;
	bh=IBIsXPsiyG0M3VuvrMK9bIS+RRh0mxA2w8MD+MPV0kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3XmVtGHkTcXLO1p+B3LYkLAZ3hFc7pXDRmwbNz30JlzClgbjT3y38Q+/b/OuWfbVABunrhazKn1ZhgtI5HI5hli2/kPWb2F0F/3JvtI54xBPKIi4eWnbOPXhsvNqd843Nl4RNAd1nvmb4Hqai40PD9l0HTX7ORn2x+bC5MnVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpQhkwE8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpQhkwE8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-495522bc0e2so195225e9.2
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 23:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786517975; x=1787122775; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzGp4RSK/VKV73d1qH4iqIoZ1Boa7bH9bYUYJjvkcf8=;
        b=NpQhkwE8vpGAPvZ032QYwQ2S9XWP9kdADNF2WkKVRbIGZYdGOtdM3jY3KYMqURjftQ
         Tdp3ZbU8LTjMHx+4C50Pi/rSmmKI0n9brhKgVLIaI6qT3WiUNtQShRSAONr8HNHgRnpg
         EKwFsBSIZgPa6YenyV6L10OKF969xoER0Cp9AKqqpyBJNTayq32/9LpAC8Y5Pkao3V1I
         nqWhe+sIrfEKrm8T9APwisxEEpsZth5ltTTWktLq9Cig3B2TXgeoCYs0Ai62bpKIC2/s
         VdlVp+PGYv20EeIhR/pnb7UGeT5r4oo6xX2Y3CzTfcEU58BzyEoN4vNfqaTIUQfdKLsG
         mpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517975; x=1787122775;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzGp4RSK/VKV73d1qH4iqIoZ1Boa7bH9bYUYJjvkcf8=;
        b=BDMXVsvwo9mz60c7GvjeLNpNSICvLOmcgE6+uMvvssNqsNn4B1mZ9FUDxUmASpmt1P
         HdUg3Zec92x/XqUoLF/UFRRHa2LeNFXHgJKbh+xpZewfwSqC4/ayqYdRsg4AtR5+5ISM
         +gOLjtf/y0KqWa6CRCQ0xm+lXxqOdWj4YdX8jO+E73HNPcFuFDqKxoIhp/6Ng13vZED8
         1zPTnWcDAffB4sOfBBH4Z/x4phE75C6ufLWtEbpiiYPKEdiGf54QKsLTGR75+77T1E/K
         V5VjF6L1DhRXaUSFFbA56FUgY0PXk/pS77S9TjFUgcwKesnyKp56vj1LSeC9QyB1y6eJ
         9iPw==
X-Forwarded-Encrypted: i=1; AHgh+RqipCqg9amZNF6HvGJoe7AhUAkV5xxINBEE7cGXrwS/R0+CqQceyQYIwS5r0U7dfyqst97cEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxu4VqvDkJnUu1e+/sdKIxYbuKxVFIPKLOZU+cpVKScxCRRJxOA
	k2Ru3rAyiO62ZHf7+3+gu2ZnwNAsEDtia3tHgtkM5Z6UJm3WyGrQq8Vxcda8HaD/
X-Gm-Gg: AR+sD12ebqqW6BOzldmB+v2VyvGhsV1xfH9zQyLSfvviPlReiG3qOrD3eIePOeyZz1u
	ujsuFj1M+by8BowHIQJOudyikPjj74fFTwUEgLiLitMxPeSpVoGdDhQjvLKv3D5kzBQUcRbalhd
	NRVrNgNIr14B944NdZvAY1xjVdpdryorp9srvkaE/29Zfupv766/QTjIOvgpo68lccBrpywh/vW
	/E+BytG4CQ1GfEx8zL4oiALztCoUz7/XcJMY8FkIjVoEuK+cKrnArFaKR0zXk44Bu/51zU5sh4d
	5Wya5VbwhNT2IAx18ZloIJHQaifEqf7CNMcmXYW7OSXhdPoM4Y79ZhBskNvlhmPjQgZiHUh1O0S
	ISnbdEnMq/0Ou7AD7AYJKR1P6yaEQMLPHAplipEIbtF5o1bCi8hjWYKDc9glcAW5fYcqLXvYAhs
	W059CRD0lRwnfi05+rRqbJtBEJVBHdeOPTcynjfQaj30/QgANkjtb1u3NjSi7pHojW7WHew69yG
	MKoDJrARQeVBzbG5dtiCgcM4uE3AvwjHO4JCKPT3Low69S5wMxbVlNxuAiV8l0bIqpGLG/PYVzM
	1VCGsOWBZP08UIMI4J49V0yEHzY15qZV+pfUxR3zatYZFw==
X-Received: by 2002:a05:600c:1c25:b0:498:1371:660c with SMTP id 5b1f17b1804b1-4997bf8879dmr16240415e9.0.1786517974771;
        Tue, 11 Aug 2026 23:59:34 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b15b807sm73628005e9.7.2026.08.11.23.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:59:34 -0700 (PDT)
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
Subject: [PATCH v7 6/7] docs/zh_CN: update DAMON reclaim translation
Date: Wed, 12 Aug 2026 06:59:10 +0000
Message-ID: <20260812065914.3071433-7-doehyunbaek@gmail.com>
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

Update the Chinese translation of .../admin-guide/mm/damon/reclaim.rst.

Update the translation through commit c9380cdd949d
("Docs/{admin-guide,mm}/damon: fix DAMON documentation details").

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 .../zh_CN/admin-guide/mm/damon/reclaim.rst    | 82 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
index d14ba32f7788..1e9375947295 100644
--- a/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/translations/zh_CN/admin-guide/mm/damon/reclaim.rst
@@ -58,6 +58,19 @@ enabled
 DAMON_RECLAIM。注意，由于基于水位的激活条件，DAMON_RECLAIM不能进行真正的监测和回收。
 这一点请参考下面关于水位参数的描述。
 
+commit_inputs
+-------------
+
+让 DAMON_RECLAIM 再次读取除 ``enabled`` 外的输入参数。
+
+DAMON_RECLAIM 运行期间更新的输入参数默认不会应用。一旦该参数被设置为
+``Y``，DAMON_RECLAIM 会再次读取除 ``enabled`` 外的参数值。重新读取完成后，
+该参数会被设置为 ``N``。如果重新读取时发现无效参数，DAMON_RECLAIM 会被
+禁用。
+
+一旦向该参数写入 ``Y``，用户在再次读取 ``commit_inputs`` 返回 ``N`` 之前，
+不得写入任何参数。如果用户违反该规则，内核可能表现出未定义行为。
+
 min_age
 -------
 
@@ -68,6 +81,15 @@ min_age
 
 默认为120秒。
 
+autotune_monitoring_intervals
+-----------------------------
+
+如果该参数设置为 ``Y``，DAMON_RECLAIM 会自动调优 DAMON 的采样和聚集间隔。
+自动调优的目标是在每个 DAMON 快照中捕获有意义数量的访问事件，同时将采样
+间隔限制在最小 5 毫秒、最大 10 秒。将其设置为 ``N`` 会禁用自动调优。
+
+默认禁用。
+
 quota_ms
 --------
 
@@ -98,6 +120,29 @@ quota_reset_interval_ms
 
 默认为1秒。
 
+quota_mem_pressure_us
+---------------------
+
+期望的内存压力停滞时间水平，单位为微秒。
+
+在保持其他配额设置的上限的同时，DAMON_RECLAIM 会自动增减配额的有效水平，
+目标是产生该水平的内存压力。系统范围的 ``some`` 内存 PSI 会按每个配额重置
+间隔（``quota_reset_interval_ms``）以微秒为单位收集，并与该值比较，以判断
+目标是否满足。值为零表示禁用该自动调优功能。
+
+默认禁用。
+
+quota_autotune_feedback
+-----------------------
+
+用户可指定的有效配额自动调优反馈。
+
+在保持其他配额设置的上限的同时，DAMON_RECLAIM 会自动增减配额的有效水平，
+目标是从用户接收到值为 ``10,000`` 的反馈。DAMON_RECLAIM 假定反馈值和配额
+成正比。值为零表示禁用该自动调优功能。
+
+默认禁用。
+
 wmarks_interval
 ---------------
 
@@ -149,6 +194,8 @@ min_nr_regions
 DAMON用于冷内存监测的最小监测区域数。这可以用来设置监测质量的下限。但是，设
 置的太高可能会导致监测开销的增加。更多细节请参考DAMON文档 (:doc:`usage`) 。
 
+请注意，该值必须为 3 或更高。该下限的理由请参考设计文档的 :ref:`监测 <damon_design_monitoring_zh_CN>` 章节。
+
 max_nr_regions
 --------------
 
@@ -163,7 +210,7 @@ monitor_region_start
 目标内存区域的物理地址起点。
 
 DAMON_RECLAIM将对其进行工作的内存区域的起始物理地址。也就是说，DAMON_RECLAIM
-将在这个区域中找到冷的内存区域并进行回收。默认情况下，该区域使用最大系统内存区。
+将在这个区域中找到冷的内存区域并进行回收。默认情况下，该区域使用系统的整个物理内存。
 
 monitor_region_end
 ------------------
@@ -171,7 +218,35 @@ monitor_region_end
 目标内存区域的结束物理地址。
 
 DAMON_RECLAIM将对其进行工作的内存区域的末端物理地址。也就是说，DAMON_RECLAIM将
-在这个区域内找到冷的内存区域并进行回收。默认情况下，该区域使用最大系统内存区。
+在这个区域内找到冷的内存区域并进行回收。默认情况下，该区域使用系统的整个物理内存。
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
+分别设置为 ``1024``、``0`` 和 ``10``。那么 DAMON_RECLAIM 将处理从地址零
+开始、长度为 10 KiB 的物理地址范围（以字节表示为
+``[0 * 1024, 10 * 1024)``）。
+
+``bytes_reclaim_tried_regions`` 和 ``bytes_reclaimed_regions`` 也使用该单位。
+例如，假设 ``addr_unit``、``bytes_reclaim_tried_regions`` 和
+``bytes_reclaimed_regions`` 的值分别为 ``1024``、``42`` 和 ``32``。那么这
+表示 DAMON_RECLAIM 总共尝试回收 42 KiB 内存，并成功回收了 32 KiB 内存。
+
+如果不确定，只使用默认值（``1``）并忘记这个参数即可。
+
+skip_anon
+---------
+
+跳过匿名页回收。
+
+如果该参数设置为 ``Y``，DAMON_RECLAIM 不会回收匿名页。默认值为 ``N``。
+
 
 kdamond_pid
 -----------
@@ -223,6 +298,9 @@ DAMON_RECLAIM再次什么都不做，这样我们就可以退回到基于LRU列
     # echo 200 > wmarks_low
     # echo Y > enabled
 
+请注意，该模块（damon_reclaim）不能与其他基于 DAMON 的专用模块同时运行。
+更多细节请参考 :ref:`DAMON 设计文档的专用模块互斥性 <damon_design_special_purpose_modules_exclusivity_zh_CN>`。
+
 .. [1] https://research.google/pubs/pub48551/
 .. [2] https://lwn.net/Articles/787611/
 .. [3] https://www.kernel.org/doc/html/latest/mm/free_page_reporting.html
-- 
2.43.0

