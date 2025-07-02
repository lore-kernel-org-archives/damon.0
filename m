Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D82F5C48
	for <damon@lists.linux.dev>; Wed,  2 Jul 2025 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751487245; cv=none; b=e2JsZIDhOaN3pmZ2OK4B1LPZsEe8uTmOw7a3bDXCthzsIKWwfySafjaqVEHbSCUtrvlYjDidVUWeuuUAXV9b6Phhbei+F256PNWuFuSsiY2Ifmqw1kEKdoH9g1fOlUvwyyzuR8hzIibc884dFO8f5fAp3OLp6chSfOgrHBQzBTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751487245; c=relaxed/simple;
	bh=m6rwVvWQAPY0xwQVg9qv36a7gw0jGxN4YhIiDoRIEz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FY1OnGDvYwk5J0eCAJIqNFvXJ+fmLHo1h2lTCSmxxKCDmZgxSVWAG7JWtA/18yMoA2xl8R+i51qNauJqhWiZQsIpxbH1FjD8RRNz5cqAq6hBDFvHPFNg4o7WThHPys/VCG3/m1+Wc912IP5A5q2ptca5QGmNfMQ9vBaz1AhNICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC2l522+; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC2l522+"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-710bbd7a9e2so50866177b3.0
        for <damon@lists.linux.dev>; Wed, 02 Jul 2025 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751487243; x=1752092043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8vdOdUxNKsgfVTSqDg8R0nof5JK9i0IVO2A48aHJBQ=;
        b=UC2l522+wKbIFMBl0SAiu5YLu0pKAYP5IreeuvNQZyQA1SQ3X4YSQwhougc5UQ/Hvd
         +fWWKgpIxOgrkn1ozxFtYWr/Jouybivji2xRx3OeWclgQVNSK2qTOHYHQQFtYEZ+ero6
         85KtgUmtHQ8CZXXq/8D6bORadzAG3+xGBfow2wFVssYNHtCixDWVujpxt5H/8HQYGXvs
         IfqqCCulUowfsI9bZVbc7aV1KdrSgvjHoSMqMrCI0KdUk+QVf6IE9MBvBEtQOYCfjGLD
         Fa6PcOkaYrCSCNqp/qzzuO8jXzQItJCdoELj3sv715XcjjQwkTdA67OLc5yEdB+ui5SQ
         N+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751487243; x=1752092043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8vdOdUxNKsgfVTSqDg8R0nof5JK9i0IVO2A48aHJBQ=;
        b=Y6/dhdyfl5NVGCBcCiEyfxvtTUG5rVHBkaXq1jjbvyOm6w+hhNsOKgu8Lu/Yo8P9TJ
         hKTJINHsRIrHh0DXQLdzNRYdAbCQvBs/DMDjHx+B9DhqYq/K9d0gri7vNsXMiQtKRf+p
         j4aiKOj3faZx8oOEkogUxy8vE1/yjPCKPJsvhBeNYZGUs8h1rnqjhmcf91shL00YrRFE
         aMrKPJ4Tgtu5d9SiWC3Jj7QZOobWt7cR5UevUMBfLsdAPUEoDFVnazaIbNFvB+oq+qOa
         18zw5l4WToH57MJ9qsKLAHO0g2pHPxx5pZvPutEZJUFEK082clhXCxUlJ5Lf/zeKbRlP
         eTrw==
X-Gm-Message-State: AOJu0YwhBfacfyNGxeAenClWyMqYB5V5BfoDQ9QAEXKqTsME2kHi/0qw
	Myn1tGBM5ueKcalspoJ1JdHMBeWjuFoyDHoYukBTA6uAS1nerij0T8I6ciae3XKRcao=
X-Gm-Gg: ASbGnctWYn2E2NGLNg6z6JJ7dmshTI4JM4cCkY6L9ONvzLxbVm+zYga87HgDmBm/Pz5
	YnNA9gda98wsHa67sT/5dW39/Epibo/kb4yMWQFG/eGOitAmiY/qCwR4Nl8dtAiM9RgTDR45ixQ
	itVLILC0ZYcXJduh6XNJTSnT9cnw29hF9W32i8uYmCJLG385m8mdS1QFD2ld9TTNT+rsL2C13Zk
	/OyqQazfoTe7rUPndXJJ1ifhtepQh03M0Mf4qFt5U4kFtyMZUnlw96ux1gTn8/yoCP2vuQ8x1VA
	M8yAM2UKnYpiPrT/qQjYi5aLIufKrxaVWb/DoWuL/Myv5EwNJfEA0SE+op7Z8a9lrNvVAShgQPC
	cFUZzHxQ=
X-Google-Smtp-Source: AGHT+IF/ow1/EWp39STigJig6Khl9tOyh6FQqrPjVZfUunx/eZoW/FNYghundzTyg76yYxu9pfn8Ew==
X-Received: by 2002:a05:690c:f8b:b0:70c:bb54:cd05 with SMTP id 00721157ae682-7164d40a246mr62055307b3.19.1751487242197;
        Wed, 02 Jul 2025 13:14:02 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:873e:8f35:7cd8:3fe3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4347sm26124157b3.83.2025.07.02.13.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:14:01 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: [RFC PATCH v3 01/13] mm/damon: add struct damos_migrate_dests
Date: Wed,  2 Jul 2025 15:13:24 -0500
Message-ID: <20250702201337.5780-2-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702201337.5780-1-bijan311@gmail.com>
References: <20250702201337.5780-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Introduce a new struct, namely damos_migrate_dests, for specifying
multiple DAMOS' migration destination nodes and their weights.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 include/linux/damon.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bb58e36f019e..24d387a972dd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -447,6 +447,22 @@ struct damos_access_pattern {
 	unsigned int max_age_region;
 };
 
+/**
+ * struct damos_migrate_dests - Migration destination nodes and their weights.
+ * @node_id_arr:	Array of migration destination node ids.
+ * @weight_arr:		Array of migration weights for @node_id_arr.
+ * @nr_dests:		Length of the @node_id_arr and @weight_arr arrays.
+ *
+ * @node_id_arr is an array of the ids of migration destination nodes.
+ * @weight_arr is an array of the weights for those.  The weights in
+ * @weight_arr are for nodes in @node_id_arr of same array index.
+ */
+struct damos_migrate_dests {
+	unsigned int *node_id_arr;
+	unsigned int *weight_arr;
+	size_t nr_dests;
+};
+
 /**
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @pattern:		Access pattern of target regions.
-- 
2.43.5

