Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099D817D1
	for <damon@lists.linux.dev>; Tue,  6 Sep 2022 15:19:55 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso15351442pjk.0
        for <damon@lists.linux.dev>; Tue, 06 Sep 2022 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1NDwLaBCs5nhmRz61i3eAQ3IF542diGapeEzK/fCX5o=;
        b=Zo5lCexyWBldwLJNn337E+X4XjLh3CKtHzTEdaQ/ECk+dhSOKS4DnmcGXPxy+tuk+U
         DUV5mZGpHmWJrRWFmITH9tJPsFe1PisCnZYzDJPqP0axutpJSiQFSLw/4EbTQLO1dE1Y
         ZfGil5qcOfMj5r12bh+MaLOVAENX22LwVqJbfiy8lNzM7eK8mU+c+KLNV/DP0QAXsk0V
         5eobciFlxZL6g0+VRCohy0KR6AZLqVuB0KtCkAnw2bo6svNgZuDD4BlwJC3aCzLdc5id
         Tr8R3j3r6k3AcZ/1Ex0sSQ94QMEp9vGtRd4+ITU5wwMa0YVVivbd1CotjXtDyWyLYiAo
         +ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1NDwLaBCs5nhmRz61i3eAQ3IF542diGapeEzK/fCX5o=;
        b=Y6I3/3brFF34nR+cob6Fv8IUCIXA36FndBN7ExyGJb5SpwfrDkjVpwk0+//tpn4xcl
         8+IU8Kz9TdhSrn/hnJOkNTAlJ747xoDdagV8inhtIJVj1ko7rdAxIx6UTlmIun3p7ENj
         p1j359QKqZhaQT4mUmTrzUBs27lqtd1CXPhPryehZZksCHkNJK4vhow6wda6TYJtkhP4
         Cb1HmN5Z/RK/jupBTIxAU1Q3EUlxKRCAwwb+zODLfS8U9tmGuMcaKb7Qw89LmjFJhM4N
         AqutuM7xH2q+GOP47w8xx6t3OFsCR1mrm7FFGpSxVMQswZEwJDJ3B32EpHqWbzedkOg9
         2udA==
X-Gm-Message-State: ACgBeo3JrqGqRMH+G+PzEOq8Ao3xioyaHn0qht+R/Ie+PnKVlLsepy1q
	6IKc29x4wTcQCIU8ny8CvtFsnR/5EfmM
X-Google-Smtp-Source: AA6agR4qbrSGPS0PcXmVtpUkCSbvfk3XXjbUCMdjYOZ7LU95Dyl0T9eBAaOS1Yx1ItBiTzOFcFhj8A==
X-Received: by 2002:a17:90b:1d0a:b0:1ff:35a3:c594 with SMTP id on10-20020a17090b1d0a00b001ff35a3c594mr24869790pjb.14.1662477595386;
        Tue, 06 Sep 2022 08:19:55 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902a38400b0016dc26c7d30sm1095554pla.164.2022.09.06.08.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2022 08:19:54 -0700 (PDT)
From: xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon/core: iterate the regions list from current point in damon_set_regions()
Date: Tue,  6 Sep 2022 23:18:47 +0800
Message-Id: <1662477527-13003-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

From: Kaixu Xia <kaixuxia@tencent.com>

We iterate the whole regions list every time to get the first/last regions
intersecting with the specific range in damon_set_regions(), in order to
add new region or resize existing regions to fit in the specific range.
Actually, it is unnecessary to iterate the new added regions and the
front regions that have been checked. Just iterate the regions list from
the current point using list_for_each_entry_from() every time to improve
performance.
The kunit tests passed:
 [PASSED] damon_test_apply_three_regions1
 [PASSED] damon_test_apply_three_regions2
 [PASSED] damon_test_apply_three_regions3
 [PASSED] damon_test_apply_three_regions4

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 include/linux/damon.h | 8 ++++++++
 mm/damon/core.c       | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7b1f4a488230..d54acec048d6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -463,9 +463,17 @@ static inline struct damon_region *damon_last_region(struct damon_target *t)
 	return list_last_entry(&t->regions_list, struct damon_region, list);
 }
 
+static inline struct damon_region *damon_first_region(struct damon_target *t)
+{
+	return list_first_entry(&t->regions_list, struct damon_region, list);
+}
+
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
 
+#define damon_for_each_region_from(r, t) \
+	list_for_each_entry_from(r, &t->regions_list, list)
+
 #define damon_for_each_region_safe(r, next, t) \
 	list_for_each_entry_safe(r, next, &t->regions_list, list)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7d25dc582fe3..702e1b7e975b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -195,6 +195,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			damon_destroy_region(r, t);
 	}
 
+	r = damon_first_region(t);
 	/* Add new regions or resize existing regions to fit in the ranges */
 	for (i = 0; i < nr_ranges; i++) {
 		struct damon_region *first = NULL, *last, *newr;
@@ -202,7 +203,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 
 		range = &ranges[i];
 		/* Get the first/last regions intersecting with the range */
-		damon_for_each_region(r, t) {
+		damon_for_each_region_from(r, t) {
 			if (damon_intersect(r, range)) {
 				if (!first)
 					first = r;
-- 
2.27.0

