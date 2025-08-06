Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7C289808
	for <damon@lists.linux.dev>; Wed,  6 Aug 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754498612; cv=none; b=JPncNV7iOLN3KgztRdCjys1WO9jOfDy+41wJ8pqZhtASI6s+zElq+qRzM1Rme9rWKB/eUeXfLxq3/PEeaTcuHTUetNGOWzaT3Rw5NJzK5YhKinUQornJstc5Xd+aQTNOUeGZn0YxelkVquyydgZCXo6BCdEPqx408sMeak1nLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754498612; c=relaxed/simple;
	bh=kSmjvSRxf/vc8KCM0gHJNuyEzYMbeq8aru0dlXWOIng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcwnbhSiZYpYOrsLgnvCfrcdTanid88obk9VMIq8Hj1S2b2cHwTvnVGdh1PJCNVo+8r1QTQTGc4pf9VLnQny18OYeoBPo/NRAyY8m9I+WV7GR+VdiCIaz8aY02IZIq0J4UkxcZb4+NpFlpG7o2Scb9dT3FV53mjJP8k5oroC0FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JupjOv0S; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JupjOv0S"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8da1fd7b6bso95621276.2
        for <damon@lists.linux.dev>; Wed, 06 Aug 2025 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754498609; x=1755103409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SfMoFOux/IwUTu8sZ3bFuS6UukRdux0VsKTWxNGPjeY=;
        b=JupjOv0SUOmn7xG4TLDH91VYKvhA1YDBxvEphsopKF6I49FCCUg6KZWFvtM52EkXrS
         mc6nr3OtOZWaK9vFqphR0F3MI5UYIWbeRhjss2vaabweaydAQMy0UmavjGyHD5HDYdNJ
         qqRDa70jDESHcOUG4mDJVJQGvEzCYlirgMVTmlXtcG1TREIK6tNNAfyYu9Mh2YdOkViG
         /bz1/hJDfKUFKGk506CzjhhYUko7bZRd4Nytu1E64pEsbJIc6tBTZ7gpgsMAb5/LCf1Y
         dLphbJdK7Ts1T545qvdHf8izUYAbZkHwTm6dDgM/Hxlgt/ats7xFZILwTHQ6TF6upf/6
         ZRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754498609; x=1755103409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfMoFOux/IwUTu8sZ3bFuS6UukRdux0VsKTWxNGPjeY=;
        b=PvLaTHi3mzkKdg6ofoBy3iKmre++hx2OWM6OFBaG9wAVva6sHoY0F11afSAZprl/Ct
         33YwX1bnFzRRZqzhdxYQLMAp7+PzVgEl7xTNiTEPcM3MRS/W3tUycLHqz+iDxFLG7pt2
         GbxwsnJ2MLP2tx0gWFU6zanZB1INAUcyb50KJP5+n/IEOvpV9KlhP89CBsBrkwet8xCj
         PQod+epUUOVFBbFqt9usXLGT1/lSFQ19zytiUkZqydmjUC5vbrnj1i4m6PO2Fk1hOjDJ
         EYQHnaDjqkVnSeFkgEGXdfyhDZONjx2p9pDKdsRMrrEMcxou5O0X/oRaVPdaR0l4sQdS
         vqbA==
X-Gm-Message-State: AOJu0YxS04qhef/kTKp0zU4S8ZIUwtvLoMS/bWAoQPGOJad+k5AvnWVv
	6nNMNb6OVftEgeJ/9WxbUSP+2QU1pwmeBCBW5ryVy3ZNbP/FRivcmQ2DcMQ2Pg==
X-Gm-Gg: ASbGncsINHT9yBtKd3fT0reV089D+2HaNhx2B8Lx75tm6I2IpDOgtyc4aYc7N04tbPS
	ssDWpuAgdDnprEiITBeGFGKQddWV4B9w5WtPEKBrXUjLW+9t4/G2F2BWpX/P+tDD+xvVYVlg3b5
	q/Yu0vPamU0ASTyXJHxQRrJ3MXh3j6KaPslEbGVsuZxN+lFQlfgzWyF3jrAgTM0myKTW/D8PN3v
	ZJdsMkZ/wbDfyOAw04ZgIcnAaT/iP6Z5XFitQta4kltht/stRWVUe6ucwZaQkn2XoVXMWr/HPQS
	HgwKqrHPAArZ3joezm/F0eTaoyvVoYIXtn3kONI6Dij46hvHOtExbSYdfVZha9/W5hjmaghn6Du
	NxH4+F9Si05oc27lOfT0WR/OYkHH85+8xWJjR0hhfR1Y=
X-Google-Smtp-Source: AGHT+IHot5TzlAaP22OS8ozlOyxx1qWLdYvYF4U5lEEd5hmBmhG1Y0KHe5Op8KEKdPn4Q6MVr9HmjQ==
X-Received: by 2002:a05:6902:4a09:b0:e8d:7b84:cb46 with SMTP id 3f1490d57ef6-e902888c89fmr4326980276.32.1754498609332;
        Wed, 06 Aug 2025 09:43:29 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:f6a5:255b:e469:fba9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd3713e9fsm5596151276.5.2025.08.06.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:43:28 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijantabatab@micron.com>,
	Bijan Tabatabai <bijan311@gmail.com>
Subject: [PATCH] mm/damon/core: skip needless update of next_{aggregation,ops_update}_sis
Date: Wed,  6 Aug 2025 11:43:16 -0500
Message-ID: <20250806164316.5728-1-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

In damon_set_attrs(), ctx->next_{aggregation,ops_update}_sis would be
reset, even if the sample interval, aggregation interval, or ops update
interval were not changed. If damon_set_attrs() is called relatively
frequently, such as by frequent "commit" operations, aggregation and ops
update operations could be needlessly delayed.

This patch avoids this by only updating next_{aggregation,ops_update}_sis
if the relevant intervals were changed.

Cc: Bijan Tabatabai <bijan311@gmail.com>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
This patch came from discussions in [1].

[1] https://lore.kernel.org/all/20250805162022.4920-1-bijan311@gmail.com/
---
 mm/damon/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6a2fe1f2c952..1c3d8b92257c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -693,6 +693,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	unsigned long sample_interval = attrs->sample_interval ?
 		attrs->sample_interval : 1;
 	struct damos *s;
+	bool sample_interval_changed = ctx->attrs.sample_interval !=
+		attrs->sample_interval;
+	bool aggr_interval_changed = ctx->attrs.aggr_interval !=
+		attrs->aggr_interval;
+	bool ops_update_interval_changed = ctx->attrs.ops_update_interval !=
+		attrs->ops_update_interval;
 	bool aggregating = ctx->passed_sample_intervals <
 		ctx->next_aggregation_sis;
 
@@ -710,10 +716,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	if (!attrs->aggr_samples)
 		attrs->aggr_samples = attrs->aggr_interval / sample_interval;
 
-	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
-		attrs->aggr_interval / sample_interval;
-	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
-		attrs->ops_update_interval / sample_interval;
+	if (sample_interval_changed || aggr_interval_changed)
+		ctx->next_aggregation_sis = ctx->passed_sample_intervals +
+			attrs->aggr_interval / sample_interval;
+	if (sample_interval_changed || ops_update_interval_changed)
+		ctx->next_ops_update_sis = ctx->passed_sample_intervals +
+			attrs->ops_update_interval / sample_interval;
 
 	damon_update_monitoring_results(ctx, attrs, aggregating);
 	ctx->attrs = *attrs;
-- 
2.43.0

