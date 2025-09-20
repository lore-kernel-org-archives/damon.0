Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36E27F198
	for <damon@lists.linux.dev>; Sat, 20 Sep 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758374918; cv=none; b=pcbfhh277devHjjX7XxsuMyaxdiK4wbtUo1y24AdHsdXSlMJPCX4qgBiXCknQ8JOMD6H6JX5qqh6qGwsHGyCgMJ+vgkPT6jr0N9N8ZxvKeusqyTN+5caoE4sCfPbqZw+WB1CZBRAwBe3s2jL2o2g8iMvraC0PE02WrzFENb0dcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758374918; c=relaxed/simple;
	bh=c4T5h8Lj+r5QHOJrfTGmZa4X38Mi6teWvFjOqLPEbvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxoDPpl+/pviNWuo7F+/u5gCgPn75hyinxnUnk3Lo9s8ZwpqgiC4PywVCD6MTfpjknazrtG47ZCBI2phtWpqiUZrSwPJ2fBxQiuq0ML5ltPv0Bh5L7r5Bo4v6K19nOFoxxUBpBkg5shYeSQ3GvPa7obNyb+6DvXy/81wB53s7zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnh6ousm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnh6ousm"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3016558b3a.0
        for <damon@lists.linux.dev>; Sat, 20 Sep 2025 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758374916; x=1758979716; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gjxouBjT5nmqga++V9b1ze7RKvPFTL21IXfIsCNqNqg=;
        b=Nnh6ousmlwhDZhdIB8cLnj1w1teGBQMucVGMLVsfstp4xY1YzJEdjCIoNvxF8TmtSo
         SQBB05ENgEWpDgApCzulzmBjcRswtX6fUk87Vl9u7yFbJF2wtEczpiuOal4VYVIPnqMM
         laraPSuMr+8TfvB1PFHdG7KeDb8E2xEDv+e9UpApSeYl1IEOdJWjwvQ596cQndgv7XPU
         XSNgzzWGWInzFBKujDuuSXOQZ/CgUz7jbQ7zekl+l6vo5WAbfuIexzyi+e8vcfICIijj
         IbbvpXNUL+oketgv7dRoxTlydfRcf5OkYoE+HsEP/yBkYN3xqq9sE2q0GF1J6kuAdGRz
         it4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758374916; x=1758979716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjxouBjT5nmqga++V9b1ze7RKvPFTL21IXfIsCNqNqg=;
        b=ZhZItTarknxh6eVo4zXoXU0CPYDvxgz+iSdlzkBatHyrNeLX2MgvsyU2EISalrJRDg
         gRmq1VIHCKjpKmXW+Qv5R5c09UE+Q0WAprRrp4bG7U+E5CmFWLOomKB3k36O4o3UXtWa
         nwIjG/3SPxQakpdxo6i+pfa9mx1N0xsQCBZw0GR++gUcycSTy5Bp4Egi+NwX6Ou0eDcG
         AhlrvDJVj+hKoHYU5D2W9eCx2p/sQO0oTNirukYBQA2wAbvycg+G0ns4zshMGUXtHo/A
         X2jA0o51K9uqmsMfBAtG0yLlTSe68p0y9eie+/y3HW7ZyoH+9DeO4DDyuVPCHn4+fOlB
         FdQw==
X-Gm-Message-State: AOJu0YxXwnrDpH4Scx1gFfcNUDn1iwc9KNnW+2sCncYATYi6G7H0kO+T
	55/YLFKmcX/2b9U0fJDi1twI3Ywv2+yNQP6RwmI3WdBU84ETuY+s0VuKXITV2w==
X-Gm-Gg: ASbGncv/Co3wKFM92RAFR3JELB+u6hxqTnzR/oTQcmQuwAD+HAQAfgPrjkDDmjKKmYe
	F22F4w3Fdo7+HBlC0ml3X0tKdl3sb4Dtd7LciDYKLG4SLi7BkHsJilVkgS1C/gP9DnHv5YHL7yl
	e2m9n25ocjmwsGMTWazr6eXc899o688MDTiZB3i8xIGJxoTlaugFjLGr+u/8m8COh10Jy0axVUk
	KUllnKUwpyq4mT/paUx/GUPQcLtWdx0qbwjEzdx5YVp53TimVgc1IWX5udm4QT16sJrrOXy/D4p
	mjrUI7Es7OFNmFGYKOzBYvFnyxeu6J69vUu1V6w8wP9CA7rnJ+qfg23KQp6mPx+5H8+mv882iFf
	zs7k8l5kJu0AaAK2lwK8UtomUNqvg1xBNX9mmPA==
X-Google-Smtp-Source: AGHT+IE3IUDImelMA1Pd199Dh7tuKfUZyU+6ZHuOXZm1pmSy0cEqS2FhGPr3AAovcBFC3q8C0kUEuw==
X-Received: by 2002:a05:6a00:3c91:b0:776:1f45:9044 with SMTP id d2e1a72fcca58-77e49f0742fmr7991411b3a.0.1758374915693;
        Sat, 20 Sep 2025 06:28:35 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:881f:6424:2c16:746a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe669a58sm8077093b3a.52.2025.09.20.06.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 06:28:35 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: akpm@linux-foundation.org,
	sj@kernel.org,
	akinobu.mita@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/sysfs: do not ignore callback's return value in damon_sysfs_damon_call()
Date: Sat, 20 Sep 2025 22:25:46 +0900
Message-ID: <20250920132546.5822-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callback return value is ignored in damon_sysfs_damon_call(), which
means that it is not possible to detect invalid user input when writing
commands such as 'commit' to /sys/kernel/mm/damon/admin/kdamonds/<K>/state.
Fix it.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Fixes: f64539dcdb87 ("mm/damon/sysfs: use damon_call() for update_schemes_stats")
Cc: <stable@vger.kernel.org> # v6.14.x
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index fe4e73d0ebbb..3ffe3a77b5db 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1627,12 +1627,14 @@ static int damon_sysfs_damon_call(int (*fn)(void *data),
 		struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_call_control call_control = {};
+	int err;
 
 	if (!kdamond->damon_ctx)
 		return -EINVAL;
 	call_control.fn = fn;
 	call_control.data = kdamond;
-	return damon_call(kdamond->damon_ctx, &call_control);
+	err = damon_call(kdamond->damon_ctx, &call_control);
+	return err ? err : call_control.return_code;
 }
 
 struct damon_sysfs_schemes_walk_data {
-- 
2.43.0

