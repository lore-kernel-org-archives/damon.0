Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E51D5CC6
	for <damon@lists.linux.dev>; Sat, 14 Mar 2026 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480114; cv=none; b=TjV621hqpKt92vdYfyyehCY/kiE6ovrOOcVsE1GZblFsrzaCJiDtFZDj9fArNQzSxYz+FTdGqzO+TL6NizW3So3BghomCqpwyVz0Spy/y7o+v8aoBjkmp0Uba5d6Tt+07iGO9ZjcTJKO1VUgkPgFhXbR2bFVWa+MTdJEjkY9Lis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480114; c=relaxed/simple;
	bh=mShEPgqQ4gwpWXszIVcZwkGp+DapTpAMp+A7Ak/Pw/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mUJVOtwhZqVuJWzNwaZp5cXBQzjuDPVxKHk+2V59Cex4CLKu5yN8k0lu8/+YQYJ/k8FM+eSZElXL33lYKhozcrrOk77ztXG1OFhm4erh42s1s4khb6dXHdltgLck4I7kYpqgVyj2RctGfD0XRjMlTBE97y3Ida2mtQ0fSRzRSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXrLvmHs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXrLvmHs"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae3a2f6007so22376055ad.2
        for <damon@lists.linux.dev>; Sat, 14 Mar 2026 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773480112; x=1774084912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r8UyqgPfbZdaAqDYqS1YD/8TcYT8kvUB1s3GvokTCwQ=;
        b=PXrLvmHsk+H3064ddT1EKSmQ8kkVv9E33uCcHOZiKj388PEC71V/W2+GoeJ0XEpBH+
         vvh13Ywa6kesqVZpkQJ1ZpTKEoU93mos2vX03fsIlNSBr7XXATnU5XNM7zAcIVL4cO/9
         FqCFf/r6KznARdBPcq/8QkyOvyKHhbhv4yhiyMuNp6cW/lKLmYo8OB8WiYXzHs2TFwND
         g4h6L2lrkVDQzST7bbE3Qi8qo5DsX0IioD+BwAH2ZYs0eRVoXNAukW2ldpxGqwmmsl0P
         VgZRC8rQc1Lzz7IeXHpQ+OW+zkoiCG3CR56rDif9LbD0TaYBx/uIEDxPVfHuQBG1QHxA
         aHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773480112; x=1774084912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8UyqgPfbZdaAqDYqS1YD/8TcYT8kvUB1s3GvokTCwQ=;
        b=BXzS78luDuRDQ9koXxPsDj+wWlb2ucJw/xI7Ea7bYUMTgPYyfv4WLbNWGuFRutKyXx
         mIvNRnAXTP1/mZzFQqJn7rfsP9mD7RWEfnqnOWpTlnCNve29CXGmr3NUfJSMGyJpFXKb
         kTZsoLXtUuYnv9t/c0bj9q08zbQlwMiVLd/x6M23ZgjfwpOMCmcZeNjNFExbhFBypBw6
         paSYNa5U2mqE+jya+7U3aC4kT/2DPAN38RUKvV4vZitugQkoyRgP88ZD+R5W8Wml5vJP
         ez52jaRn7wcN0FG1sbrfLXnh9z3BAnS1I7iBXCd4gRgVbMNbbe4iomVItiAdFEKW5Pkq
         NnSA==
X-Gm-Message-State: AOJu0YyrR4i3XQ2YnpqHDcPhuma30XV1mFC/C3i4RG1yj+fiOCDp0nvK
	TrUjGqN2R22ar75sAOx8M1KDMvewLF7J29opzNLzJyjGPPgORjAQom4o
X-Gm-Gg: ATEYQzw+oGICKklbSV5tJnANwguLNYgdR1UkOSrvrLGWeDjnmu9qcjxgzNd9UwsqZ73
	Phx8n+JCYrT5xp+gBvCCv7bz1MUnYOWzVVuXqlJPQSlcqAMmXwbbbkkvkGijxCUHJAngx7EiRnm
	L5CZ9Z2wHxhyUS4AwOFLAWP2tViRBugE9WEsQsHc6m5+115KdrEdzYUhhkiWWjSZ3cE87MoNlgt
	6GNWqVBu3PHu5Dkvm3CXsK+bms8429c1i3VOXkgf+hMsKKVm5eCpOvtnlNdRnOCHF8P7/tDdhJX
	dr5Sh3jEHAoRnzXrT45PvWWaotkFucSPJyOOccBSNSrYPoi+lrI9w7YiA6L/y2zRioR+K6PTyTS
	geDtCLMm0b/KEIz9zeyka+KwTcvl1I8yvGKhIMdhbsF2uAIJmGZ41oTGknVk6+sQYafJS3XrvpP
	lwlq4BCn5viPK1FmIfaAem5pz810Sbnh3jwk+9KT6Gi32z5hIL0c4vUr1F1D5u3w==
X-Received: by 2002:a17:902:db05:b0:2ae:5eee:7a5 with SMTP id d9443c01a7336-2aeca9a9d72mr69364795ad.12.1773480112336;
        Sat, 14 Mar 2026 02:21:52 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:89d:b6e6:2613:d00e:127b:1c64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece62c4f9sm47907385ad.38.2026.03.14.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 02:21:52 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH] Docs/mm/damon: document exclusivity of special-purpose modules
Date: Sat, 14 Mar 2026 17:20:22 +0800
Message-ID: <20260314092145.7496-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section in design.rst to explain that DAMON special-purpose kernel
modules (LRU_SORT, RECLAIM, STAT) run in an exclusive manner and return
-EBUSY if another is already running.

Update lru_sort.rst, reclaim.rst and stat.rst by adding cross-references
to this exclusivity rule at the end of their respective Example
sections.

While at it, fix a Sphinx syntax error in the "contents" directive in
design.rst (missing space after :depth:) that prevents the table of
contents from being rendered on docs.kernel.org.

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Link: https://lore.kernel.org/damon/20260314002119.79742-1-sj@kernel.org/T/#t
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 5 +++++
 Documentation/admin-guide/mm/damon/reclaim.rst  | 5 +++++
 Documentation/admin-guide/mm/damon/stat.rst     | 5 +++++
 Documentation/mm/damon/design.rst               | 6 +++++-
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 06a46812a728..0198dfe87f4d 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -353,3 +353,8 @@ the LRU-list based page granularity reclamation. ::
     # echo 400 > wmarks_mid
     # echo 200 > wmarks_low
     # echo Y > enabled
+
+Note that this module (damon_lru_sort) cannot run simultaneously with other
+DAMON-based special-purpose modules.  Refer to :ref:`DAMON design special
+purpose modules exclusivity <damon_design_special_purpose_modules_exclusivity>`
+for more details.
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index c5b4d8a1b001..a37ce6fdff05 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -331,6 +331,11 @@ granularity reclamation. ::
     # echo 200 > wmarks_low
     # echo Y > enabled
 
+Note that this module (damon_reclaim) cannot run simultaneously with other
+DAMON-based special-purpose modules.  Refer to :ref:`DAMON design special
+purpose modules exclusivity <damon_design_special_purpose_modules_exclusivity>`
+for more details.
+
 .. [1] https://research.google/pubs/pub48551/
 .. [2] https://lwn.net/Articles/787611/
 .. [3] Documentation/mm/free_page_reporting.rst
diff --git a/Documentation/admin-guide/mm/damon/stat.rst b/Documentation/admin-guide/mm/damon/stat.rst
index 468c122c4259..46c5dd96aa2e 100644
--- a/Documentation/admin-guide/mm/damon/stat.rst
+++ b/Documentation/admin-guide/mm/damon/stat.rst
@@ -45,6 +45,11 @@ You can enable DAMON_STAT by setting the value of this parameter as ``Y``.
 Setting it as ``N`` disables DAMON_STAT.  The default value is set by
 ``CONFIG_DAMON_STAT_ENABLED_DEFAULT`` build config option.
 
+Note that this module (damon_stat) cannot run simultaneously with other
+DAMON-based special-purpose modules.  Refer to :ref:`DAMON design special
+purpose modules exclusivity <damon_design_special_purpose_modules_exclusivity>`
+for more details.
+
 .. _damon_stat_aggr_interval_us:
 
 aggr_interval_us
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 0a3b77ec458f..3694c541e65a 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -5,7 +5,7 @@ Design
 ======
 
 .. contents:: :local:
-   :depth:2
+   :depth: 2
 
 .. _damon_design_execution_model_and_data_structures:
 
@@ -960,6 +960,10 @@ more detail, please read the usage documents for those
 (:doc:`/admin-guide/mm/damon/stat`, :doc:`/admin-guide/mm/damon/reclaim` and
 :doc:`/admin-guide/mm/damon/lru_sort`).
 
+.. _damon_design_special_purpose_modules_exclusivity:
+
+Note that these modules currently run in an exclusive manner.  If one of those
+is already running, others will return ``-EBUSY`` upon start requests.
 
 Sample DAMON Modules
 --------------------
-- 
2.53.0

