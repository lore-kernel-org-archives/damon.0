Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0093F8704
	for <damon@lists.linux.dev>; Wed,  8 Jul 2026 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497686; cv=none; b=E0O3yKVprSHvPXntx8T/T0/b2ih7Sq2wy/huk0XBun5tljMLM7YpkJvsMLhi7GLNq6+odFeqMRnyqjjHt4Gw9+5YFUaaRuMH2Ip0FBTbB8lDH65rcDGdPJiP/H+vsxwq271tdj11JUiC7E7o7dsSaJMrETBODXpl1GLrwm0wlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497686; c=relaxed/simple;
	bh=oCj/Y9HazWtdC/Gpu4wu+TTA3spncCFeU6du1BuqbCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9RvJxF1sIG7d/PpYuygpe9Zsu1Iq//ycZ7KRm8f/QImI19PXBuMm9hJJAF2aD/6lpypuaTTLSvDCJyRw13PVCFv155JA/ltZT0TUEuWpJXLhygM7p1GWFJZh+bGi4+M4yx3C4EJ7ixFXR31nt0SkFtSP5B/9UN8ZMJQoxqVM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDFW15pM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDFW15pM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc6dd436c6so4136975ad.2
        for <damon@lists.linux.dev>; Wed, 08 Jul 2026 01:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783497682; x=1784102482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSvkn80MrAt5cl0VSMEKjTET3Rwq+Bm6+Heg6Nd7va8=;
        b=JDFW15pMGbIQStPAIMzTIvaRcBQ0jOT7NgUNkE1Xv7LeONufXERwvugjyIlzF7SZW/
         0KC3coSQ9NbAPzqdzOEi4TR49QxhqL9DyWZUz4p0qsVDu+L666E1XN0LiF5m6vi4c7SB
         kR872+WvGs4v/1i6QvvKP+IgtXABsnD6FZggCkF/BlBYYBhYlfckqSKK9BC/juiQZ9M7
         O3EcqNO46BQJqOE5ckAIai6V8rTqRj8Z5ynGyqTSK8BaN5Bc5Wa2mH+OagAzRDCgPMtO
         dUbV6UFANBoOIRu2w3XaO66yHBU5veXv7C4FUl47gFm099uIppV9ORGT+Awbsi30dhWq
         TNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497682; x=1784102482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSvkn80MrAt5cl0VSMEKjTET3Rwq+Bm6+Heg6Nd7va8=;
        b=jNn8iWKorQEQfxDBpFyXW8djTPEK//C6c72tAdXCP3R5ubj3mjdtcchdNtTVZ6eS2X
         noxzvUSft/SOHHlvUtxNxMm4d3xkoT6Y51ZaMjyMsRCo7+olpFFIDfSgTpq6TeyeIytx
         6aLk/rL6Cz/uodsOwDdgGyggXdZ0a8O1paf+8ASmHapHbh32/iEt5QN8ajiLhseinTSc
         CLPqmdlmRg+rc9jwxIWD8RiYjL9tQFfeXkLyALDVGLaecMn//NsBivA5cfOSbOWSLA25
         87ffk/AcYPfyLIep+w9X2mAVH79XLGCgDdHyO03DA2XeMlOfKhj1iK624TfHaeW9gCFL
         DayA==
X-Forwarded-Encrypted: i=1; AHgh+RpqJ3xQBDiroG40D8OxlCJ3CI7+8dTZKDcHRI5TfNZH1xIV9AUcqPMNzWxdm+jbbZ/fuszsZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMj33IZsasBE7IJIBC8ZthCfz1xbU5r+y6gZwkS2cgIouRyTKF
	dEuodKRizNvt8nlDp7h/moCKFljGdcUlshcjWyu4UGe0ESIkdl1bFrYp
X-Gm-Gg: AfdE7ck1A5MYRenNy1GtMhcppAOV3kqVGpv875TasaO3J1jpltwy75s7PZMbDDrG847
	pBjUVFTf3ynqUwt48TTPEleOJR+aSW3al1PiYSCBfBmNEaN79iOAc6cgeD6LpltUajBDHSEVxWJ
	fkNDthb+KEUWnvjUrKe3AEMGCIoAPcvbyke9deGvnVSFlOAtzazDoCy6QURwo3nU5H1/EJ5BGEm
	WAJSMbynhdvGGLtMMh7x17GyR/QKodYWY6MCWlAcMHyv9wAcfQuImEN3awKvmwhkbtwHetecubQ
	7jb8XNg5kPhFfcdWGHT7PRAPFcX+F9sLDkIadiE7+0vfcxHzqv2CwAslJTiUJrH8fapxTAoyyCR
	/quvpLhML2/veKTv4izooF5zeGoNTLP/1tSzriXqW0wFGcXPVzSAdQ9FKXIrhgeg2Ry4x4YfRex
	CcXXt2KQRqHQUbzg==
X-Received: by 2002:a17:903:1247:b0:2c9:c952:6e9 with SMTP id d9443c01a7336-2ccea373186mr15894145ad.2.1783497681729;
        Wed, 08 Jul 2026 01:01:21 -0700 (PDT)
Received: from lgs.. ([152.32.214.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf77e4sm23942245ad.22.2026.07.08.01.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:01:21 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] mm/damon/sysfs-schemes: fix tried_regions setup failure cleanup
Date: Wed,  8 Jul 2026 16:01:07 +0800
Message-ID: <20260708080107.727043-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_scheme_add_dirs() sets up the tried_regions directory after
the stats directory has already been created.

If damon_sysfs_scheme_set_tried_regions() fails, scheme->tried_regions
has not been assigned. The error path nevertheless jumps to
put_tried_regions_out and dereferences scheme->tried_regions while
trying to put its kobject.

This can dereference uninitialized memory because struct
damon_sysfs_scheme is allocated with kmalloc-style allocation and
scheme->tried_regions is only assigned after tried_regions setup
succeeds.

On tried_regions setup failure, start cleanup from the last successfully
created directory, stats, instead of trying to put tried_regions.

Fixes: 5181b75f438d ("mm/damon/sysfs-schemes: implement schemes/tried_regions directory")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 mm/damon/sysfs-schemes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 329cfd0bbe9f..0668a0e53971 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2516,12 +2516,12 @@ static int damon_sysfs_scheme_add_dirs(struct damon_sysfs_scheme *scheme)
 		goto put_filters_watermarks_quotas_access_pattern_out;
 	err = damon_sysfs_scheme_set_tried_regions(scheme);
 	if (err)
-		goto put_tried_regions_out;
+		goto put_stats_out;
 	return 0;
 
-put_tried_regions_out:
-	kobject_put(&scheme->tried_regions->kobj);
-	scheme->tried_regions = NULL;
+put_stats_out:
+	kobject_put(&scheme->stats->kobj);
+	scheme->stats = NULL;
 put_filters_watermarks_quotas_access_pattern_out:
 	kobject_put(&scheme->ops_filters->kobj);
 	scheme->ops_filters = NULL;
-- 
2.43.0

