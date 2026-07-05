Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003221638D;
	Sun,  5 Jul 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267313; cv=none; b=Qoa0UV/MfK37SnDihqF5Az1QutKQMbOTmI57sy7r71VBRCaee34lmptiNf9m2irfwTcqKk7eQgGl2iHNnK9U4TlmWrnQ6z0Rp6XBeYtE1j0PGAgJGe1q3Nu9o2513jgI/lM9ET+Oe86mwRo1lWezFFsLv2KhXzjWhElII+r/EPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267313; c=relaxed/simple;
	bh=0YWNBy/FeNrCieJO3gS1mCC45cQe4+RMNYEPleSetNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMQsm7t9RxuiI7jmdXwdBaI+d31pwLJIpgiups+xEum0ro6e2gmrdF+HEH7q5eWAKXA8rqCRGaJX0Z9MywR8A0GO2VwCF0Kt7DPjUg2is+r8ziYgeABQiMnD6N//D56c8vCg90lBjSxvRjfsn7Du+sYl83pZGglaW4zPJayEFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr5MWrhd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr5MWrhd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D6C1F00A3D;
	Sun,  5 Jul 2026 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267312;
	bh=QDJgGdtoA/IbgG+7ciI0YVsTZBt0XSBAZ9d0cV22mDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cr5MWrhdnyXSLPE6O3xug2SSK25OdsOyAMPxKtabIf/4+fMq0rM8V2Zh1U6LPbVx3
	 s4SpewekBWzCFfDCmijodtPA/MZ8F3BAIhmho4r4hZ8ISsSUOjbNGTJWjdpZptPiXY
	 ucSgFjMZuxbcvqPo+TjS1l4GvKjoDtult5+6hkjvzqgyjfFxcpJtpr6ZtScjCL+6l6
	 757vNMjtQ961oS39rkE2orxwL2fG5dF2+oLr0M5zosMESXgz0EU4klFB0LenYKrNMU
	 tW5ttm/UWDJly4eQ+MRA/2AOf7Cogc0ooKgmeRbQUu2JIXxHsxl5kxSeOYvPmB0/eL
	 4uougHrZKpelA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 01/11] mm/damon/core: stop ctxs in damon_start() before returning an error
Date: Sun,  5 Jul 2026 09:01:28 -0700
Message-ID: <20260705160142.97308-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiple contexts are passed to damon_start(), the function starts
the contexts one by one.  If any of the operations fails, it immediately
returns an error.  Contexts that successfully started before the failure
keep running.  The caller should catch this and stop the contexts.  It
is complicated and easy to make mistakes.  Stop all contexts in
damon_start() under the failures.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3c5a46e1c079a..d89a7f2faf350 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1917,6 +1917,9 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 		running_exclusive_ctxs = true;
 	mutex_unlock(&damon_lock);
 
+	if (i != nr_ctxs)
+		damon_stop(ctxs, i);
+
 	return err;
 }
 
-- 
2.47.3
