Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF09272807;
	Tue,  9 Sep 2025 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389438; cv=none; b=iyMxpqBjE6XF4wLbYtBpZyPQiRSk4UKDR8kgEA4AhF+soAe+yFKtLLoVXfgPFzdWCyfs41ZEF6Rl76gMUJd3zaZMvF7SYtKZAraGZuK60PH90ys4AXcO/oBSyJGfLrQOhUga7inBZFe85K93eJVOyg7mn4GjRb7i/ysG/fLFpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389438; c=relaxed/simple;
	bh=L/Lbz2KLcan2N2kPl5aMa9m0ysN8kEIr/AYdtyuJa+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnpFAzslAWRH+J5h0JncczHgkBjhMYCeQuGnwW4qLKlMOdHlXRAqenll4JtqJ1ZuplrBNeD35m4XQciCh4hPuEicOGEtsbeeVpbsyr7D+ukNn2KSzVWOreTlOtkL3eyfzjXX+0ZMv99xJBlDI86+9Z1KRL6cfg6KXuySnvClNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odGA46Dc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odGA46Dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D75FC4CEF5;
	Tue,  9 Sep 2025 03:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757389437;
	bh=L/Lbz2KLcan2N2kPl5aMa9m0ysN8kEIr/AYdtyuJa+E=;
	h=From:To:Cc:Subject:Date:From;
	b=odGA46Dcm3MWSP95DuGe/5RlQEgtLVssOUaGdx3ubKvbhCCpStwmfZpn4bg7+XzS9
	 itnFZVga+XIkG/VtdWc5YXzrSfeE0Es6u0ctSercDmA4BBLG83vx0F+66lvSKpzaex
	 lDH5YVDxg5FPnbhDU+RmyfZdmknFNL2meOUgMYs/bbIaZmQer3+YW43VDLLtcQrVGM
	 fE9fwiPWIzZEPksTqWzEeOCtS06z6z/WuYjzyDjBWWm73zt7JcyvYzo53ua8OKBgYY
	 35B6B45v6/uIieQ0nKZkxwpLORJDnN1nQooy6TrxjnJjBH/FjHKuq5jKkQSwRABiC8
	 cvrC+bIaGG9kg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: reset age if nr_accesses changes between non-zero and zero
Date: Mon,  8 Sep 2025 20:43:53 -0700
Message-Id: <20250909034353.7064-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON resets the age of a region if its nr_accesses value has
significantly changed. Specifically, the threshold is calculated as 20%
of largest nr_accesses of the current snapshot.  This means that regions
changing the nr_accesses from zero to small non-zero value or from a
small non-zero value to zero will keep the age.  Since many users treat
zero nr_accesses regions special, this can be confusing.  Kernel code
including DAMOS' regions priority calculation and DAMON_STAT's idle time
calculation also treat zero nr_accesses regions special.  Make it
unconfusing by resetting the age when the nr_accesses changes between
zero and a non-zero value.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index be5942435d78..996647caca02 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2261,6 +2261,9 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	damon_for_each_region_safe(r, next, t) {
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
+		else if ((!r->nr_accesses && r->last_nr_accesses) ||
+				(r->nr_accesses && !r->last_nr_accesses))
+			r->age = 0;
 		else
 			r->age++;
 

base-commit: 580b0ae8069448252cfea72b75ba5b0857c128e0
-- 
2.39.5
