Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB257C
	for <damon@lists.linux.dev>; Sun,  2 Oct 2022 19:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADC4C433D6;
	Sun,  2 Oct 2022 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664739096;
	bh=bQS/eXJeMiPmj71PLej7rSCZfOQeTrzaD8xCsX+qwWs=;
	h=From:To:Cc:Subject:Date:From;
	b=mqXGGEijWGYOiDoFBLN96KIHMPXk+iRXIEhFZEthkWkhHbII4hJTk8mU7LmVLy5Hb
	 27BrqgLA7UBZEmpgEnID8xnk6WO0IGDFKavvDraIxLFdEbbt/bmMCDhtEWDyM8u7aQ
	 yI+/LFUrOlsM1ulAgbtmQxXx5kOqO55fG59CsmEiJ5elUp6M3tiNfsCmq7pqLCMXoZ
	 PbWKrJE01GK1Gt0BUUXA9wxzzh3sAwSL6vF3F1rgr/zEyXKuyp1CuwunE6vDOqW5Zi
	 khuo8Dk5lBvSZ6cMAIlkRdtunin+/MAJCHpz6LYqi5cpCkFwVPDTIoFpa8Spw2bFcR
	 kkDribUKFF/Cg==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH] mm/damon/core: initialize damon_target->list in damon_new_target()
Date: Sun,  2 Oct 2022 19:31:30 +0000
Message-Id: <20221002193130.8227-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct damon_target' creation function, 'damon_new_target()' is not
initializing its '->list' field, unlike other DAMON structs creator
functions such as 'damon_new_region()'.  Normal users of
'damon_new_target()' initializes the field by adding the target to DAMON
context's targets list, but some code could access the uninitialized
field.

This commit avoids the case by initializing the field in
'damon_new_target()'.

Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Fixes: f23b8eee1871 ("mm/damon/core: implement region-based sampling")
Signed-off-by: SeongJae Park <sj@kernel.org>
---

 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1d952fa7ba3e..1e6691771a95 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -345,6 +345,7 @@ struct damon_target *damon_new_target(void)
 	t->pid = NULL;
 	t->nr_regions = 0;
 	INIT_LIST_HEAD(&t->regions_list);
+	INIT_LIST_HEAD(&t->list);
 
 	return t;
 }
-- 
2.25.1

