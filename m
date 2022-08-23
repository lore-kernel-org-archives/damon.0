Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5CED4
	for <damon@lists.linux.dev>; Tue, 23 Aug 2022 11:41:08 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id 83so7498058pfw.6
        for <damon@lists.linux.dev>; Tue, 23 Aug 2022 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=EX/82qnQonQiLqn4wSbDmFcuxyzSeSG7gW+qIxvJMUI=;
        b=EFoqdBDkG/5UPV6HPIgvFcGc0TyYf/CF3yiYdCUZx4myoPyDIRta+YXXtjyiRuQroo
         34I1JKEGwEmYjmYB0oFj/hVGgCOcNAdGKuSp7d7eSNpTBV7s5pNKvxG36/ySBhSvMqHE
         qCaiJyxYJV+IFtlBSUSgkipI330atbUVMCk4hQzY1rxtI+m2mV24n0ZLez9g1GXR3suN
         AOTWJuHdfS0pLOYdoOh3ktoXGcQpmkpOTAYDA1FZVMijbtwvnhvrWalj9gGn02HKRN5/
         VCKYUVyZzr8EIVzLhFNgeeEHBMANveL39F7scu6vEWxpymxF/265DWRbQwOEEZ9W7NOB
         OWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=EX/82qnQonQiLqn4wSbDmFcuxyzSeSG7gW+qIxvJMUI=;
        b=q+alI0c0+arZWJ503VKUso0JF+vM9qkc7+l3qgNPhg36bqFtPsqnyuN93SzDijswn9
         EujWEXqmKjh1tmxPssClLqH03S1rPntlwQai8t6YzwuHaJ36UouJ0m85ql2zT9J99cap
         J0MRxWxEvCevTHdmOwI9TJfZNfdCx38GYULAV+8LF9G8lc2utb5IBRscFT3Sg//kYucP
         SqBtFvpJOyfBs3oVeLMTy+rEknRF2350TsP7IrcyEUGSRIiavAo1M2xfcEtn/s0J34Hx
         75d3S6Xr+MCHr15UJ4XlZTIB7L5wOp03/3GsbhQAJ+DUT8SYS5lV92jZu+rHlMDg+Xek
         ThhA==
X-Gm-Message-State: ACgBeo3Q3zkuI5nEyaZwXL/BJIpOnA2uxV7KncgEIsjX6BXgXJ7Q5Nu1
	wGyAPcB5h6EL8p547RQ9nM3g6+UeDnULJpEx
X-Google-Smtp-Source: AA6agR6Zoi1wt/3LicRsVwqrm1eY/YMZMWLbHbEeTaewbnS24yU05Iszmm4dd63rApd0x4zfOTf9vw==
X-Received: by 2002:a05:6a00:88f:b0:530:dec:81fd with SMTP id q15-20020a056a00088f00b005300dec81fdmr25156305pfj.64.1661254867730;
        Tue, 23 Aug 2022 04:41:07 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id w23-20020a627b17000000b0052d16416effsm10562930pfc.80.2022.08.23.04.41.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Aug 2022 04:41:07 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2] Docs/admin-guide/mm/damon/usage: fix the example code snip
Date: Tue, 23 Aug 2022 19:40:53 +0800
Message-Id: <20220823114053.53305-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

The workflow example code is not working since it got the file names
wrong. So fix this.

Fixes: b18402726bd1 ("Docs/admin-guide/mm/damon/usage: document DAMON sysfs interface")
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 Documentation/admin-guide/mm/damon/usage.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d52f572a90298..ca91ecc290785 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -50,10 +50,10 @@ For a short example, users can monitor the virtual address space of a given
 workload as below. ::
 
     # cd /sys/kernel/mm/damon/admin/
-    # echo 1 > kdamonds/nr && echo 1 > kdamonds/0/contexts/nr
+    # echo 1 > kdamonds/nr_kdamonds && echo 1 > kdamonds/0/contexts/nr_contexts
     # echo vaddr > kdamonds/0/contexts/0/operations
-    # echo 1 > kdamonds/0/contexts/0/targets/nr
-    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid
+    # echo 1 > kdamonds/0/contexts/0/targets/nr_targets
+    # echo $(pidof <workload>) > kdamonds/0/contexts/0/targets/0/pid_target
     # echo on > kdamonds/0/state
 
 Files Hierarchy
@@ -366,12 +366,12 @@ memory rate becomes larger than 60%, or lower than 30%". ::
     # echo 1 > kdamonds/0/contexts/0/schemes/nr_schemes
     # cd kdamonds/0/contexts/0/schemes/0
     # # set the basic access pattern and the action
-    # echo 4096 > access_patterns/sz/min
-    # echo 8192 > access_patterns/sz/max
-    # echo 0 > access_patterns/nr_accesses/min
-    # echo 5 > access_patterns/nr_accesses/max
-    # echo 10 > access_patterns/age/min
-    # echo 20 > access_patterns/age/max
+    # echo 4096 > access_pattern/sz/min
+    # echo 8192 > access_pattern/sz/max
+    # echo 0 > access_pattern/nr_accesses/min
+    # echo 5 > access_pattern/nr_accesses/max
+    # echo 10 > access_pattern/age/min
+    # echo 20 > access_pattern/age/max
     # echo pageout > action
     # # set quotas
     # echo 10 > quotas/ms
-- 
2.35.2

