Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D2374A0C;
	Sat,  4 Jul 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188707; cv=none; b=MY2Vx21MdGOUfIi4a20UBTYMGtei5ittDYyk6XYk0NtmuSF/Es8lwPh2e9RyAnE2t4a4dj3AHzLdGdHgnMKPZSUyqi6PDsHQVjeEeiZkcsCTHCGu0Jw0fcwqsIRc/gToLZRW2nk1a67NdcasHFobi25JLkw3AL9+4ZjzhuC8aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188707; c=relaxed/simple;
	bh=s1aLOjBmxqWX4xTdDsDiZkYLIBBhUQOGpDfQK1578/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WH5nj3VpB8lkIZJsLaFVwFkqE8EZN0Xk4PjyBtSsqJXWtptMa08BWy0WfivsoMze5iwUfBQcucgen/OWyZsL+/VF8GgWEvhTylcOAxjhZtFaJ/6AjVqBKQZRTA7v8WEYjYXv4OEPh9bm9aOE/UFjg4KLOlHmynFSZxcRoNdsdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajlcylt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajlcylt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC2C1F00AC4;
	Sat,  4 Jul 2026 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188706;
	bh=T/jrLjscVUQeC5WNYbMxUpcBegD3KHrAD9D5l1ftK2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajlcylt+UqiORqyCeCTb8OcCBeRFj+zJiG2sUfY0goWT4g8P5+WflEtIfmosxak8e
	 9YKKKJUn4F9pnMcPS9P+omTSOmGEnFzVtqR17OXcDVzf/RGuGCp5yxnEE8U5vt0NH9
	 wUOoL4CHTalE714OlsKOQUKtFQ+NnKYyxIb+yMeGtFjnc2h0IRddu5URqrBgix/6n8
	 VNxztLqrjFt/ZhdqhUAlF1BVEdogSsCV6wYJHdsBDvwxwAD9+4956//R/Ha45lpQ8n
	 UP6it/13s4olVFA3i4bYDIrwvRluvIMt1htH8rg0mfRu3Y/FV4otL6sWZ/dyHjVchb
	 iyWKiccq6tgnA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/11] mm/damon/reclaaim: ignore damon_stop() return value
Date: Sat,  4 Jul 2026 11:11:28 -0700
Message-ID: <20260704181135.132956-6-sj@kernel.org>
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
