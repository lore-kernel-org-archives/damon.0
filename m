Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9D2566ED;
	Mon, 10 Feb 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212064; cv=none; b=BaAyKYYFrcwPBRv41Z7B8LNRcLdQto4bQczK2XgZPqcY8lCDQpM6PnFtQ3G4io6kC6k/DmB0XxLt/wZ/hmPOMsV53t8AZVLJ0gQPuJQzUZJOfRjgrw1aeszrUFe8+iMqmOHLD5AkiByjj0MgFu7ukYoiL+NPM8PLk0GwkMKSzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212064; c=relaxed/simple;
	bh=LrSHEUWGR3qHfrIKo1moG6hK8HchQtQJ1sO0Uhs1DR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fg4y9Pu0X1shIfSGCuacGX4CBvUdUTnWC3NX6Ml4R4a+n8abG6GFQmchxtQ0vmrcPFZW9DweQB0JsadB/owI0KBYLXZfLX3oTD/86G1AmenNS4Ei+6pv5UtCK4tcRrCefvsDbROUJ4NPExdEpST9JNBs/XNrX7Gq6DDgFJs+2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/pNKGsE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/pNKGsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC7C4CED1;
	Mon, 10 Feb 2025 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739212063;
	bh=LrSHEUWGR3qHfrIKo1moG6hK8HchQtQJ1sO0Uhs1DR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/pNKGsELlIKLxoPDcP0a9hKpMJ/C722aqX2HgUqkAWt53FMhmcwuPrY2xj/vFBVl
	 cR4valunDe1rwOwFuuulPEJXvjb0uzAmTM4wF6e8cMALZgzqHE645s5srPVkbDD+4W
	 dKlYod+/KhwfnZv86rh7nMfMsJx9KyZt2tn4UVZptMx/HxBFW98PYxP0XKuGIwaTag
	 XRHB+4TN2QAq3Qa66rJMRPfWahjCedHXxaAaabVmu6OEi2HbCcRJUdCZX4DNu+qSVL
	 gk84/jkYPjDAXbzZKUxITb7RG6BACQvVt8qbrP7lM233RYO0/alneV5cLG09WfpZS8
	 btNZtSn54q9Nw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/3] mm/damon/core: unset damos->walk_completed after confimed set
Date: Mon, 10 Feb 2025 10:27:34 -0800
Message-Id: <20250210182737.134994-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210182737.134994-1-sj@kernel.org>
References: <20250210182737.134994-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos->walk_completed is only set, not unset.  This can cause next
damos_walk() finish earlier than expected.  Unset it after all
walk_completed is confirmed.

Fixes: bf0eaba0ff9c ("mm/damon/core: implement damos_walk()")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1a4dd644949b..1d9025d14d83 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1489,6 +1489,9 @@ static void damos_walk_complete(struct damon_ctx *ctx, struct damos *s)
 		if (!siter->walk_completed)
 			return;
 	}
+	damon_for_each_scheme(siter, ctx)
+		siter->walk_completed = false;
+
 	complete(&control->completion);
 	mutex_lock(&ctx->walk_control_lock);
 	ctx->walk_control = NULL;
-- 
2.39.5
