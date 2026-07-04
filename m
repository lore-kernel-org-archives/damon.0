Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35436C597;
	Sat,  4 Jul 2026 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188706; cv=none; b=sGgQzmS6UP586/dxtH8fKw6iCBY1ys0wpj9kyEYe7ZYr+pwxNMlOFrQh2RlseXLTSbF+nsr/vBe00295oK2sLfpK/3lhfjiHAbWgPMhD3KPoFeAvrDd72++3FlzeWVsUwjYxbCt5OSgbrDCPjXzG25oEWIEHoNZXOqLhEtHa/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188706; c=relaxed/simple;
	bh=rGMOckq2Z4jV3KIRFm5J4rmu/1RdqBF1LSIrqcYHVSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK9Jyw383xs75g23f5OmMGzIKoZhxtsFt6V3LlATBY6MWxw9Ys1tBZ1ZOIEuV9jnmmWuBkyzI7jqEFMAROI59LuKXAPSSpfx0hREtJC3wgssermOqdioD4nNR66EYQ4pX6qogUcxYpql2/4o1MQuPaqj0rM+THwtvk0Dx070sKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDVRcrhB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDVRcrhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE2D1F00A3D;
	Sat,  4 Jul 2026 18:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188705;
	bh=olFdFfKM+xhZk7bT8mfvZKSUiKHFir4KbcqXYJV6Ncs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDVRcrhBwsub7eqVFNZ9z68FATqkCed2A9ODsn4DLnvuLFaodv3EDW2+Q1ommlE7K
	 RHOumldPU4kfEoTVS2FgAHVYTFT5QvUsTRW8srZAQUblRlgxiEfpJnigR4XZzyZkCq
	 vSIVhvPf3KWmZY+mlIicRgwbHx9xeU0r1Vb/ta3XBdKUgEAtJznfDAW3meAzkCOKkW
	 7PO5eXFacQ0edDPaUwdYA9JB98joMg2HPPESRcE5MiVeQkEdW4tQifoAOS4gHr/ipM
	 g/fZ+BuGhWQXXwVr3jQ41wMC2FPOEOmfxUCuYBVMDPQcO8XdvdNMH29KnRtGWSqtOR
	 9Ea+uuZlym/+Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/11] mm/damon/core: stop ctxs in damon_start() before returning an error
Date: Sat,  4 Jul 2026 11:11:24 -0700
Message-ID: <20260704181135.132956-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704181135.132956-1-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
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
 mm/damon/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3c5a46e1c079a..16d9223c33a72 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1909,8 +1909,10 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 
 	for (i = 0; i < nr_ctxs; i++) {
 		err = __damon_start(ctxs[i]);
-		if (err)
+		if (err) {
+			damon_stop(ctxs, i);
 			break;
+		}
 		nr_running_ctxs++;
 	}
 	if (exclusive && nr_running_ctxs)
-- 
2.47.3
