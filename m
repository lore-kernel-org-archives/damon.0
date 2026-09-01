Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE94756DA
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260368; cv=none; b=d671ITZz0+YBZU4xeizHcIiUOBYAJjHLiF1uk3WUJb4zNK1L8WsMB1p00s39yrgvTtxFwvZ4T0etNmy0Vir5DDmgwuikPIFmPQSciJ+hqjdBs6LLENMJwmJX2JKwb26w7TftMY2Iepw1R/6apBwtUTEItJqxilzxir6hnFQdyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260368; c=relaxed/simple;
	bh=1yRKnNp+6dJmFDDAgwGqjE4D4lrDphKTw5p0Wo2NV7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9XHv/hQdO2DlMXpmhrQPzbSOtltDxoEo8Xd5OFOF8rqmPjzmCNPsZGIE6DLDGCWFAgGFjO6XOvna169YvYiSgpN/o94IIxYBgAq5rbJfu6Fnbg8REZGx/+SyTrkOp1HrwG0qXwtVz2znH/z3CcEvYbgb4Z5+v7ZskW/8rTHeSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZEBJRK+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZEBJRK+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d710632717so39781165ad.0
        for <damon@lists.linux.dev>; Tue, 01 Sep 2026 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788260366; x=1788865166; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cX7EjhloMvh87ibhYzHTwR5IMqnRMYO6qnjKtDs5XDY=;
        b=PZEBJRK+o4zXxhR2hz5vrHrT+ieATzpzTKUg6P0XrNPwHMuVtp4uQ/gdnSzCKDIclT
         TQl0PCF8/6Nkd4X5bZztSBSc68Yzw9nswwwPKkfAstaSgRjq5ZIaRNznQgap2KtwVzR5
         jWnYqPZNGK5Wwrzpi6y+t0HLVpf2mFSMn0XN0zG2lYnDt5NW9jRPIZw/w0+ftxnnEh0P
         gNU1ntebt4kEuVUN098BT8sA+epF2kNpvJZbykIMSteR/x7aVEmmzOTxCWhIAVB+cmuM
         IXXxsyCws2osaLnMeKOfDPhF+4UKtmmQ6tLbryMAjiT5JZe26J6tEhhAqRbrlKSfS2nW
         MaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788260366; x=1788865166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cX7EjhloMvh87ibhYzHTwR5IMqnRMYO6qnjKtDs5XDY=;
        b=kOY3HGp0S+XZYX4tZ9ACyWRQ0yauYx3UuC5MvxxztqrRuAGJuizHyP0Q6LVkcvSDXT
         jowir4KkcJrVIp0FyVn+ZdomDJmIW5aLzRuVmeeWgPLYoZyWviXYcCa2WWICTAvbm2Pu
         SaNtDb6jPpqtGDT/D1rUSBgN4poJ1YnAzUo+pfTXNh6QOgprLCPlhyhrv28HKD2aQGxI
         i4nZ3Gvo6gCs4X6hyLoNjXAaBLvLsDXlQFUwJWkp1mj+sc33DYPMAvMCw6tChDmtB6LS
         aCeVYBAjrFxkfHWdTCGoVir3wCVtMRCbFDpeWhBUuN5cgF/r39UZXH2I/J+n9IRAjU0J
         goFQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9N1MbLEHiG6H/Wlp8hrCvq8ZmWD2fR+HiCs1nXtfw5eMfncy4vgEDJyziYFHKhR0rL0G73g==@lists.linux.dev
X-Gm-Message-State: AFuF++lcLIz251sodmZ7S0K1LRiZ8yo/vfFUbYHqPtaGJ7749fVFhteJ
	T4hrG++sinDDSWnrKuWBACLD4G8g2OY0CWBliuaz3GZMuA7rTu1cd3c4yJpwsw==
X-Gm-Gg: AYBFou04pechDL8sLKXn9fG7EWmt2JM5KOire0Lsq8qd7we0K18MblSOFJQo355R6AR
	0CNI1DOTHlA5mpNaxtqCohatEQVa5m4eb3E3YiznQOL9VTeAeTOhUVfTTbikvWbd8rBHgrFJbHK
	KakfaZYVsJM2hRzkWgreWQbqZi6OV0GEH9m+9BsgGTNvT2l5zpcQh2KIOkwpZdXLLP/wrpTyxFH
	6N0ZjVdos9mkY6Bts0ozOqTgchIz+HUoL/Di+URp3GHd/i8A4cXar0+joFBs9WuRlJSSgBQpi/6
	qzWL1td2MxmNvvHUNopbxk1QBls1zT84h3dN4AFNWjgWGZ4elrB+nGoOH9C0EiT6E+wY21YzZrI
	68zsMChC/ULQRDomc6VY64ltvieAOSso2f4l8No3uJ6X+b4yS87ltl0eM3neuTehfMyDk3clQsv
	gdcCiyiNAX/0rZws+SBeVRPJzP1P31lbyJyTKfRotWUkAJObD0U38ibQalWhOkUJBiqQlNZJxZ/
	Ehh
X-Received: by 2002:a17:903:458b:b0:2d9:51bd:534f with SMTP id d9443c01a7336-2d951bd58e9mr63941605ad.10.1788260366011;
        Tue, 01 Sep 2026 03:59:26 -0700 (PDT)
Received: from celestia ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d9458299aasm20706695ad.43.2026.09.01.03.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:59:25 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: always return false when esz is zero
Date: Tue,  1 Sep 2026 18:59:25 +0800
Message-ID: <20260901105925.106186-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After setting goal_tuner to 'temporal', if the goal is achieved,
quota->esz will be set to zero.  In this case, damos_quota_is_full()
will always return true, even if no regions have been tried at all.
This causes qt_exceeds to increase unexpectedly.

Fix it by always returning false when quota->esz is zero.

Fixes: c7ec7d5f6b3d ("mm/damon/core: handle <min_region_sz remaining quota as empty")
Cc: <stable@vger.kernel.org> # v7.2.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..53cf32f1d515 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2560,6 +2560,8 @@ static bool damos_quota_is_full(struct damos_quota *quota,
 {
 	if (!damos_quota_is_set(quota))
 		return false;
+	if (!quota->esz)
+		return false;
 	if (quota->charged_sz >= quota->esz)
 		return true;
 	/*
-- 
2.55.0

