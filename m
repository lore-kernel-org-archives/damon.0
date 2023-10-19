Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB239866
	for <damon@lists.linux.dev>; Thu, 19 Oct 2023 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOgE1jz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F662C433C8;
	Thu, 19 Oct 2023 19:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744972;
	bh=mpZ0rzQnlOTIrrYJTnG5fwff80O37UKmtsf+aHi2YNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOgE1jz3lvMQfVP7TQZSOyc2aRshLkRxLJ6fzn2xEUat6kCKF9dHCXjOeqKgMRUkn
	 JciYs/7W2GFKrLW8hHfKWb7PqfogevqMt/W8HSQOH0D+82UwlpAdZ4kkAZlACm/7Yd
	 lD6zHpOrNamlwYL1JvFr3UqFSKsZRQ1C83Lu4MTrb569Z96fQBnp9j01s7w6xZ9Yus
	 L+XY6w6H9dDlGykT60OConZ8snDx2JZCuR0vhKoLc74v3VmzIH7s8RZFN1aRYiH6OY
	 +7tcNIopiD0jvwS2tVxbGdb8rayh09UhaZvj0Vg1VvBTo7/44eLy16O3BQ4MwcSBs7
	 FXMYu/8h+hHrw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/5] mm/damon/ops-common: avoid divide-by-zero during region hotness calculation
Date: Thu, 19 Oct 2023 19:49:22 +0000
Message-Id: <20231019194924.100347-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019194924.100347-1-sj@kernel.org>
References: <20231019194924.100347-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When calculating the hotness of each region for the under-quota regions
prioritization, DAMON divides some values by the maximum nr_accesses.
However, due to the type of the related variables, simple division-based
calculation of the divisor can return zero.  As a result, divide-by-zero
is possible.  Fix it by using damon_max_nr_accesses(), which handles the
case.

Fixes: 198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index ac1c3fa80f98..d25d99cb5f2b 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -73,7 +73,6 @@ void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr
 int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s)
 {
-	unsigned int max_nr_accesses;
 	int freq_subscore;
 	unsigned int age_in_sec;
 	int age_in_log, age_subscore;
@@ -81,8 +80,8 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	unsigned int age_weight = s->quota.weight_age;
 	int hotness;
 
-	max_nr_accesses = c->attrs.aggr_interval / c->attrs.sample_interval;
-	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE / max_nr_accesses;
+	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
+		damon_max_nr_accesses(&c->attrs);
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	for (age_in_log = 0; age_in_log < DAMON_MAX_AGE_IN_LOG && age_in_sec;
-- 
2.34.1

