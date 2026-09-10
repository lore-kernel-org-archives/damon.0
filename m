Received: from mail-yx2-f10.google.com (mail-yx2-f10.google.com [74.125.224.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E395476CA
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060613; cv=none; b=EL8IwRrqtEw2SWFrkxq62AwF7be6t3ys108MwVOtQw/EO4aLmUz25G6KEa0MYIx35xZ2wdrhP9lrGkynI8a/lACQtZJadBb7jZABpxLpVk886bL87lrQwsRA4mU6k7cu0+0+fGxYgrTUC9D0o1McDHfizdYgWt2i+qLlgDe2Ias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060613; c=relaxed/simple;
	bh=YZfMs3Go3WSABp0x0N8hUDVtHdzAJjFeURZfcGTcgG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L478t/tKKCBz8jBDp0WCw4X+gZssVM0wyy0PFlLKngvkbjClRoKdNqLBiv9OQ4+37DKcBQm78g5KnQ6r9NNj9KiaJTXLplfCrzf3403/nPbuzTgMCuq3gxvFcFT32600OLx6Po7OPIso9sjmHizmJhomHVyXreizhZjPc2YCjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rbavHbyO; arc=none smtp.client-ip=74.125.224.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbavHbyO"
Received: by mail-yx2-f10.google.com with SMTP id 956f58d0204a3-66c711552cbso2234031d50.1
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060592; x=1789665392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yQvOpBVSB7EFzma+xoAdOHr/Eyr0ApRMjSY0dpxZAoA=;
        b=rbavHbyO+7mSsBuvmvtixAH0GPkcPohY3Z+A7iAgfUnZZVus+MkchT4rll796fU56H
         gKt8foV6lBSz/2FRJNQbLaYwfmjnmd24bGco3ocAF1gEDc/ybGDH4frpTskPiqcQbNgu
         m3zwgKh4vmO15fJ6roOUg3TGo+Zm1owdFmRQQvKCDkdw771NAXmTdCSVpnF/+Pi6A21/
         Wfh8LN4Dhkd4XMeCwa4opj/qAWQtaQCfgeHrV1WnaaQyKzMm9TRaf9Asws43w7KqKPzx
         7LMtFfj7szWZt7zaFzk4QAI9Ljnq4iJbX9EKZIq34F9yNrXHd7tYt8ltqrGFH2MEdWWu
         +N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060592; x=1789665392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yQvOpBVSB7EFzma+xoAdOHr/Eyr0ApRMjSY0dpxZAoA=;
        b=lgoQXpKOtXDQ/SOr4obx/7UTgDG7XKvvWc3F3/g4kumT8BItqo9vD89ovLZrFn7UQ/
         ZK/TsYXPz49syp3U3mGRfPZuJhIqHPhVi8U0phxzfm7kIRSy5iTYKQVUZVBezA/bVX/g
         rdyekGoz1ggvfVRcqYAZ+oNae8wUp+O/b5Z4ZcNp6yNwqt3oa8B5NxyMTdMOkurf1KKg
         0B9NIyBs68T3GJMu3GEnXbDBHPy5GL69dY6RKa++MY7zbBpZcN0uMdbGaOGK8N4Mbb1I
         r7u8zPb22f0Dbl6T7r4dqjzppv/Kzbtxc+kSulW6wKNkhnub4aiuTeAl6uBjpPgAEUi7
         jo0A==
X-Forwarded-Encrypted: i=1; AKwUvBxWmzPH7hp3XKFyPaUau0/hB4b6O6iaVGfRjG7isufUJAn28cicCucxxsPhVWQamZBMsAzxLQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n4JnExoUrh+g8KMuvqK6uEtEtD0KeqzZuPH4bQClkXd5Nvsp7j
	EO7ifeMsAJHYohzoteA9z1qKoTQ6tvdCIu9UMaFI239/yoEbsWzTMAo=
X-Gm-Gg: AYBFou0b/T/vPqaWhciPebCJtBzdwLjL7YbFXnIxdJM+W9khnJcn1BZD0WU4e8PSmJq
	1e2MBKBpds6cVa7eowLcTT7WGdOja1JIBdpkhOCsf7Tw7y4jeH583cJwxDQ7iI9aisKOD2tq8ew
	Kn+Eexg1WEPdAlA57YqyxrhNqP8NsBOmhC61VJ3S37uraonDLrDTJqf9+HTqU+V8WMGrRFrjyAf
	ZOXP8oFFxyEN2mfd641oSM0g6rGwDhtzAyqgwT039yIaXWlyed1WMVZP9ZV1G02wlHdgieBfIxs
	FjAev0lfl+AspXEV7eLPRMyf3kZr055pIpLM7sKGBPtqElzYX36if9gJVn/bOZVt1wcUtysqu5F
	YUJOh0NAMZKT4w9km0wK7JSvjurJCuqjZyRQIEo9wJVvUBZpb/lpILU6Q52YJ/Dw3xRuVeie+HD
	8+7O61UjHO0cTdVd4Mj6Tad8FookV5tDUCKwT5ZVL3kHZdWa5f/H4sXiIkgZzG/lgFTXwWZTkUG
	ZH/FMSb0lR2ExETyD1UktVy6VzgCNZHjR+sjwG34m6LB/kf/g==
X-Received: by 2002:a05:690c:e289:20b0:858:41d4:c28 with SMTP id 00721157ae682-884afc19817mr1025287b3.8.1789060592200;
        Thu, 10 Sep 2026 10:16:32 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8848608617fsm2387337b3.9.2026.09.10.10.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:16:31 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net
Subject: [RFC PATCH v2 2/9] mm/damon/core: read the CPU number with preemption disabled
Date: Thu, 10 Sep 2026 10:16:16 -0700
Message-ID: <20260910171623.6638-3-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910171623.6638-1-ravis.opensrc@gmail.com>
References: <20260910171623.6638-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_report_page_fault() runs in fault context, which is preemptible, so
reading the CPU number there triggers a "using smp_processor_id() in
preemptible" report.

Read it with preemption disabled, and keep it disabled across the report
so the recorded CPU stays consistent with the per-CPU ring the report is
queued to, which is selected the same way.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 5fdb5922edb78..991ddb9a09414 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2514,7 +2514,6 @@ void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
 	struct damon_access_report access_report = {
 		.vaddr = vmf->address,
 		.size = 1,	/* todo: set appripriately */
-		.cpu = smp_processor_id(),
 		.tid = task_pid_vnr(current),
 		.is_write = vmf->flags & FAULT_FLAG_WRITE,
 	};
@@ -2524,7 +2523,15 @@ void damon_report_page_fault(struct vm_fault *vmf, bool huge_pmd)
 	else
 		access_report.paddr = PFN_PHYS(pte_pfn(vmf->orig_pte));
 
+	/*
+	 * This runs in fault context, which is preemptible, so the CPU number
+	 * is read with preemption disabled.  Holding it across the report also
+	 * keeps the recorded CPU consistent with the per-CPU ring the report is
+	 * queued to, which damon_report_access() selects the same way.
+	 */
+	access_report.cpu = get_cpu();
 	damon_report_access(&access_report);
+	put_cpu();
 }
 #endif
 
-- 
2.43.0

