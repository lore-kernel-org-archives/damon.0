Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B9C1DDC1B
	for <damon@lists.linux.dev>; Mon, 11 Aug 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898404; cv=none; b=JXUxHe7Vu8FEKhpshe+f8hsd49d1JyqVcojHbhx/R3iBp4zfcwJyOCwbj5O6mXxv77QwdCTkzpD/fdBL14AEf52DoeVZstsuUDRz/lQZAnqqbh4CuP4xhMJVlTLlJ/9NcCZFdwVvJA2Ij8VEIG5QXAaqXGRLlhznlzGAf8f1w/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898404; c=relaxed/simple;
	bh=YgC/2G0niXRN0aUoGD1rGOW8Ymnu0zs88oHuN0rXtDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KqdjA4hzYlpQR15E8a4X8BOQiWxzbYN9by/U/1rrPlmnEq5KLDUvEN0tq+Nq3X0H6P1mZXWdyR21oTn2lt++PE1b9d8t31wTUc4DoNe2jr4PE9rsb9CKzNpf9zAMu7q7gSxV1oemgFK6CFN7UwGIEzSRGZUcAvxazRKm90cqwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MunvBgJ1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MunvBgJ1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bd050184bso5375073b3a.2
        for <damon@lists.linux.dev>; Mon, 11 Aug 2025 00:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754898401; x=1755503201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1sOLl+/bGyXe3VgGqoLX7QBuLkZiKLh8McGFwjN9WQ=;
        b=MunvBgJ18Ks5CUwbOTAkNAEUE48posy2cpDGXBNrbKVzj8QtQeX8vRhX5zEKcIL7Rm
         PUTy4zEMsKcTNeSIJ2qzmp9TVgMYFqvpZc9YnPPg0NZjOo0DVy+Tr5IO5CPX/ZCRd0zn
         wm9kCJxTo5O2yWIXm6ZcQcvRcMczR8m4Tc7l281OUQ0/c6whsNHFz/KkR9g3nweTDT7v
         CyHcRfMNN81ScUPbKqWvBMD06vyOYGjCUAkSsuaip8SOnqGri9l6dRt3zWbC5Ai/bVX3
         66ic/C8Usww0Fk2JGFcKLaVL0regND41bdkSQi11Q9uMlcWenJYLd9KuMCJE5J2ql3Bp
         DnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898401; x=1755503201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1sOLl+/bGyXe3VgGqoLX7QBuLkZiKLh8McGFwjN9WQ=;
        b=h3pG7IJVvhFVuwtQTCG45EBjTQJHVwO1GFPrvlnzUjeUJv70L35HL6q+ZDFynr2NE1
         uWmlOnC5HLdA3+Le63vdFxwKCZAtfA9y6UGxAUbsO0PQuoaNqJk0d9x74S0jaqEp54X7
         O/0FGbqQVSu5aQoatmNcmN5bTZ6M8RBt1qxySe4vp4npwPyQoLTX5iE4EQ/XHixvrEFY
         QlFx/nJJlLPxUi6kVl5a2nXzjPauHpva3UQEb8Y5MJpR3sIrzQV5Ucs3GaOH5JolX2RX
         X4BKTb8zfvD4v+y8FlmMYHv9Mo5wxn9TH24UomvyCz7VJ1Lcv3lX+k/bLony7boGicwU
         dgfQ==
X-Gm-Message-State: AOJu0Yy/B152vECXQ2x3jg0KLmiXsQokPHL9izu3s3Wdbi1xyNPf+tmj
	UIfgjzz6Dv8bJRykalJRqgCyBpxh2mDAp6a3zmfsAMPIakWyEVZpFCNF7VwA4w==
X-Gm-Gg: ASbGncuBwR8F2yrdba6zsPbeyjZI8xMMN0CFQMaogup3PwcKmo7CxbtQAYgIUL3cFim
	2MlOzaHA06q00N/TWwiQKuyFyzqR30eVgPJNtvgeObeZQod/ugnnE/QbEtl0gg6yltyEIW4xloN
	/ncJhiMokTrJVyrA+bNEfsqiQteIDmn7VN0v+BjrcRfSjAp5+M2uMANfqUm4KuREnNfmHGMVBps
	AA/oRnGCTIAP/z3QF7rvusuCcmx5GJl6lKnmuQ19NED4G6E+dB2Nd8nmG37t5nGxwHGeG1WZZLC
	ngILoH7kkuzcMV/A1KNlfD98LgHHMQ6dWETZZLFxuuMDUki03vFLHzVsoa+xGZHgqRB44MpBydK
	gG1rghvFuSgLxrc9esdbCFdQfCgxobniO70aXdQ==
X-Google-Smtp-Source: AGHT+IF65A5vrcz1kVTGFXEdxP3XT0NUbshIAYu51z+qmvwU/7D82/k5XJJA9rZQkTpZm+GvVDEcXQ==
X-Received: by 2002:a05:6a20:2450:b0:240:1d9a:4c95 with SMTP id adf61e73a8af0-24054ffbc27mr18641634637.2.1754898401280;
        Mon, 11 Aug 2025 00:46:41 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:e4b6:b3f0:e05a:8499])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbce56sm26179329b3a.82.2025.08.11.00.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:46:40 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: damon@lists.linux.dev
Cc: akinobu.mita@gmail.com
Subject: [PATCH] mm/damon/core: do not merge regions when the number of regions is small
Date: Mon, 11 Aug 2025 16:46:12 +0900
Message-ID: <20250811074612.89804-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change prevents adaptive region merging when the total number of
regions is less than the minimum number of regions setting.

Even in such cases, the kdamond_merge_regions() function must proceed by
setting the upper limit of the region size to zero to prevent any actual
region merging, since it is responsible for updating the region ages rather
than just merging regions.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/damon/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 52a48c9316bc..34f1844094cf 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2247,9 +2247,15 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 				  unsigned long sz_limit)
 {
 	struct damon_target *t;
-	unsigned int nr_regions;
+	unsigned int nr_regions = 0;
 	unsigned int max_thres;
 
+	damon_for_each_target(t, c)
+		nr_regions += damon_nr_regions(t);
+
+	if (nr_regions < c->attrs.min_nr_regions)
+		sz_limit = 0;
+
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
 	do {
-- 
2.43.0

