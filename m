Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3422577B;
	Fri, 26 Apr 2024 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161183; cv=none; b=ten+jbFetPvi/pMvlusHwTYrwcpT98Q7PYcLCtRiBn4w5MCSZwsDd3RiS8WvWbmF5LRvlsBi9jLPHiXbDv63KJ5NxDGDGDDmNjoDGjX1CwWgvhdQ6rUZog/JCnPAB7BqqWU7W8yzovV4nVP+NhQUSlSInlGDgQOrMUZ28yFu0HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161183; c=relaxed/simple;
	bh=7DU4R9EMCr6vh5Iz6aftKnw6t4Q6vqj1u1UiBTV/q1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJa/C2k7f5iM1OPyxHmKVM7QAb2PNSzFqIVis/qzK0FlGxxdVcJ5C3qo0EpmCwNG0ozPlhHU1kXBkR0C7TWc9pmG0D/39O4Wnpgj08V4me4fMTUYlcgnk6ibcm7ogTznlJJG84KHoeXBJtQYIAWscSDZlsLVUtWc/6DCpL/bauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLYNgvdE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLYNgvdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BCEC32786;
	Fri, 26 Apr 2024 19:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161182;
	bh=7DU4R9EMCr6vh5Iz6aftKnw6t4Q6vqj1u1UiBTV/q1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLYNgvdEpIUlrtvvzOSTquF5rJ5xcLuqkYJPZFObcmdIo933ByRPadsnhaF0urhMB
	 YXynjowLyC6EWBNiJliRtGXw029dtrwOIwudD5yaPt4yNHLnmXqlD2DS5ggEWQTgqN
	 rIQJYVPRkqgRVjpkkKGWniPqQTrUE8DeZesGCd6g/lF2VqnM4aOXomTQ3nVbj7zqkn
	 rBZB1FjzeYMIbgMTBCVONBq+8wGBdUGzknY4oZRM5Ucu86v2w+Ho8KeAZlGuURO4pB
	 1vZNtX39au9u7qXJ97WSUfJnGkvy1iwJ8AlfyUQZzM9K+AbRij2G3wAzPxqfSLFBZD
	 3LUwJAuzP1l9A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 4/7] mm/damon/paddr: implement DAMOS filter type YOUNG
Date: Fri, 26 Apr 2024 12:52:43 -0700
Message-Id: <20240426195247.100306-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426195247.100306-1-sj@kernel.org>
References: <20240426195247.100306-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filter of type YOUNG is defined, but not yet implemented by any
DAMON operations set.  Add the implementation on 'paddr', the DAMON
operations set for the physical address space.

Signed-off-by: SeongJae Park <sj@kernel.org>
Tested-by: Honggyu Kim <honggyu.kim@sk.com>
---
 mm/damon/paddr.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 310b803c62779..5685ba485097d 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -214,6 +214,11 @@ static bool __damos_pa_filter_out(struct damos_filter *filter,
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMOS_FILTER_TYPE_YOUNG:
+		matched = damon_folio_young(folio);
+		if (matched)
+			damon_folio_mkold(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.39.2

