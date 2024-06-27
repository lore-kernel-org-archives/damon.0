Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE54197549;
	Thu, 27 Jun 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505916; cv=none; b=EaZ2jfUhF/oB9T4oUJdZbTcYtEbXpn57BUUPh5pDK61wD8KNwl/DyJRu9Fgda3h+daGPnSiOhm/tvsu6S8944ZetFjdJSfxdLhh46KUw+zKXWkDo70qyqL1caD9RBJJ/AaEzCywfXUwctIVQoZ/aIzGqeUDcTHvAjks307aQxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505916; c=relaxed/simple;
	bh=K7HK9pvJ3k/n+EBt+3nbqeH9P6nBJxh2AMU21utMS0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=arOqrCCmJgRhmLDPYFkEMY6DCBKum2T7zuanoHEVe0Dx3pi0txgRA0M2EWTib8BTmQl/0jjHgR2WLRANspzqlhyM520xjbuZ1wk2Z8cLlHCWz4aqPPENZUOTz9avOxR+bqdNYoXHhwM/vQuDgYR8LO6F6bONRyFYlnJ7acJ2rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCfPgCWR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCfPgCWR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B464C2BBFC;
	Thu, 27 Jun 2024 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719505916;
	bh=K7HK9pvJ3k/n+EBt+3nbqeH9P6nBJxh2AMU21utMS0M=;
	h=From:To:Cc:Subject:Date:From;
	b=CCfPgCWRg9G7mm//F0eKLYxF2rqm/LyFg20mnANA3CAlMbj25dA9JnxKn8pOrkJ4F
	 M3r5ck+d5eZ03z7qwaZyd75hjxAdTnBqr+l11xl+HbdjCQPE/cpz6aBNh5vw74Mxqp
	 wRUzXCKkXIXVtSNIYdrwpz786Eg7UUlDNc0s3eHTqe6WEAh/qnMHN87W6qJYUMFlpt
	 DXSJr0h0dhmvgqVrskLZQ50Kn+D9gTYv7tNBMyTAjyD6Ne+kswu74QTkxa+AQuGEIH
	 VYutq/mtj5ZGiIpXXK7rMsFU98Ti+3TBHORp7YEqNaNY2dJgLAaS3NRKFxJ885l8HE
	 XD9pBRqBHHHGQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable] mm/damon/core: ensure max threshold attempt for max_nr_regions violation
Date: Thu, 27 Jun 2024 09:31:52 -0700
Message-Id: <20240627163153.75969-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit ed6cb9d022c8 ("mm/damon/core: increase regions merge
aggressiveness while respecting min_nr_regions") of mm-unstable,
kdamond_merge_regions() stops the repeated merge attempts for meeting
max_nr_regions if the merge threshold that increased for next iteration
is higher than the possible maximum threshold.  Hence, it can skip a
merge attempt with the maximum threshold depending on the amount of the
threshold increase, the maximum threshold, and the last-used threshold
value.  In extreme situations (e.g., region 1 has 100% access frequency,
region 2 has 0% access frequency, so on), this can degrade the
max_nr_regions violation recovery.

Fix this by stopping the loop by comparing the last-used threshold
instead of the to-be-used threshold, and if the last-used threshold is
same to or higher than the maximum possible threshold.

Fixes: ed6cb9d022c8 ("mm/damon/core: increase regions merge aggressiveness while respecting min_nr_regions") # mm-unstable
Closes: https://lore.kernel.org/20240626214954.46143-1-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dac27b949403..7a87628b76ab 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1718,7 +1718,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 		}
 		threshold = max(1, threshold * 2);
 	} while (nr_regions > c->attrs.max_nr_regions &&
-			threshold <= max_thres);
+			threshold / 2 < max_thres);
 }
 
 /*
-- 
2.39.2

