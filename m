Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B7243376;
	Sun,  5 Jul 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267314; cv=none; b=sTJtMQ/dA7Tiv5vKzEVsNiJ/hknZujtWzYLz7xNIiTfdGuAj7CMpyOJmz4iELCGvrHfCtEBo4XwYQd1RELD+zrWZDldtMq3BqGMynz66exX0zbxRT6c6K8xWz6ywgyTiWBsuJqPOKuObbkR9m33X818KOYQhpC5Uhl3uRu6BDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267314; c=relaxed/simple;
	bh=s1aLOjBmxqWX4xTdDsDiZkYLIBBhUQOGpDfQK1578/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX2E1XEagcR/om8JV/Ioit6GVzAFheQ0IZ6hjoaa6dICJEWlcMdXjyRLKJHoBa6skLIOvSRCtO0Nq9kAJdX3TF2BQoIxUWcfAletp3RSE6CHpD2TxXxQ85P2N6iX+PLzacxNjr2NjNzqfihNW/qtCfA1GseqGhn4A2axwDHjwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7tYCkxH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7tYCkxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DC21F00AC4;
	Sun,  5 Jul 2026 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267313;
	bh=T/jrLjscVUQeC5WNYbMxUpcBegD3KHrAD9D5l1ftK2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H7tYCkxHr2G/yFxI2q7qBK2oZe2gwO/jCTeRnC2uC9RITAognzUvh4xOmaiuUy/SK
	 SGfMukrW69CKjVyZpUTBAhsBMEUogrH4H9hQlmX9Ikh/mCcatM1U/BGsWyPvKUHCra
	 rZiU3xw8l25YtqLE+nfujY8QIIFBDCn/jTPl5HpLZvSGon5XJNFaYJhSWbQau7rnPm
	 bjAZzrZ8zpXqbM63njuyMtbSxL+23/zSNk84VTyzeAlwKYF+B5RALBf4filf78aDDs
	 rt7e5MleckMDy5KB/v7NCZ0ZeJtpKCFHuFIPaRULVTxrwUVDtFFgy0Jgodq/EtLV3E
	 cKAVrYkPbaHCQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 05/11] mm/damon/reclaaim: ignore damon_stop() return value
Date: Sun,  5 Jul 2026 09:01:32 -0700
Message-ID: <20260705160142.97308-6-sj@kernel.org>
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

damon_stop() return value is guaranteed to be 0.  Ignore it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 6469b25cc34f9..09e941d75f67d 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -332,8 +332,10 @@ static int damon_reclaim_turn(bool on)
 {
 	int err;
 
-	if (!on)
-		return damon_stop(&ctx, 1);
+	if (!on) {
+		damon_stop(&ctx, 1);
+		return 0;
+	}
 
 	err = damon_reclaim_apply_parameters();
 	if (err)
-- 
2.47.3
