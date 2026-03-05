Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AB2116F4;
	Thu,  5 Mar 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689167; cv=none; b=h/zj7HzXzY7TZVCfKhZ90UtttItJAIcJ2bi3cH66HerM16JYVLKxuMbC7DVBFKZOmdplTyadjNLNPYHEYbLHDuhcAhKjAWXA3EJP3JVDoCrkd+lxP+HuGI9sCwHiARy1DQ+eTL/Tk/Y9PM354m7dh1gxY/tOaHaawhWRrqig+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689167; c=relaxed/simple;
	bh=bVVliIOg8qhYd2P4htNiq3HDElr+pou2NiqB1WgEprY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVeRVkJHgeMmItD6GR83Zj6Dc7n1JNu7qiijsRYaTRI6t6Lk6QvKdTRVT3OOe565gh6tp2VyYBFylUyivbw06Kca2/GM6g07rzDBWdzyYDQ79gBBy9VV0hSuwEYe/LbEDsxe79kfMeFRsiWVIXXtqQ6MFW33ncNID8HhNSdQSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV78gkF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV78gkF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C138EC2BC9E;
	Thu,  5 Mar 2026 05:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772689166;
	bh=bVVliIOg8qhYd2P4htNiq3HDElr+pou2NiqB1WgEprY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EV78gkF0MgLzcm2fqzlweoxGrUfkuJ7etBaw1Dbu57ttNfmS/snYwef6oboti0hA+
	 AXNRLPLVMVvtzKGAKsEdkV75nLk/WjIuLytyXM6916kykgeMk1xfZkPsDVcqlQYiUU
	 +u+PlWwDwhVg+M+3yiPXFvxCi2P+IdUPotWzQFPoMPoa0tbPNjPZr0pmVy+uPuCfEQ
	 efHhwVMBycjy7ltHgnnN0hJ5Q3Vk/GFqutOjI2GQU7eQCxnABFL6yyQRGKH5l81R8P
	 RtQkCHc9KJj7NSfpy/wihuWBvjLJIR37f7U+o8Cj1oRiTT3i3Bn8TOykWC5HKeS3/1
	 MvkZI423te5xA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/5] mm/damon/core: fix wrong end address assignment on walk_system_ram()
Date: Wed,  4 Mar 2026 21:39:13 -0800
Message-ID: <20260305053918.83786-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305053918.83786-1-sj@kernel.org>
References: <20260305053918.83786-1-sj@kernel.org>
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
result, the function returns an address range that is same as the
expected one, but missing the last one byte.

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
index de38f2356b72b..db388d05cac3f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3056,7 +3056,7 @@ static int walk_system_ram(struct resource *res, void *arg)
 
 	if (a->end - a->start < resource_size(res)) {
 		a->start = res->start;
-		a->end = res->end;
+		a->end = res->end + 1;
 	}
 	return 0;
 }
-- 
2.47.3
