Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09346BA
	for <damon@lists.linux.dev>; Sat, 16 Sep 2023 02:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E761AC433C9;
	Sat, 16 Sep 2023 02:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694830200;
	bh=JTX8roVUkoUgDpJsiDynoUw1rs0WkWhqwrFFpgZDGAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYpkwR/inXjdyb2gngS4f7p4SFsHSMS3VtSAcLEHye2QBHmQXeQgFFKB1NqwqQ069
	 aJfOypDmoD9vgbsIZl9SG2hsjrARJmocVcmfc/djvDJOFqWJS/uhEYh7mMfeMcasN3
	 73lPOFle6veIKb+soiMhLbfXEYO1mG/l1prQj89951ycdnVn6p3OtlOpLDZ4nd1Yj7
	 4vwABlBysLdDFobnl2b32WnWVtx24Dl+WTM0ek1K1yrfioD5GPKq1jvihIEL2IfNhB
	 tBJSx15beCsLcfE3aARUMt7pYaWx5eQrqJiM4aOxKic2a1uSGSjm3HDYEMadPWoeB3
	 9twb5KOKOqTMQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] mm/damon/core: use nr_accesses_bp as a source of damos_before_apply tracepoint
Date: Sat, 16 Sep 2023 02:09:39 +0000
Message-Id: <20230916020945.47296-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_before_apply tracepoint is exposing access rate of DAMON regions
using nr_accesses field of regions, which was actually used by DAMOS in
the past.  However, it has changed to use nr_accesses_bp instead.
Update the tracepoint to expose the value that DAMOS is really using.

Note that it doesn't expose the value as is in the basis point, but
after converting it to the natural number by dividing it by 10,000.
Therefore this change doesn't make user-visible behavioral differences.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 19930bb7af9a..23200aabccac 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -36,7 +36,7 @@ TRACE_EVENT_CONDITION(damos_before_apply,
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

