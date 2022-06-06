Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344567C
	for <damon@lists.linux.dev>; Mon,  6 Jun 2022 18:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6CEC341C0;
	Mon,  6 Jun 2022 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654539801;
	bh=FuYn5OaBm/cdGtgDHAKwyk/NB5Y5Xx2dRB0uYwvqtbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTHVR2x65cV9HsW/o06kyp604ujtkTQmRbApF/mteXZb9eHjqhKmnuXWcYEHlCnV0
	 uG4U1ETDaKCJWJLDC1+U6ibmwsX41DXZrlz5Ykx1WxkxFxr1mpOO0qglWWJPINaTmO
	 gCO6OF+KZfvll4FZEn4kZX2wve2tNfgC3rNmoTcpeWvPkENWytqks6ck4QbcDdjrbx
	 cB/X8Gk5dJbFUNsfW0eyVU/cF0oT39DRJruw2S1DVjbErlNXgInirmdDaxq0h4reA/
	 NjomkYMDQCaoMCoJLdc8i1TftJA6JO5BQDo+r6z8ODW3TdFJVS6hPeScHtK7dLsQPa
	 NEL/3ariFGPiA==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: corbet@lwn.net,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 6/6] mm/damon/reclaim: add 'damon_reclaim_' prefix to 'enabled_store()'
Date: Mon,  6 Jun 2022 18:23:10 +0000
Message-Id: <20220606182310.48781-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606182310.48781-1-sj@kernel.org>
References: <20220606182310.48781-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds 'damon_reclaim_' prefix to 'enabled_store()', so that
we can distinguish it easily from the stack trace using 'faddr2line.sh'
like tools.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 38da28803d75..e69b807fefe4 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -371,7 +371,7 @@ static DECLARE_DELAYED_WORK(damon_reclaim_timer, damon_reclaim_timer_fn);
 
 static bool damon_reclaim_initialized;
 
-static int enabled_store(const char *val,
+static int damon_reclaim_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
 	int rc = param_set_bool(val, kp);
@@ -388,7 +388,7 @@ static int enabled_store(const char *val,
 }
 
 static const struct kernel_param_ops enabled_param_ops = {
-	.set = enabled_store,
+	.set = damon_reclaim_enabled_store,
 	.get = param_get_bool,
 };
 
-- 
2.25.1

