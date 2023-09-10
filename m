Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA8A17C6
	for <damon@lists.linux.dev>; Sun, 10 Sep 2023 03:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E782EC433CD;
	Sun, 10 Sep 2023 03:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694317253;
	bh=MX3U5PAIeegCJCB7eLilaWjnagt4bwpadGy8uCoTAPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ukwU7ClsMJzswDPgiPqi34noD/YWgkgpYy9DTKZv6j27OpTnHzCYojjnIIeATvJYN
	 ahttWt3gMemTLniiTvBNfWs/xtDY8/cnBxOVexAWmn/45Om5A9B80Fyd8Lh4ayso3S
	 h2IOtpquQVNeVk/ljEco9I+zHWzG9plGhihdWjIUaDeakrlOgGuNxa+XnnDi/A8gfO
	 N70z6/+H4ITZFIZp3II+NPOj7wCMGK/ofQn13w16+xfVvSR5dGtKacsaVZgLXNbC3d
	 I4z7iTc426dEh1+QdaG28ZXBNBtTVotkJ75bMNBlcObJljwa3L3QDiAfMbfxEPN47s
	 bXb9XM7/1Dh8w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 3/8] mm/damon/core: expose nr_accesses_bp from damos_before_apply tracepoint
Date: Sun, 10 Sep 2023 03:40:43 +0000
Message-Id: <20230910034048.59191-4-sj@kernel.org>
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

damos_before_apply tracepoint is exposing access rate of DAMON regions
using nr_accesses, which was actually used by DAMOS in the past.
However, it has changed to use nr_accesses_bp instead.  Update the
tracepoint to expose the value that DAMOS is really using.  Note that it
doesn't expose the value as is in the basis point, but after converting
it to the natural number by dividing it by 10,000.  That's for avoiding
confuses for old users.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 9e7b39495b05..6f98198c0104 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -34,7 +34,7 @@ TRACE_EVENT(damos_before_apply,
 		__entry->target_idx = target_idx;
 		__entry->start = r->ar.start;
 		__entry->end = r->ar.end;
-		__entry->nr_accesses = r->nr_accesses;
+		__entry->nr_accesses = r->nr_accesses_bp / 10000;
 		__entry->age = r->age;
 		__entry->nr_regions = nr_regions;
 	),
-- 
2.25.1

