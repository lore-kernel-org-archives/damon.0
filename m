Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F2378D8B;
	Mon,  6 Jul 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346800; cv=none; b=UgybDj0cC68oT6Jsj9LuZdBBIZm+uPKx0tNukV7Gk7Fm9gN/PRlhUoTfwe1HaGcknLg4m8ts+9Ojp8BHKsFs/Ia5nbDNQiH/RQrcZHVKX2sVm/88PSy5dg8pKeQzx1G+orwC9qdAbh1NXRSEcwPl0oEoaBeLxPVI5CSchx1vn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346800; c=relaxed/simple;
	bh=s1aLOjBmxqWX4xTdDsDiZkYLIBBhUQOGpDfQK1578/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUiyEyWnimwdLWju/EwyVrB4Yuop4ScFv0/Y0jSUMFvxblXwNu3HHpICvi4LCVEYULB2RBlCS+lbYJzVfSyf1O2brIpCI0vS9SuAN2KpXInzXKvQjvpOMsWok0QKiyDS6XITYLzUEWjT6GWLcWigB1zW6nxVIsFLqlwXVrnfac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmTaSjlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmTaSjlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD681F000E9;
	Mon,  6 Jul 2026 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346799;
	bh=T/jrLjscVUQeC5WNYbMxUpcBegD3KHrAD9D5l1ftK2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmTaSjlSkck3iwEj9gVhrXicm+CzO9c1+gq57cboB9Ajg0W51Uf3h5owdMfar2Een
	 WOYIrjkcbGNC328qPCH664pe+E6ekkiWWQJs9dvTDSkf5Us26DOzKc4RhzIIDFnbxc
	 TW1TFqHIFn9hBdcE2hQR6PcDBqceZ+vo8DlI7lS4hqmKQ143JGP0+bBNw8xuEAA7aT
	 nk+GTzqEvQ3pbqGGXpQzdQoR9wVZVx2266sYuayl+dTTyJt4xwW5P0XJvMKh5q/DBU
	 timar1zT08KGl2y5qS61Cp+JPb21i/9qt5AfMsDA3V2xF2H17ZwUF7EjS66h6z6V0K
	 M0v9b7ajjXV4Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/11] mm/damon/reclaaim: ignore damon_stop() return value
Date: Mon,  6 Jul 2026 07:06:20 -0700
Message-ID: <20260706140628.87414-6-sj@kernel.org>
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
