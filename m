Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B83C0C
	for <damon@lists.linux.dev>; Tue, 13 Sep 2022 17:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B87CC433C1;
	Tue, 13 Sep 2022 17:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663091094;
	bh=A+CgN3B+g3StjvR1ecSJxFzUf8y+UUwnpB+0EtAIiO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CaZNkoG/DVyccvLtqoqoXyvYOsHQtVbs6/wMr5ibaQ7DAm+4nezKW8iI7X+nPrA/L
	 ZQiVPvS/2eoWgjc45bbWm9hmWeeoxRGXCrEYslIJMGLNa6nuHsgWuBSsmFfL1DfABf
	 of72OPPFBIWP3hapXUV0alxnuRiZx3zVSIXg8XXPNpNQVW5dwTex4KEDlPQAO5Xe34
	 OsdNZRiLs4KjD0ofUTXPgIAI88nH4KUH8FcBu9Dw3JwbR/idcFmxqE46Qe29kkfuvQ
	 9j2yEPtwNm2knoIE4eAI+4gV1axPzGOMUwTDlyMrXqhHIQuMEY7occdn9bn74VZdT2
	 VqhFkGWzuH27g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/22] mm/damon/paddr: make supported DAMOS actions of paddr clear
Date: Tue, 13 Sep 2022 17:44:28 +0000
Message-Id: <20220913174449.50645-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220913174449.50645-1-sj@kernel.org>
References: <20220913174449.50645-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'swtich-case' statement in 'damon_va_apply_scheme()' function
provides a 'case' for every supported DAMOS action while all
not-yet-supported DAMOS actions fall through the 'default' case, and
comment it so that people can easily know which actions are supported.
Its counterpart in 'paddr', 'damon_pa_apply_scheme()', however, doesn't.
This commit makes the 'paddr' side function follows the pattern of
'vaddr' for better readability and consistency.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index f00cbe74a00e..5eba09d50855 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -274,7 +274,10 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_mark_accessed(r);
 	case DAMOS_LRU_DEPRIO:
 		return damon_pa_deactivate_pages(r);
+	case DAMOS_STAT:
+		break;
 	default:
+		/* DAMOS actions that not yet supported by 'paddr'. */
 		break;
 	}
 	return 0;
-- 
2.25.1

