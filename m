Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76415314D26
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901899; cv=none; b=C7WWCWYoQRm4j6HedH0rmRaJQqtc2wvzdjE2JC73Rtb1+FXmItj1ISbS2Q2LZLbix79V10IkQt8L7yUQuYppjo/Fnqo9jBH468Cse7LS0PCdK7lElth/5FB5wUKr3i6rgaas9JgkRrO7Xb/cHJzgWXW/96u0UBgX53pjlAE12X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901899; c=relaxed/simple;
	bh=wx7qMJ7Iamyzo0QtWV4RXU4ZcByaazKyPpJosGWvGu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGYhN4/t4ItQyJQOL7cs2xVQXeoL/xsFRmKb+vy5CmDybtssSQfxV3O19ft2NRBiZ8WMoSrJIc8xcbladpxfRz5mci8gx+Wur0lW4TFhHszdmbF57MVJwDa/XFxWHzTmAnpXBCxZUAHIX8Pw6cmgfzwjnCR10kbc47S+pyGarhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czbt5T2l; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czbt5T2l"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef57256d8so306096f8f.3
        for <damon@lists.linux.dev>; Sun, 07 Jun 2026 23:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780901896; x=1781506696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbrGh+Fkk25cvqP+g9UEoqlL2MKbEwoKashdUTVmxgA=;
        b=czbt5T2lw00taNVNkjOBYv7nUc5gT/bflTmcYbquoyxanEjM7SJF6I99mYDoEc91Fq
         XnqdTidt1Q3feAVpHdCFRJnEJV+8WSKA+ZxCi6RRSnYKh3HssOOUOm6CuGdcDPQku58a
         SuaaijakNo3HSXYphVi4QqvQLjlKxR9qUO+1tjf4/VuYLCEpkDIzC1egvdz/LUY+j4mc
         H5VUDoa3bwFM2Jr0l/i28mW5zivKybb/Zi9hQ0dgl0yZFDSLrYuGHy9QoMgYSClGsh9s
         27goMcGL8lMBI28BSmzqdJ4FMRoG0XyCg/fea2owRXo0psy6vhuZtENhFYh7me6rlDku
         xYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901896; x=1781506696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UbrGh+Fkk25cvqP+g9UEoqlL2MKbEwoKashdUTVmxgA=;
        b=Z8HwIF58ZJV0P/AYV/7V5Jaun52VMMpbo20FYvyy1Rr77QQu0q1g2xlK6rJ7z4PwJ0
         LVAdT+nQf6Q6W6FeQZsQ10xK3dbBcBTk+JQY1OzIPJC4SVWUVq5LvH7ahh+exCoqXnrW
         utuMY4F9RXcogN5DRyUayqIx6FuPJReylB1JyvYxRcz/XctXIF1IPnHshGTRZcvDMA0O
         Ljy+cI/VR5aQaITLo0g1KR5/5Rq08RPa9xaiCIktEdKWaD+mri50FLvaRUV3WniueDxS
         vaifZZNpEX+PGvd4PHL1fIcleypv7LT0Nn9FgoKAxxVA5IqWuEzd4QGn5WcLDwApHy/V
         23yw==
X-Forwarded-Encrypted: i=1; AFNElJ8o4a3XRLP1dzK4ir3DsJiOg1QKxsKIynHoXa67L1ENdj7ctpqzE7ZhtZo1tIoItdf5bEvjtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxK4U24CMsVKHBnHDK28jtqcBbdLh0Wbf1D6HE8OiM20AThlLOq
	Q7xQM/yB/1j08LBfPNTo0XVOCrcedvh1c7QKH/CTOtI4/GH7nVx9/8g0
X-Gm-Gg: Acq92OH+DRKHuVn8IousK544tT4ofM5YCFXZHHdEAUtm3dqGzFUdRX8VtVcci+Zukir
	IeAww8vJ9LYgE2MFq9zK6fFIOuKJ9iRSp4TGty2QMYno1DwKKr31UKfbjUA1M2836Uk5a2zhRd6
	1MJvC9nzydqyvWKQFLFmrwc5eyNq5ZunJG/rFAoNcngFa+/Alr95XPiiYzo52b/ekiP31aDkRsF
	mheVYvXbp89HsMhX+r/2ZFBtMqqjhslEa7gDZ4yxkRXMb+nhCluaDGyH4egzFyeGwiGZuT13tGe
	/8zPYekqK3UNv0B4d5iaoy/jA3VtwF6mIQMhSyHvW0IQA2F1YttfFkdd2gvNp9p5g6RfG29Whpt
	DmBXTU/iGBgQKSjuceTS9RV4+9CBdn8dK6XR/IjpAwl7vbWwHiTzRek5xMBF6ye/OMfcXD9fRSj
	oX+q63UdzJAMFwTTWY13fHIJ3vOgYHAKgAqgzG3x/KMrsxwHQ7YFN+l0eHrAuKTojaK0CptM8Mf
	UIjnBXBycTUseA1bjRQ8K9p+psEJLdnn+U5Kw==
X-Received: by 2002:a05:6000:715:b0:441:1c35:4b79 with SMTP id ffacd0b85a97d-4603076f62bmr8473103f8f.8.1780901895621;
        Sun, 07 Jun 2026 23:58:15 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm89908194f8f.29.2026.06.07.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:58:15 -0700 (PDT)
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
Subject: [PATCH v3 2/2] docs/zh_TW: update DAMON usage Traditional Chinese translation
Date: Mon,  8 Jun 2026 06:57:45 +0000
Message-ID: <20260608065745.1587885-3-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608065745.1587885-1-doehyunbaek@gmail.com>
References: <20260523094420.741003-1-doehyunbaek@gmail.com>
 <20260608065745.1587885-1-doehyunbaek@gmail.com>
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
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 92 +++++++++++++------
 1 file changed, 65 insertions(+), 27 deletions(-)

diff --git a/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst b/Documentation/translations/zh_TW/admin-guide/mm/damon/usage.rst
index d3fd4f850793..636ac997767b 100644
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
@@ -55,30 +59,37 @@ DAMON sysfs接口的文件層次結構如下圖所示。在下圖中，父子關
 
     /sys/kernel/mm/damon/admin
     │ kdamonds/nr_kdamonds
-    │ │ 0/state,pid
+    │ │ 0/state,pid,refresh_ms
     │ │ │ contexts/nr_contexts
-    │ │ │ │ 0/operations
+    │ │ │ │ 0/avail_operations,operations,addr_unit
     │ │ │ │ │ monitoring_attrs/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
+    │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
     │ │ │ │ │ │ nr_regions/min,max
     │ │ │ │ │ targets/nr_targets
-    │ │ │ │ │ │ 0/pid_target
+    │ │ │ │ │ │ 0/pid_target,obsolete_target
     │ │ │ │ │ │ │ regions/nr_regions
     │ │ │ │ │ │ │ │ 0/start,end
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ │ schemes/nr_schemes
-    │ │ │ │ │ │ 0/action
+    │ │ │ │ │ │ 0/action,target_nid,apply_interval_us
     │ │ │ │ │ │ │ access_pattern/
     │ │ │ │ │ │ │ │ sz/min,max
     │ │ │ │ │ │ │ │ nr_accesses/min,max
     │ │ │ │ │ │ │ │ age/min,max
-    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms
+    │ │ │ │ │ │ │ quotas/ms,bytes,reset_interval_ms,effective_bytes,goal_tuner
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
+    │ │ │ │ │ │ │ │ goals/nr_goals
+    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
     │ │ │ │ │ │ │ watermarks/metric,interval_us,high,mid,low
-    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
-    │ │ │ │ │ │ │ tried_regions/
-    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
+    │ │ │ │ │ │ │ {core_,ops_,}filters/nr_filters
+    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
+    │ │ │ │ │ │ │ dests/nr_dests
+    │ │ │ │ │ │ │ │ 0/id,weight
+    │ │ │ │ │ │ │ stats/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
+    │ │ │ │ │ │ │ tried_regions/total_bytes
+    │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ ...
     │ │ │ │ │ │ ...
     │ │ │ │ ...
@@ -104,7 +115,8 @@ kdamonds/
 kdamonds/<N>/
 -------------
 
-在每個kdamond目錄中，存在兩個文件（``state`` 和 ``pid`` ）和一個目錄( ``contexts`` )。
+在每個kdamond目錄中，存在三個文件（``state``、``pid`` 和 ``refresh_ms``）和一個目錄
+(``contexts``)。
 
 讀取 ``state`` 時，如果kdamond當前正在運行，則返回 ``on`` ，如果沒有運行則返回 ``off`` 。
 寫入 ``on`` 或 ``off`` 使kdamond處於狀態。向 ``state`` 文件寫 ``update_schemes_stats`` ，
@@ -117,6 +129,10 @@ kdamonds/<N>/
 
 如果狀態爲 ``on``，讀取 ``pid`` 顯示kdamond線程的pid。
 
+用戶可以要求內核通過 ``refresh_ms`` 文件週期性地更新顯示自動調優參數和DAMOS統計信息的文件。
+向該文件寫入希望的更新時間間隔（毫秒）。如果間隔爲零，則禁用週期性更新。讀取該文件會顯示當前
+設置的時間間隔。
+
 ``contexts`` 目錄包含控制這個kdamond要執行的監測上下文的文件。
 
 kdamonds/<N>/contexts/
@@ -129,15 +145,19 @@ kdamonds/<N>/contexts/
 contexts/<N>/
 -------------
 
-在每個上下文目錄中，存在一個文件(``operations``)和三個目錄(``monitoring_attrs``,
-``targets``, 和 ``schemes``)。
+在每個上下文目錄中，存在三個文件（``avail_operations``、``operations`` 和
+``addr_unit``）和三個目錄（``monitoring_attrs``、``targets`` 和 ``schemes``）。
 
-DAMON支持多種類型的監測操作，包括對虛擬地址空間和物理地址空間的監測。你可以通過向文件
-中寫入以下關鍵詞之一，並從文件中讀取，來設置和獲取DAMON將爲上下文使用何種類型的監測操作。
+DAMON支持多種類型的監測操作，包括對虛擬地址空間和物理地址空間的監測。你可以通過讀取
+``avail_operations`` 文件獲取可用的監測操作集列表。你可以通過向 ``operations`` 文件中寫入
+``avail_operations`` 文件列出的關鍵詞之一，並從文件中讀取，來設置和獲取DAMON將爲上下文使用
+何種類型的監測操作。
 
  - vaddr: 監測特定進程的虛擬地址空間
  - paddr: 監視系統的物理地址空間
 
+``addr_unit`` 文件用於設置和獲取操作集的 :ref:`地址單位 <damon_design_addr_unit>` 參數。
+
 contexts/<N>/monitoring_attrs/
 ------------------------------
 
@@ -161,11 +181,15 @@ contexts/<N>/targets/
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
 
@@ -203,8 +227,9 @@ contexts/<N>/schemes/
 schemes/<N>/
 ------------
 
-在每個方案目錄中，存在五個目錄(``access_pattern``、``quotas``、``watermarks``、
-``stats`` 和 ``tried_regions``)和一個文件(``action``)。
+在每個方案目錄中，存在九個目錄（``access_pattern``、``quotas``、``watermarks``、
+``core_filters``、``ops_filters``、``filters``、``dests``、``stats`` 和
+``tried_regions``）和三個文件（``action``、``target_nid`` 和 ``apply_interval_us``）。
 
 ``action`` 文件用於設置和獲取你想應用於具有特定訪問模式的內存區域的動作。可以寫入文件
 和從文件中讀取的關鍵詞及其含義如下。
@@ -218,6 +243,9 @@ schemes/<N>/
  - ``lru_deprio``: 對區域的LRU列表進行降低優先處理。
  - ``stat``: 什麼都不做，只計算統計數據
 
+``target_nid`` 文件用於設置遷移目標節點，僅當 ``action`` 爲 ``migrate_hot`` 或
+``migrate_cold`` 時有意義。``apply_interval_us`` 文件用於以微秒爲單位設置和獲取方案的應用間隔。
+
 schemes/<N>/access_pattern/
 ---------------------------
 
@@ -239,14 +267,20 @@ schemes/<N>/quotas/
 當預計超過配額限制時，DAMON會根據 ``目標訪問模式`` 的大小、訪問頻率和年齡，對找到的內存區域
 進行優先排序。爲了進行個性化的優先排序，用戶可以爲這三個屬性設置權重。
 
-在 ``quotas`` 目錄下，存在三個文件（``ms``, ``bytes``, ``reset_interval_ms``）和一個
-目錄(``weights``)，其中有三個文件(``sz_permil``, ``nr_accesses_permil``, 和
-``age_permil``)。
+在 ``quotas`` 目錄下，存在五個文件（``ms``、``bytes``、``reset_interval_ms``、
+``effective_bytes`` 和 ``goal_tuner``）和兩個目錄（``weights`` 和 ``goals``）。
 
 你可以設置以毫秒爲單位的 ``時間配額`` ，以字節爲單位的 ``大小配額`` ，以及以毫秒爲單位的 ``重
 置間隔`` ，分別向這三個文件寫入數值。你還可以通過向 ``weights`` 目錄下的三個文件寫入數值來設
 置大小、訪問頻率和年齡的優先權，單位爲千分之一。
 
+你可以通過向 ``goal_tuner`` 文件寫入算法名稱，設置要使用的基於目標的有效配額自動調優算法。
+讀取該文件會返回當前選定的調優器算法。讀取 ``effective_bytes`` 會返回當前有效大小配額。
+
+``goals`` 目錄用於設置自動配額調優目標。每個目標目錄包含 ``target_metric``、
+``target_value``、``current_value``、``nid`` 和 ``path`` 文件。用戶可以讀寫這些文件來設置
+和獲取配額自動調優目標的參數。
+
 schemes/<N>/watermarks/
 -----------------------
 
@@ -271,16 +305,21 @@ schemes/<N>/stats/
 DAMON統計每個方案被嘗試應用的區域的總數量和字節數，每個方案被成功應用的區域的兩個數字，以及
 超過配額限制的總數量。這些統計數據可用於在線分析或調整方案。
 
-可以通過讀取 ``stats`` 目錄下的文件(``nr_tried``, ``sz_tried``, ``nr_applied``,
-``sz_applied``, 和 ``qt_exceeds``)）分別檢索這些統計數據。這些文件不是實時更新的，所以
-你應該要求DAMON sysfs接口通過在相關的 ``kdamonds/<N>/state`` 文件中寫入一個特殊的關鍵字
-``update_schemes_stats`` 來更新統計信息的文件內容。
+可以通過讀取 ``stats`` 目錄下的文件（``nr_tried``、``sz_tried``、``nr_applied``、
+``sz_applied``、``sz_ops_filter_passed``、``qt_exceeds``、``nr_snapshots`` 和
+``max_nr_snapshots``）分別檢索這些
+統計數據。這些文件默認不是實時更新的。你應該要求DAMON sysfs接口通過 ``refresh_ms`` 週期性地
+更新這些文件，或者通過在相關的 ``kdamonds/<N>/state`` 文件中寫入一個特殊的關鍵字
+``update_schemes_stats`` 來執行一次性更新。
 
 schemes/<N>/tried_regions/
 --------------------------
 
+該目錄開始時有一個文件 ``total_bytes``。
+
 當一個特殊的關鍵字 ``update_schemes_tried_regions`` 被寫入相關的 ``kdamonds/<N>/state``
-文件時，DAMON會在這個目錄下創建從 ``0`` 開始命名的整數目錄。每個目錄包含的文件暴露了關於每個
+文件時，DAMON會更新 ``total_bytes`` 文件，使讀取該文件返回方案嘗試區域的總大小，並在這個目錄下
+創建從 ``0`` 開始命名的整數目錄。每個目錄包含的文件暴露了關於每個
 內存區域的詳細信息，在下一個 :ref:`聚集區間 <sysfs_monitoring_attrs>`，相應的方案的 ``動作``
 已經嘗試在這個目錄下應用。這些信息包括地址範圍、``nr_accesses`` 以及區域的 ``年齡`` 。
 
@@ -290,9 +329,8 @@ schemes/<N>/tried_regions/
 tried_regions/<N>/
 ------------------
 
-在每個區域目錄中，你會發現四個文件(``start``, ``end``, ``nr_accesses``, and ``age``)。
-讀取這些文件將顯示相應的基於DAMON的操作方案 ``動作`` 試圖應用的區域的開始和結束地址、``nr_accesses``
-和 ``年齡`` 。
+在每個區域目錄中，你會發現五個文件（``start``、``end``、``nr_accesses``、``age`` 和
+``sz_filter_passed``）。讀取這些文件將顯示相應的基於DAMON的操作方案 ``動作`` 試圖應用的區域屬性。
 
 用例
 ~~~~
-- 
2.43.0

