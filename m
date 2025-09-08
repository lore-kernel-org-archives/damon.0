Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0A2D979D;
	Mon,  8 Sep 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362524; cv=none; b=UInsEDV57kfsctmRm62VJK4op4NC0K3Z3/KrJBccQMw5nZkWEZe3UAuo7hEtycwVzFFqWq7ZvFafHiHxZE1r8oOTIMB57Uogrz7ElqhlNOUdt8zw9EpCi71+RgnevYjhcgWEfE2BOcUk2nOmmFR54KE1rfCQ4ekAH+gDio5Uttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362524; c=relaxed/simple;
	bh=9plYFMqBRkh39dTcvpAtaB83IpFv91F16IOlzHIVMp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pUGkUpcwdZi0blzrsejRMJad9GutXc8ffVPqLiDlqEKz6SCxXcHJNro2WqM0ZVzdhg3bcHwTb2M9ZC/3Voch02XDwQekal1w/Gm93095wNQ/OJVWIhEW+Y7gg2OxfjXC7DPCliJgtRqCACZ1uZxVFl/R4aupSZDRkTEt6XgbW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQWmdD75; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQWmdD75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C98C4CEF1;
	Mon,  8 Sep 2025 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757362523;
	bh=9plYFMqBRkh39dTcvpAtaB83IpFv91F16IOlzHIVMp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQWmdD75oE1fORIEtDVZnUGfijmdYkpohDkXtBTHcEbRMY3i0VEH9bmAyXuWUZEvN
	 etTP0HbCeutdXuPv7Tusyu9nrQOG3XZaBWORXdBf3yRK4T+94mFI+j+rm0fjVDkW1U
	 lSRcPraqITfV2GnEQ36gYNVMVfoX4tUV5z0090tTtFCe63uo51STI7vEFtT+ueFTV0
	 3hRFv2ByyMd9Emh1Jl5Vscb0IfiD2Cub7tRB0FDPj5M+Ft2QgOlIxGf7zky8Y/E1El
	 LrlHS4VteRmDM87wm3TK8btsoB+hrSZwKpO1vPDxlTC53wdvcCZLc17YjBqGqSP79f
	 lFwCrw58BKScg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/core: introduce damon_call_control->dealloc_on_cancel
Date: Mon,  8 Sep 2025 13:15:12 -0700
Message-Id: <20250908201513.60802-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908201513.60802-1-sj@kernel.org>
References: <20250908201513.60802-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When damon_call_control->repeat is set, damon_call() is executed
asynchronously, and eventually be canceled when kdamond finishes.  If
the damon_call_control object is dynamically allocated, hence, finding
the place to deallocate the object is difficult.  Introduce a new
damon_call_control field, namely dealloc_on_cancel, to ask the kdamond
deallocates those dynamically allocated objects when those are canceled.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ec8716292c09..aa7381be388c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -636,6 +636,7 @@ struct damon_operations {
  * @data:		Data that will be passed to @fn.
  * @repeat:		Repeat invocations.
  * @return_code:	Return code from @fn invocation.
+ * @dealloc_on_cancel:	De-allocate when canceled.
  *
  * Control damon_call(), which requests specific kdamond to invoke a given
  * function.  Refer to damon_call() for more details.
@@ -645,6 +646,7 @@ struct damon_call_control {
 	void *data;
 	bool repeat;
 	int return_code;
+	bool dealloc_on_cancel;
 /* private: internal use only */
 	/* informs if the kdamond finished handling of the request */
 	struct completion completion;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7aeb3f24aae8..be5942435d78 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2510,10 +2510,14 @@ static void kdamond_call(struct damon_ctx *ctx, bool cancel)
 		mutex_lock(&ctx->call_controls_lock);
 		list_del(&control->list);
 		mutex_unlock(&ctx->call_controls_lock);
-		if (!control->repeat)
+		if (!control->repeat) {
 			complete(&control->completion);
-		else
+		} else if (control->canceled && control->dealloc_on_cancel) {
+			kfree(control);
+			continue;
+		} else {
 			list_add(&control->list, &repeat_controls);
+		}
 	}
 	control = list_first_entry_or_null(&repeat_controls,
 			struct damon_call_control, list);
-- 
2.39.5
