Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C03290C9;
	Wed, 11 Mar 2026 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206971; cv=none; b=dI6fbn9UvDThn3KOdGOeYR/Pi6UJtzy7lw5EtTL5HpaFAJmu8Z2v9ILvSCuCinZmKfydNKsp0H+EapgjuQbAN0wW1p9iQGotEOAuM9kFz0h0wlBUOT6+n/QJEV4DtKHBqlpgW6LafotpDPul3i7RgS2Nd3WgHcY/l7R+tL/WK6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206971; c=relaxed/simple;
	bh=7cYdKplDL21iIsxLZsDyZKirI/10a9vKJC4T+MgvDTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHqMW709qmkSnrwBvscxvUVjJz2/4GDv2h0d0ExhHZods/VR+5jFPQiPkIdaUhsbHAPnwEJx2zhb3ugn8f+JTU5ZucZ7SJPs0eoji4xaST+jXebOwo6Zuir/APYXJNcQN4uZPKcl4zjNGUfzqUR+O8lbL4G2Al87i5h6hIJzBLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWw+fn4S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWw+fn4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B62CC2BCAF;
	Wed, 11 Mar 2026 05:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773206971;
	bh=7cYdKplDL21iIsxLZsDyZKirI/10a9vKJC4T+MgvDTg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWw+fn4SeVXEJyK2LlrMabr7MCW8ceh7oXjafpjdByQY6fgdPUa+Au9wo5OyE8FaG
	 u0njAgR7wJl/LdCtj6lXrOH5pM4iis3sXjoRuFy5lxWTqhF65RgKVC1qClZL88/Qj/
	 OLPv8oxEwwHcv5ki7k9mjBRR15mtR7yMh7LqojsZxaE/rXxnf6I9a+9QSW4xwmkvWw
	 hie/G4BUkhn2jGp8Omc/x5lzoo9JKEf4I53UNbxcxVfjb16d+5NVxh6PNV2sJq0hRt
	 HAze4P+5OHWMX4Ojp70CVdfK9iIY+nUX0H/5ZDhKrfkAbNfopx92OhAVzj9sIeEAC+
	 iMJts6isaoOag==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/5] mm/damon/core: fix wrong end address assignment on walk_system_ram()
Date: Tue, 10 Mar 2026 22:29:22 -0700
Message-ID: <20260311052927.93921-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311052927.93921-1-sj@kernel.org>
References: <20260311052927.93921-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct damon_addr_range' and 'struct resource' represent different
types of address ranges.  'damon_addr_range' is for end-open ranges
([start, end)).  'resource' is for fully-closed ranges ([start, end]).
But walk_system_ram() is assigning resource->end to
damon_addr_range->end without the inclusiveness adjustment.  As a
result, the function returns an address range that is missing the last
one byte.

The function is being used to find and set the biggest system ram as the
default monitoring target for DAMON_RECLAIM and DAMON_LRU_SORT.  Missing
the last byte of the big range shouldn't be a real problem for the real
use cases.  That said, the loss is definitely an unintended behavior.
Do the correct adjustment.

Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2e36024d99506..3925720a172a6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3060,7 +3060,7 @@ static int walk_system_ram(struct resource *res, void *arg)
 
 	if (a->end - a->start < resource_size(res)) {
 		a->start = res->start;
-		a->end = res->end;
+		a->end = res->end + 1;
 	}
 	return 0;
 }
-- 
2.47.3
