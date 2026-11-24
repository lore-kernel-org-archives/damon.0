Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534616;
	b=pPWFKbGA0OqQ36RlVLYcb/zMSP77xW3yYiVet1ic/DNLK2UK76TQT6L65VeTP0kUdMOI
	 gu/HKJCKMP6SjJ7k4rImYc7sDaZvhItbAWGWTYjEI9kLu+sXh0WGLiOsonsMViMGgDcma
	 z7wzHzHVn69/7z0tVu5LkFLr+ifTmq1Cc0h+a8ev1DDUDDxuRNmFXPPisRJaAn7VorzNj
	 vIVWr1AShUD4cn83jLxswuMsiFDLE4X0LI3ST9DqY5z/NZcedh7m+SP9GYxGEzZDMhYFI
	 DqxVwQCRvw0XwsKuJ8lzqIUUC2xSnAVNwCZXgBaHMuWMPyHaxO4aA6q24NG1+OZv53g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534616;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aVB5moYYD0/ARci2kYFlEjA1B7l4e+j1avzj4BHQvUQ=;
	b=qwhFKh/jkPCncHQK8rzPXFpwx3Uvx2eBxHlF9UP308NNLUEnOlSNF41QEm2xRTHtQYaZ
	 jThLqmR2zhxoyuPgwsTOvFJg0cx9SVbYleKo1yAXcZ0vbkS06KZabqWiipG9QuRFW8L/I
	 QjGPm27o2LMQwHtgxsGKbaPcgyEuazxhMXsp5R1myJljObP+wQ2V4EYoO1cF+XxVhcWR/
	 bzMPKELlZRaJP59fdCxOGKmpQXWUHtS0Gh6blH1IZdZ6fAv2l8TJ7bHohp8emVYnkG+qj
	 0EVlXCgYFrg3ApYostIc8l5gneH8B7n4ox7yUeGV7ioTLfOXIXSKeNaoPDx0Sbeeamw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIWzwWnS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FBA606A326
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HIWzwWnS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A741F000D1;
	Tue, 24 Nov 2026 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534616;
	bh=aVB5moYYD0/ARci2kYFlEjA1B7l4e+j1avzj4BHQvUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HIWzwWnST2mFJ9q87F1y433mV9g1P5frkW0/lgnv5+vQLyKUzWJAstgRvZA+cJ6MK
	 eH12Tk5Gce2xJy/NzJb2SmUOvHQynWWgOH/OMb8z20Zj4qWg5YPCzHjD+oPNKnBbjd
	 0q1NCzsOpvvoFYsdrhbpMUzycfXW1OjN1A5YcqnkZOOsJcYfJ/J98LA/7jjRhFCJ38
	 ahlg6QT0f2ILf58YNKxUOf+tPrGts3IlLT/XX/3PvIpBchaT804gweSonasaB6nFXM
	 ljDgZzmmEJ/Orwx/IyRLngbX15GAqoC7VLrXUve3LKFKqQPr+brMOQSFT1pp0+bcRR
	 lsnXoQUl6oWrA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 16/27] mm/damon/sysfs: support REPORT_MADE type probe filter setup
Date: Tue, 24 Nov 2026 07:36:22 -0800
Message-ID: <20261124153636.91854-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept user keyword "report_made" to probe filter type file.  Set the
damon_filter->type as REPORT_MADE for the input.  Setup
damon_filter->report_type with the filter_report_type user input.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ca971cf1dcf6d..1c171af4590a8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1016,6 +1016,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_ACTIVE,
 		.name = "active",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_REPORT_MADE,
+		.name = "report_made",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2336,6 +2340,8 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
 		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->range_min = sys_filter->range_min;
 			filter->range_max = sys_filter->range_max;
+		} else if (filter->type == DAMON_FILTER_TYPE_REPORT_MADE) {
+			filter->report_type = sys_filter->report_type;
 		}
 		damon_add_filter(probe, filter);
 	}
-- 
2.47.3
