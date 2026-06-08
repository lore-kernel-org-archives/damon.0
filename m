Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B6B37DEB9
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898633; cv=none; b=YGTYzUrv6haWFW1kEiAGbvpN3IggJn31slCWanRickjrpOBcLeQ1vrn1QD78UA/n/KGAK2lKFqjRNfROrUNqE+MA9RUAC4YxT6ENtK6KNsXqzQYxO9o9DM0l9MG9o9TurJMjNpCrfjcR6ogc9mpN9KiQhWQ8OynlV1mxJZ1RrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898633; c=relaxed/simple;
	bh=FFhIP7BTbbw9cki8cXXHzmIP0TXcM2mazihadDvSN2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9bXiIvuGIVLVHREQs67SkdmM9h3QIULxnom9NkkwtIIEkjJ0Z2f6Trv0LtSZfrIc6p3LJw5UOxAhNcTbhSvrfn1z2wixz5VdCWODtFCbizWOW8wmyz9NMdUvMZ3jBnfphwM+hC1EEmft0PH9kAeMV7UQ0vVvBriNazsp0urF5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4UjfU7y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4UjfU7y"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b1c39fe4so4174285e9.3
        for <damon@lists.linux.dev>; Sun, 07 Jun 2026 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780898630; x=1781503430; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWaDRBNstbxfSINjd7BBh+qbUuVbuMy0CLtcMumXtTQ=;
        b=B4UjfU7ylK81ECc3+1PFPWU8IZjkDs27TIhqdRWF688pSzBfWhZfsSARctY90YOlAZ
         a6o4vE7e0FtVu7YOKaTbVX5E2N96cH6vlvPVLaVvZZIWdWz51dcij6KeA57DrRTwYTra
         1nfuBqUo+/psQOr3s1YmSadMUSZOeRdZyQGexZl1u7+cY566k+vquJZ6Yn7LMkrdLQ9X
         hkLX6NlVLAAe9AsXvkEFsg3+d3quyE7zRquPiXyIAcXO7ud4XDfvu1BPacEipF9gGgyF
         6y19xel/1qFzLf3fYdhHIJfj3FHUdbi8gQIVj6k0DoUHRfyecJ9iN1suHGJrCM0jvYzf
         nCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898630; x=1781503430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWaDRBNstbxfSINjd7BBh+qbUuVbuMy0CLtcMumXtTQ=;
        b=FMPEPct62UOw4OSGEcSseNlA3xhwwc8oQjSScdQirxfFNXKKx0E/p7SZXL/pAN7WhG
         6YjkSTaVPku7Shrht5JQGiNHn7JaYAGDdb/pueFY+Wz2jJu3zwWcrRbXWZ68snI2rKrX
         mPbNu2s1EE7GiC1H7RRqcqQ//tLKJzMo/g8qr3cenhtQqYJXxn0HCPzyAgmPRWzSIJhV
         iPY0WvFK796bbb1VVOAbcACbsmfBC7N/9yCjgQY2B6KRyBpaiQo0CDxwZ796tnxewO2I
         hxkWzd0aa+0Gpii6pij1jqcJs+SVrOwasDzK3oV2XkCpaPg9ZfM/t2+gFd4DTaWJgNgZ
         75dg==
X-Forwarded-Encrypted: i=1; AFNElJ98yWD4ipMRx7PgFnWnt0izwTYaLGhTPjdEmDl8qg9nYTWz8AhJEJQp3RoV+LKFXE6I/pP62w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsMstm2VFwQpLv7etU/ue7jJxlgj31XoB646f4d7NEnzhj3mv1
	x+pTpT9nZB0vNOSw2dgKs8TSnzwMMq6otpGs+hNZral0BrwFA2a5CnOl
X-Gm-Gg: Acq92OEbdO5ykjSaVp7nzovBdIC0x7D7vxbtZraqQW6YaJJt3XorSpkhyxsbNm7lrrT
	PPre2G0ArlwLNMYkT2NuN6ggnfp9aA8UgtwwsIuqPE2fiEymkEQ52l4i4NZicZ7QFkH7/lbj0OU
	g7kfK9dhzBVT4exYbC7dqMOZIkymTq2l7Tm3zw+/xHJZ3y48mLWA7rXBJiHp94P135JcG9zI/u1
	NZbR2K90MyWvAUek30iwwAcoc9sBEi/O8nu5xezQ3KS5PyKuwDb2GvVKLMU7A0vbUvL8uDHhcSI
	f2hP3GLN29GY9PyyId7XIlkIfseotkaC/A/qx4PJayNvXxCC4fTPmv6XPZfaES5z3qcb/SKUo4R
	OQ35njaBchh2PeayS/fGbdIelyY57vW4Nq5IyO7gQzJPEuAsOuH3F0n4aPs7lHkoa2QGZ0cz28j
	HO26aH3Oof9TouplPqkF45ksCPh8KBaWzcaEUM6rzB4pHG/T1LYdBVO8zKnSk5+6FlCogV5oAfj
	NTWSPlxBN9tqLyfNQBCYtjyBGfn7qJ1FsAamw==
X-Received: by 2002:a05:600c:8b82:b0:490:abf1:2ddb with SMTP id 5b1f17b1804b1-490c2603825mr103344495e9.6.1780898630330;
        Sun, 07 Jun 2026 23:03:50 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm392992805e9.8.2026.06.07.23.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:03:49 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	SeongJae Park <sj@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v2 2/2] docs/zh_TW: update DAMON usage Traditional Chinese translation
Date: Mon,  8 Jun 2026 06:03:02 +0000
Message-ID: <20260608060302.1564003-3-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608060302.1564003-1-doehyunbaek@gmail.com>
References: <20260523094420.741003-1-doehyunbaek@gmail.com>
 <20260608060302.1564003-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the translation of .../admin-guide/mm/damon/usage.rst into
Traditional Chinese.

Update the translation through commit d9cfe515d36e
("Docs/admin-guide/mm/damon/usage: document goal_tuner sysfs file")

Signed-off-by: Doehyun Baek <doehyunbaek@gmail.com>
---
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 56 +++++++++++++------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
index d3fd4f850793..debe455723af 100644
--- a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
+++ b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
@@ -15,6 +15,10 @@
 
 DAMON 爲不同的用戶提供了下面這些接口。
 
+- *專用DAMON模塊。*
+  :ref:`這 <damon_modules_special_purpose>` 是爲構建、發佈或管理帶有專用DAMON用法的內
+  核的用戶準備的。使用它，用戶可以在構建、啓動或運行時以簡單的方式爲給定目的使用DAMON的主要
+  功能。
 - *DAMON用戶空間工具。*
   `這 <https://github.com/damonitor/damo>`_ 爲有這特權的人， 如系統管理員，希望有一個剛好
   可以工作的人性化界面。
@@ -55,14 +59,14 @@ DAMON sysfs接口的文件層次結構如下圖所示。在下圖中，父子關
 
     /sys/kernel/mm/damon/admin
     │ kdamonds/nr_kdamonds
-    │ │ 0/state,pid
+    │ │ 0/state,pid,refresh_ms
     │ │ │ contexts/nr_contexts
-    │ │ │ │ 0/operations
+    │ │ │ │ 0/operations,addr_unit
     │ │ │ │ │ monitoring_attrs/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ targets/nr_targets
-    │ │ │ │ │ │ 0/pid_target
+    │ │ │ │ │ │ 0/pid_target,obsolete_target
     │ │ │ │ │ │ │ regions/nr_regions
     │ │ │ │ │ │ │ │ 0/start,end
     │ │ │ │ │ │ │ │ ...
@@ -73,10 +77,12 @@ DAMON sysfs接口的文件層次結構如下圖所示。在下圖中，父子關
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
     │ │ │ │ │ │ │ │ age/min,max
-    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
+    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms,goal_tuner
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
+    │ │ │ │ │ │ │ │ goals/nr_goals
+    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid
     │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
-    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
+    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds,nr_snapshots,max_nr_snapshots
     │ │ │ │ │ │ │ tried_regions/
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
     │ │ │ │ │ │ │ │ ...
@@ -104,7 +110,8 @@ kdamonds/
 kdamonds/<N>/
 -------------
 
-在每個kdamond目錄中，存在兩個文件（``state`` 和 ``pid`` ）和一個目錄( ``contexts`` )。
+在每個kdamond目錄中，存在三個文件（``state``、``pid`` 和 ``refresh_ms``）和一個目錄
+(``contexts``)。
 
 讀取 ``state`` 時，如果kdamond當前正在運行，則返回 ``on`` ，如果沒有運行則返回 ``off`` 。
 寫入 ``on`` 或 ``off`` 使kdamond處於狀態。向 ``state`` 文件寫 ``update_schemes_stats`` ，
@@ -117,6 +124,10 @@ kdamonds/<N>/
 
 如果狀態爲 ``on``，讀取 ``pid`` 顯示kdamond線程的pid。
 
+用戶可以要求內核通過 ``refresh_ms`` 文件週期性地更新顯示自動調優參數和DAMOS統計信息的文件。
+向該文件寫入希望的更新時間間隔（毫秒）。如果間隔爲零，則禁用週期性更新。讀取該文件會顯示當前
+設置的時間間隔。
+
 ``contexts`` 目錄包含控制這個kdamond要執行的監測上下文的文件。
 
 kdamonds/<N>/contexts/
@@ -129,8 +140,8 @@ kdamonds/<N>/contexts/
 contexts/<N>/
 -------------
 
-在每個上下文目錄中，存在一個文件(``operations``)和三個目錄(``monitoring_attrs``,
-``targets``, 和 ``schemes``)。
+在每個上下文目錄中，存在兩個文件（``operations`` 和 ``addr_unit``）和三個目錄
+（``monitoring_attrs``、``targets`` 和 ``schemes``）。
 
 DAMON支持多種類型的監測操作，包括對虛擬地址空間和物理地址空間的監測。你可以通過向文件
 中寫入以下關鍵詞之一，並從文件中讀取，來設置和獲取DAMON將爲上下文使用何種類型的監測操作。
@@ -138,6 +149,8 @@ DAMON支持多種類型的監測操作，包括對虛擬地址空間和物理地
  - vaddr: 監測特定進程的虛擬地址空間
  - paddr: 監視系統的物理地址空間
 
+``addr_unit`` 文件用於設置和獲取操作集的 :ref:`地址單位 <damon_design_addr_unit>` 參數。
+
 contexts/<N>/monitoring_attrs/
 ------------------------------
 
@@ -161,11 +174,15 @@ contexts/<N>/targets/
 targets/<N>/
 ------------
 
-在每個目標目錄中，存在一個文件(``pid_target``)和一個目錄(``regions``)。
+在每個目標目錄中，存在兩個文件（``pid_target`` 和 ``obsolete_target``）和一個目錄
+（``regions``）。
 
 如果你把 ``vaddr`` 寫到 ``contexts/<N>/operations`` 中，每個目標應該是一個進程。你
 可以通過將進程的pid寫到 ``pid_target`` 文件中來指定DAMON的進程。
 
+用戶可以向 ``obsolete_target`` 文件寫入非零值並提交它（向 ``state`` 文件寫入 ``commit``），
+從目標數組中間選擇性地刪除目標。
+
 targets/<N>/regions
 -------------------
 
@@ -239,14 +256,20 @@ schemes/<N>/quotas/
 當預計超過配額限制時，DAMON會根據 ``目標訪問模式`` 的大小、訪問頻率和年齡，對找到的內存區域
 進行優先排序。爲了進行個性化的優先排序，用戶可以爲這三個屬性設置權重。
 
-在 ``quotas`` 目錄下，存在三個文件（``ms``, ``bytes``, ``reset_interval_ms``）和一個
-目錄(``weights``)，其中有三個文件(``sz_permil``, ``nr_accesses_permil``, 和
-``age_permil``)。
+在 ``quotas`` 目錄下，存在四個文件（``ms``、``bytes``、``reset_interval_ms`` 和
+``goal_tuner``）和兩個目錄（``weights`` 和 ``goals``）。
 
 你可以設置以毫秒爲單位的 ``時間配額`` ，以字節爲單位的 ``大小配額`` ，以及以毫秒爲單位的 ``重
 置間隔`` ，分別向這三個文件寫入數值。你還可以通過向 ``weights`` 目錄下的三個文件寫入數值來設
 置大小、訪問頻率和年齡的優先權，單位爲千分之一。
 
+你可以通過向 ``goal_tuner`` 文件寫入算法名稱，設置要使用的基於目標的有效配額自動調優算法。
+讀取該文件會返回當前選定的調優器算法。
+
+``goals`` 目錄用於設置自動配額調優目標。每個目標目錄包含 ``target_metric``、
+``target_value``、``current_value`` 和 ``nid`` 文件。用戶可以讀寫這些文件來設置和獲取配額
+自動調優目標的參數。
+
 schemes/<N>/watermarks/
 -----------------------
 
@@ -271,10 +294,11 @@ schemes/<N>/stats/
 DAMON統計每個方案被嘗試應用的區域的總數量和字節數，每個方案被成功應用的區域的兩個數字，以及
 超過配額限制的總數量。這些統計數據可用於在線分析或調整方案。
 
-可以通過讀取 ``stats`` 目錄下的文件(``nr_tried``, ``sz_tried``, ``nr_applied``,
-``sz_applied``, 和 ``qt_exceeds``)）分別檢索這些統計數據。這些文件不是實時更新的，所以
-你應該要求DAMON sysfs接口通過在相關的 ``kdamonds/<N>/state`` 文件中寫入一個特殊的關鍵字
-``update_schemes_stats`` 來更新統計信息的文件內容。
+可以通過讀取 ``stats`` 目錄下的文件（``nr_tried``、``sz_tried``、``nr_applied``、
+``sz_applied``、``qt_exceeds``、``nr_snapshots`` 和 ``max_nr_snapshots``）分別檢索這些
+統計數據。這些文件默認不是實時更新的。你應該要求DAMON sysfs接口通過 ``refresh_ms`` 週期性地
+更新這些文件，或者通過在相關的 ``kdamonds/<N>/state`` 文件中寫入一個特殊的關鍵字
+``update_schemes_stats`` 來執行一次性更新。
 
 schemes/<N>/tried_regions/
 --------------------------
-- 
2.43.0

