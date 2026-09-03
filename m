Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39726ED46;
	Thu,  3 Sep 2026 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788397423; cv=none; b=hT2ZhTp+J9iCHMtbTXxV6k1NU9do5pjqFXjb9BKJHZuo8Z+i1zrSqXHC0dPwPug2ns2JFHc05iCNFCuP8jjwuG/pQ3rp1+EWmT1I67smejemZVOAyIOIf4ewt2qoA66MOLo1ZGLRl9lq/qOQbDrfG46dDfFE7/cLkVgB9LEG2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788397423; c=relaxed/simple;
	bh=4n2JrDaXTq+2UkFHl6GafHQBO+bShXu/XQEgbt/9mkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrbwlVvvMIBc69xM+cTUM2TDVqzNZPpJWhq6u2Go7JOqWZ03oDSO8NAuoxEMGEOjzgFVwt1uDKi1Z0Ibu1zVZsqYSCqt4oHUkpgCtixrZXwcJItNLuBgjl89fFpSCCP8bCUU78dRKlbzxNTs1pBZqGtPZ7gMIyrqlr8gs2flH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxkebG5+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxkebG5+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB0C1F00A3E;
	Thu,  3 Sep 2026 01:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788397422;
	bh=IGhJqVBSrLsY1DzUKQNwEOVO0mpPemu5G2qZNzm4L3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JxkebG5+E8aGwnRfz/OniYrZag3n4/XPkJqX5Tm87e4rNVmo6wdRr90sWwcjiQVBN
	 9Zq4LsUbD6kBbBE0PPZbanuKErFKPRY7yaqR8fwJkwlmqcLccHiPSpvtphAAjFpHn6
	 h0RJYVerE0G4KsesZiqoRlgb+QTaoU2r8xHAoE/NPmKpBrkz2BVx8wzcWz1mU55FUV
	 5VTEewVF9LnBXMXV6cV19OI/+B3qPjyCGD3syTkbYprtTZQLOptL4ULZVFIJVG7vql
	 lUlllxycWVippoZ+v0yTHSX689mOWA1MSTm/hT0u8RUFTFWbUNE1agPI5DQTAK9djK
	 KJVd6fB6wp9tw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] mm/damon/core: handle NULL ctx parameter in damon_call()
Date: Wed,  2 Sep 2026 18:03:30 -0700
Message-ID: <20260903010334.93622-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903010334.93622-1-sj@kernel.org>
References: <20260903010334.93622-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When NULL damon_ctx pointer parameter is passed, damon_call() could do
NULL dereference.  The caller is responsible to avoid that.  It is easy
to forget, and there are many damon_call() callers.  Meanwhile,
damon_call() is never meant to be performance critical.  It uses mutex
and completion.  Add the NULL pointer check inside damon_call() so that
callers can pass the parameter without NULL checks.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 85d29c76c00cf..03407cf7f9646 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2206,6 +2206,8 @@ int damon_kdamond_pid(struct damon_ctx *ctx)
  */
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control)
 {
+	if (!ctx)
+		return -EINVAL;
 	if (!control->repeat)
 		init_completion(&control->completion);
 	control->canceled = false;
-- 
2.47.3
