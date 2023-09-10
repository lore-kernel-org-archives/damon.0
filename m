Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4C15BC
	for <damon@lists.linux.dev>; Sun, 10 Sep 2023 03:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3E3C433CA;
	Sun, 10 Sep 2023 03:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694317252;
	bh=ksAtuRMHUySOp8Xx1g77nkmGZFnU3FZ4zcI4qBiSy/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecUnwAiCcOAgRM4f0xtr+cxgCRncgILzBDXmIG/5Vd1IiS25/+TOD765eUx12lkbK
	 Hbh7qPvTSqx2y7tFuVbwgEJJCdrc4VOBaLbrFw1nKuFRp5xtLAOIyRSU35QDEpORhV
	 3zPFTr9qA8WrXg8bJ7ICCMpcA9/JDVX3A0iT3GMV9/qt7mcI6uo7vtdA6ApLS6cEns
	 EVTQ6ni8/Ebvnri1GA6uUZ8wjkDZ4JjyZUxxPrChUk4a1ErFyV6YEwtYFxUc7Zphaz
	 ZYcCz9+BnwmnfYGH7q91HlkK6vyvfNLOtDfMRyUz5QZC2xuOT3G2BZeP9sKfr5W0Jz
	 eTLniDweakmyw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/8] mm/damon/core: make DAMOS uses nr_accesses_bp instead of nr_accesses
Date: Sun, 10 Sep 2023 03:40:41 +0000
Message-Id: <20230910034048.59191-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON provides nr_accesses_bp, which becomes same to nr_accesses * 10000
for every aggregation interval, but updated every sampling interval with
a reasonable accuracy.  Since DAMON-based operation schemes are applied
in every aggregation interval using nr_accesses, using nr_accesses_bp
instead will make no difference.  This also makes future DAMOS changes
for applying the scheme in a time interval that less than the
aggregation interval possible.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 83b0cd329e84..3e0532c6896c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -799,12 +799,13 @@ static void damon_split_region_at(struct damon_target *t,
 static bool __damos_valid_target(struct damon_region *r, struct damos *s)
 {
 	unsigned long sz;
+	unsigned int nr_accesses = r->nr_accesses_bp / 10000;
 
 	sz = damon_sz_region(r);
 	return s->pattern.min_sz_region <= sz &&
 		sz <= s->pattern.max_sz_region &&
-		s->pattern.min_nr_accesses <= r->nr_accesses &&
-		r->nr_accesses <= s->pattern.max_nr_accesses &&
+		s->pattern.min_nr_accesses <= nr_accesses &&
+		nr_accesses <= s->pattern.max_nr_accesses &&
 		s->pattern.min_age_region <= r->age &&
 		r->age <= s->pattern.max_age_region;
 }
-- 
2.25.1

