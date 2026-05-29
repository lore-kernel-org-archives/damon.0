Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1A3FF1B4
	for <damon@lists.linux.dev>; Fri, 29 May 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073828; cv=none; b=Kir3wT2jfM5zkmGcq6b9FgFSPPrhADVvb9sseivX3mTqcvyObJLLLhvhQf2XTXqmi8+W+rYenHjml0kKQC55RUEwhpoTyrDsoN/Opa6FAbfE5JKHf/KuOavxjardZSFIud5C5Wcco9o5eh0c/Rk9oF41hp7FqZIadQnnfGlivRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073828; c=relaxed/simple;
	bh=MZuP9HdtIsahZDma/nE0553s75DZEcFis7HHFW5CR1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZvrSJKdZC0POkULPPArKC7c7s+e98dU13s5/1ZV7eoH1RJxVMBk5+pMJ/s+u5w0xWhfjaZeigYjpBAUJh1ngVu0Q9JcHvqzIR8lM0VVFEu/oVIyijrGm/6453nThqA+d4ZdVN3G6h7/8LlZFQdDAb5qIUoYkGOWu/bz+XnNTMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHhOLnIU; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHhOLnIU"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7e61e25199bso2729827a34.1
        for <damon@lists.linux.dev>; Fri, 29 May 2026 09:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780073826; x=1780678626; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOfd8pSjBXyzWHpK5lKV8S/iJy+QOz+9xXLc+9tqa5o=;
        b=bHhOLnIU2lbSUhAGTmL6LvhIHv3Fm2Dliz4qCshmrRHnCFmG1i9Q1e++0RsKv2wZa0
         TXGs0X+/0/1qSj+AoVCdL3d8vjje/zhRzUZoc1UxI5+VWycV7GKsEPYJabrf9B4aLK0J
         rUFqe63HdnJ/LRvrqAcuUrkgfaj+oAcshKvNL1jjrHJx8oFkEEYwIol0jh/IOS96AZN7
         JyA0upm7oCejh8SJUN2lA7lfib/GSxqDTq2CDzZEGN8h/8Fj4Xo82IG1R6XsdoxyfciG
         t2nAcDA38f+ggOltWGVJ1LJMcqiv+Jc3wC2uBFChXf1FZwhAxS8SLOcA+kD0KkICW1Ly
         QmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073826; x=1780678626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aOfd8pSjBXyzWHpK5lKV8S/iJy+QOz+9xXLc+9tqa5o=;
        b=I30f0duRFIHi0W1wR3NOu5XODmBNsB5fIGVII7VSM0fDxu55yjJuDLsQm/SJKXUsC2
         KDg+xEEHiA2eTYNoLY0RvdJuopFPy3H9RfpaBn8IBllecnpd44kR2HTlA/xBBkad+Icn
         9lY6YEqb9LUEV8VY3PEQ4oDZHcMyvTY1fL2GA6MVcKKHIXTK6BTflDLMNMKP82w9/ga0
         wnIhsHEhSARL9GBEUFL1FbOJP5As/apWxacAum65K11ismY+wXyDMH0/v8Sr5IijN2e0
         O/3+/9Or3ryIFqofQ2oxY/cCF7CLfhF+rU4iaWgL75TqRLPgHV6Kt7t4UJYBoVW1hvC+
         XWJA==
X-Forwarded-Encrypted: i=1; AFNElJ/oUkbhygs/PJIeAUZPprk6Dvup54mwf01snG+LoB9kvTl3BMV39qNbGvQTaSicBIlf9/n4HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcmC3hRwQfxUTp6EoQ8ccVVunmWeVItyDtDcz3mOmAwsIS8lBv
	0uEAAYiB7i98MTRMGUvbv1gZoXBnOz9FCjCubz2CfodPOB9/MWq3e3Y=
X-Gm-Gg: Acq92OGyWZk/K9G83ug7uvkXWKtx2DKZABUmktE1HzEj9uUIpsAudsmAlxK8Vd84hes
	QTeYXMkSqJdStcmefNLVN6AvgfD8qGfukJlsPdVOVEk5Okz1o1fA3+iFvASwdf/YiOqIEEPl5rL
	Z1qsQx8iXHogbo2Z7onPKLoazxIZXaDGbycvdoIRkLEfsEj12SJaOUL2ugyajst1ZKwVSohiXZi
	ZnbNq61kPR44ephasAEkLxdv5J1DLOeIzSawW3vPFeXmbrR3baalZarluTNm5F9bz7jT0ToNKZg
	FNbgYnDO5G1BpDWNgGSWdi62LKJ+5MmF8wcnx5YjW9Hg358bIWfnDqN02BfI02RomRbwd0kfz0y
	iYR66Yufxwy13LGyM/Ofw00n0KzZlUMqAl8DpAHgwW0o0lD4xJAJZ+toeo/tdkggz3HNJkfhUhr
	W02/en/BPozlLdxIrSxIXIiYdhdIcHfp0C6ACYFY+wrJfV4cEvYEFg+KrvJGjcW+yX5rpCPszCU
	MgiDy3T7Df71jP12O8eO0E=
X-Received: by 2002:a05:6830:83a1:b0:7e5:f831:508f with SMTP id 46e09a7af769-7e6a1dc5519mr438211a34.15.1780073825697;
        Fri, 29 May 2026 09:57:05 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695d176dasm1812846a34.16.2026.05.29.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 09:57:04 -0700 (PDT)
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
	ravis.opensrc@gmail.com
Subject: [RFC PATCH 3/6] mm/damon/sysfs: install perf_events on apply
Date: Fri, 29 May 2026 09:56:37 -0700
Message-ID: <20260529165640.820-4-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529165640.820-1-ravis.opensrc@gmail.com>
References: <20260529165640.820-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call damon_sysfs_add_perf_events() from damon_sysfs_apply_inputs() so
events configured under sample/perf_events/ get attached to the
damon_ctx when the kdamond starts.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 9f71871a249d8..bc4a931fe3f0a 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2092,6 +2092,9 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		return err;
 	err = damon_sysfs_set_sample_control(&ctx->sample_control,
 			sys_ctx->attrs->sample);
+	if (err)
+		return err;
+	err = damon_sysfs_add_perf_events(ctx, sys_ctx->attrs->sample);
 	if (err)
 		return err;
 	err = damon_sysfs_add_targets(ctx, sys_ctx->targets);
-- 
2.43.0

