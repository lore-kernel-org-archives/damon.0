Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437E161
	for <damon@lists.linux.dev>; Sun, 16 Jul 2023 01:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3452C433C7;
	Sun, 16 Jul 2023 01:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689469772;
	bh=5SSm4qEXPJuLohs5+byCGS3o4lRGePIKkaLKy1/+IXc=;
	h=From:To:Cc:Subject:Date:From;
	b=RNE0S0KQf9cRwje4zpnYyVSB45dXyxazFqRNu79k0NvYqvDcqN3SDgAQKkSSlThfu
	 bvt8zjM+7qrgXnrITpz0BXGwD6EIWrjEvP8Sgouy+zj3Ti9+08V0ssNOZS4t84SVjB
	 +i7dELXzNCAV4Ps/cElbr5vod97Fi8CSEMEzQsKkGpjCI4AAnTvKvmFtgbTxa0igmt
	 jaz3LqNmLDx1Uirxipq9HaXZTwq2bhq0XjBjmWxL89463OKLVZYI9/hm0sA1muGdRd
	 sBVyyfPI2Yan0+hwlQsdkB2X/Vo7PgdhJx7e4N8Sl0NgCz4jmCBnYdCKiKthemyOTr
	 QSYdaRb4YsDzw==
From: Chao Yu <chao@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] mm/damon/dbgfs: reduce stack usage in str_to_schemes()
Date: Sun, 16 Jul 2023 09:09:26 +0800
Message-Id: <20230716010927.3010606-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

struct damos_quota quota caused the stack usage of str_to_schemes() to
grow beyond the warning limit on 32-bit architectures w/ gcc.

mm/damon/dbgfs.c: In function ‘str_to_schemes’:
mm/damon/dbgfs.c:292:1: warning: the frame size of 1496 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Allocating dynamic memory in str_to_schemes() to fix this issue.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 mm/damon/dbgfs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 124f0f8c97b7..78acc7366895 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -237,18 +237,26 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	int pos = 0, parsed, ret;
 	unsigned int action_input;
 	enum damos_action action;
+	struct damos_quota *quota;
 
 	schemes = kmalloc_array(max_nr_schemes, sizeof(scheme),
 			GFP_KERNEL);
 	if (!schemes)
 		return NULL;
 
+	quota = kmalloc(sizeof(struct damos_quota), GFP_KERNEL);
+	if (!quota) {
+		kfree(schemes);
+		return NULL;
+	}
+
 	*nr_schemes = 0;
 	while (pos < len && *nr_schemes < max_nr_schemes) {
 		struct damos_access_pattern pattern = {};
-		struct damos_quota quota = {};
 		struct damos_watermarks wmarks;
 
+		memset(quota, 0, sizeof(struct damos_quota));
+
 		ret = sscanf(&str[pos],
 				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u %u %lu %lu %lu %lu%n",
 				&pattern.min_sz_region, &pattern.max_sz_region,
@@ -256,10 +264,10 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 				&pattern.max_nr_accesses,
 				&pattern.min_age_region,
 				&pattern.max_age_region,
-				&action_input, &quota.ms,
-				&quota.sz, &quota.reset_interval,
-				&quota.weight_sz, &quota.weight_nr_accesses,
-				&quota.weight_age, &wmarks.metric,
+				&action_input, &quota->ms,
+				&quota->sz, &quota->reset_interval,
+				&quota->weight_sz, &quota->weight_nr_accesses,
+				&quota->weight_age, &wmarks.metric,
 				&wmarks.interval, &wmarks.high, &wmarks.mid,
 				&wmarks.low, &parsed);
 		if (ret != 18)
@@ -278,15 +286,17 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 			goto fail;
 
 		pos += parsed;
-		scheme = damon_new_scheme(&pattern, action, &quota, &wmarks);
+		scheme = damon_new_scheme(&pattern, action, quota, &wmarks);
 		if (!scheme)
 			goto fail;
 
 		schemes[*nr_schemes] = scheme;
 		*nr_schemes += 1;
 	}
+	kfree(quota);
 	return schemes;
 fail:
+	kfree(quota);
 	free_schemes_arr(schemes, *nr_schemes);
 	return NULL;
 }
-- 
2.40.1

