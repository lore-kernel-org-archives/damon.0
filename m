Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A107263E;
	Sun, 26 Oct 2025 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761502943; cv=none; b=n1sRFfnPxCeCet9KRzv6bxcOMS/e3AYhi1aHyztRM3QoJ32QkNMw7z8cVZNs4WdeDmKhPqsUY9Qb+GEhdjnfHNvI+wEahX3A89MpL7sXxtjEAooLCjc+cCAul33hYrKsW3yvo8gBOd36YijvXupHe38Y9xm7gMzLE0Nsphohk+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761502943; c=relaxed/simple;
	bh=1E84e4fabiNAb3ypwhroOSlt1p8IcxO3BF19toErg4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCG98Tu3267Hjhern2YOHV+4z17dmMiRJdUP3tkvzc3waqK55+XQWHcEmhLCGZECFuvRw/OW6K45Tj4ZYICfCzQJKzqWnRvi8Tf5q51XnNhaEPBbeKA/InuXxR4pM94zKQ17OhjROO9eOA4AEqWYr58SCzgZgh5S6I0ZZXO4ViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoQDN6au; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoQDN6au"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3E3C113D0;
	Sun, 26 Oct 2025 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761502943;
	bh=1E84e4fabiNAb3ypwhroOSlt1p8IcxO3BF19toErg4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZoQDN6au+Tg5geccepd0n5jaQo5frnLxxevptxzekhIHdri4IX4MB83uqi4rbENvn
	 mKAML5NeJN7pF0s3WvoVuSHYhCv2xH4XXY7aMOJgONt12eB0tzjNvC/oezxe0O917r
	 L+aCZCAOP1i7uv5/qr55/PIbj16bGMKZqkJKtN3Q84ZjgCIvL8y73L2tdLJzM6Z1OQ
	 lfEalv6kLoQ1e1cGkuenIeTqRZROhxn6Pf8qFgNJbmZJCNpI6XxaofEb3N8KWAbphZ
	 MnnuoeRmKHsJYL2VdEcfWmO0Vmaetk91qylNGyU/ycyXaZ7+AHV2Ohnoz+p2mmHKkN
	 U6coEcNAa2a5g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/8] mm/damon/core: fix wrong comment of damon_call() return timing
Date: Sun, 26 Oct 2025 11:22:06 -0700
Message-ID: <20251026182216.118200-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026182216.118200-1-sj@kernel.org>
References: <20251026182216.118200-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call() works asynchronously and synchronously for repeat and
non-repeat mode requests, respectively.  The comment about the behavior
is wrong, though.  Fix it.

The wrong comment was introduced together with the repeat mode, by
commit 43df7676e550 ("mm/damon/core: introduce repeat mode
damon_call()").

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d78f4452e536..06ad359024ad 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1448,7 +1448,7 @@ bool damon_is_running(struct damon_ctx *ctx)
  * Ask DAMON worker thread (kdamond) of @ctx to call a function with an
  * argument data that respectively passed via &damon_call_control->fn and
  * &damon_call_control->data of @control.  If &damon_call_control->repeat of
- * @control is set, further wait until the kdamond finishes handling of the
+ * @control is unset, further wait until the kdamond finishes handling of the
  * request.  Otherwise, return as soon as the request is made.
  *
  * The kdamond executes the function with the argument in the main loop, just
-- 
2.47.3
