Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEE376A08;
	Mon,  6 Jul 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346799; cv=none; b=QH5KDB9+7/oATMuJadYcvhn20fZaQ/5u0z+9wdqh010MWYObwg1w1K560BKaJx7zLdBwZb/FfDhh8LW/r7XDHlmiJbMS8barbhkLjeKr77RQJZbeVTZN2zJMcJ9Ywqs9PWcEevmkoibucZ+N/hJcRq7pSH1ip/VGdrUtXTQwM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346799; c=relaxed/simple;
	bh=0YWNBy/FeNrCieJO3gS1mCC45cQe4+RMNYEPleSetNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bgpxk4zVVY8Dj3O1LUJciJ32xdUSRHl8+M4AROY37gMr9ILTwPAthPJXw2I9mEJqflnj1z8aek89bdhSTdUogoVBf3nlofGtPKjSsLogAvn5o6872VP9nwSF8rrN7g44gxSuUwB2pp4RAw7WysqJ/vdpaXP5hDLQAZbgLabxtsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsXq/PQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsXq/PQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3186E1F00A3A;
	Mon,  6 Jul 2026 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346798;
	bh=QDJgGdtoA/IbgG+7ciI0YVsTZBt0XSBAZ9d0cV22mDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SsXq/PQFHYzE1DpvXxcxdkCUTnJDzpsO84dWR3pJFjJI5VtU6cdmosmqVOpM2ZCh9
	 CTuTKNr+fU36gl2g2GRSZyg6nSer93UVSh12GheMUObqeru57q3nLk4KHyrkBYvGNR
	 dECkW73gKovoIc169Mx9j2zV1n+dIuWNu13ZKFtuRQAn74hnjcxU2OSs6Z2japzSqc
	 vcw/XuE/E8tJIEwurtofj0aD2sCXpWP0fbEBRhgxY41LEiXMndQkYjpKRXKNqAIbFo
	 yL4QDtPmlYkXUB2cOXSeqF3+L2faKVxaR/RaNHgy8YPbXN98ZDp8RjdHevMunbso8O
	 VPXqD6bgM3J/A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/11] mm/damon/core: stop ctxs in damon_start() before returning an error
Date: Mon,  6 Jul 2026 07:06:16 -0700
Message-ID: <20260706140628.87414-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706140628.87414-1-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
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
