Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB53A05C2
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 07:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496047; cv=none; b=WUTGPbjXdTu2s3Zo4RQ6rf1Rr19l69eBdlHyDKPDxKO1oDztyWSXjzCKLGQP0Zc5mvQdx6s9t5FLNwcJd+LOA+eDNN6WpZQt/72u06TMJX3YAlUq6jC7hgzwQkdWnC/X0tZt7OWCcrnEC9T0PNW43cwQcYnTqqtlYkMmRIWn1IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496047; c=relaxed/simple;
	bh=IBIsXPsiyG0M3VuvrMK9bIS+RRh0mxA2w8MD+MPV0kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDlSY2qmHTaYAEGoFywAXADIPWaUAay4pelTYIzZy2Mwzd1SkZ8sbmtCLk7T2UseQj8zQ86hnpBwhn+9R/aJGMnl3qsfw1GkQkPnzLaaeHrHpG6wrxepAEZutuMaGVvbKBYxuaOv1GxP4lSz3ZBTj28JNBqiI+z0iu31sKqkV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjzwErlx; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjzwErlx"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c2c7770bso333615e9.1
        for <damon@lists.linux.dev>; Wed, 08 Jul 2026 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783496032; x=1784100832; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzGp4RSK/VKV73d1qH4iqIoZ1Boa7bH9bYUYJjvkcf8=;
        b=MjzwErlxS56tr0UwMhY2zvjh090ZJ6DrVjbToSt+ss0/VSpHY3eC2jh9QdK0ebIGgr
         WY/31/tepZsQByk8bg6dUSUn0ZKhsHCBqrLtYSPeHka+3x3pOi402Oz0CFHhGQxJbKs1
         iQnj4/GNyc0v7e29DzTxa9ExTALITLBPyOU/aQuZhBnHl9e94DSbhhzbKXjnW3MClbOp
         gTwDdqTXnR9f0DedH2fPKKrffQf8qUAFekxDAM7ctRFfED/iYckubU8tN7HhbA/NTWEM
         s7yBp5XhGtIq3jyRoPk1FFC7wfiC9YCnuo87bgXNxobIBOyjDIi0tlMT8oZcWlmJnW3u
         VAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783496032; x=1784100832;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzGp4RSK/VKV73d1qH4iqIoZ1Boa7bH9bYUYJjvkcf8=;
        b=mkWDQPy45UnMxuNmoBIg8RxYsDlsst44e6OmtYZWD0/3BH5yQp99Q9vpgs5V2zyJYc
         rGnbHEYTHrhdqk02SmdJKd2LztA9KtjBJTEomsubSvylTYuD+xnWp9BzLnjZOYT5TjSH
         u1xUNAjQ/Fk6qMvzvACbl70Lmd72Ql8QSPe6vfOJVMsSC4DTd1zlNezwESTqi2uP96BV
         AIuw6Ql5/p5fdir91Q8qlNmKcNXdTuAJtHUbyU29g0jhpzQHPChCanneETjdScRzTYHc
         FdMz2RHX1RDkmwXXd4C1i+9iGxdQGt9JSwyJc6nAyZVW+ezdQMknhRFQeg2sbkGRaZMX
         ZygA==
X-Forwarded-Encrypted: i=1; AHgh+RrcbBOnxJkDRFYAA1XDKiH/RBJo1+5EJaBWiOKFHeq7ifWn6vktwlgcSlZ+vRBd8hb6xM8/UQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxB5/zBmM8xpnT7GUbuKx3Q+gfagGdSvpXhfHpE9aAd0g0lqSsz
	EXXs5S7eiAI02M32yYFFFy4Zry6yZ2jAp9NsvvGxXHbjkrr+D+x/wqt5
X-Gm-Gg: AfdE7clTrHjnvHrBuumii9NpPXSedU/9CNAqdUNgDpZoaG79zQhUg9NE/R1kvYKpiEV
	jGrE/P8nH9jpVd07X93ALwIeekDscSHZ21rvFBFkVOAFak3YfSJtRGFzLYnyNr1GY2Fu3Z51mdA
	0op5tnkE6T6edtxBmR06OAFraWiY04khpowi+XKKlXaahGBvAiLmX6gMWRPo3QHF5txabosee4k
	ipmrNit0MBYb/BVoMlsdEhAmyr/KYcWGoHH6d8PuuG1szbWLitPEjmcYIBurw1U4WGSrK7B688I
	OvLkxU711TQCK2s+VPvDQrlikTeXSDzoWzF5OX/nZ8MhrI3+Fnyfnp8yHzGYmouCPlBFvI+FCTo
	HTvr4T5wK0xLU+ceHC39xCk37O3P12C/ad6o2xFEh4NS0f9MuNuybY7my7s6ntKMeEmpdcK3zIm
	okzOqNpD6WYzONi3ErFTMWRuN5vGKJ6ox0GcP8N7wBSAUvSm5XOKfzCFLk9dVca8qJV3gO+7Kvs
	ns8z9QIDeDWtPoHk0FPlu8VDT0=
X-Received: by 2002:a05:600c:34d1:b0:493:b7f1:2e03 with SMTP id 5b1f17b1804b1-493e65e09a9mr7319995e9.0.1783496031640;
        Wed, 08 Jul 2026 00:33:51 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e610532fsm32876355e9.0.2026.07.08.00.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:33:50 -0700 (PDT)
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
Subject: [PATCH v6 6/7] docs/zh_CN: update DAMON reclaim translation
Date: Wed,  8 Jul 2026 07:32:45 +0000
Message-ID: <20260708073246.1652828-7-doehyunbaek@gmail.com>
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

