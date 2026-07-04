Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEB376A0B;
	Sat,  4 Jul 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188708; cv=none; b=ngy2hBZKVQVKYo+SlI0vGRuNgpvcsmRCeEsNt/2rK8eyRn2Y+sj7gSndZCnoGboVhpy/6Mg2Z+Sm96I0YvHACCYwJFpYfxBoKNrYt+THgddoMOmZhEmxaLBhr1uVDl+hoOGxwC52eBjax4cPbDGTYGGeXVXQqEflVlopsqS6aVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188708; c=relaxed/simple;
	bh=zw18eCF9o/kXw8UfeN/aNgCviJlDOibZN7c7tPL19WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ejc3QDOQzDyGbG6sDGOvg21bqR394FSP1lEv3Lxxfd0MLyRg+ltKqGPxsv/QlTlNZxeNuMNN7iSypY8YCW+Hgwj1PjdRZHfKBRA412A5gM/Lz6R88e6ZRdgYeinmyFo8ur2WXEOOZo1cXrlc8aJBduuq6wBVU23YyBB3NpZA9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmCT0NMX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmCT0NMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A5E1F000E9;
	Sat,  4 Jul 2026 18:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188706;
	bh=XifFyfJolobUF4kXii9SDmtvZzvIFxqywQe1D4fl4uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PmCT0NMXtHtarzpNnYd2A4XsQlNSi3rWrzJgdVmhZSsk+Bsuw2GgOOJnd7r3T4dD3
	 JIQ/oDsFMUFaAW3VoKzqWCrdZ/Uyd56TqmhZFarqffeC4IKmZiOOYYMCFcrLAbVe7+
	 i7KrZXj43SLgkgJT5Jgvy7BudRLZyYN1p1D8eyPlCsR7Sw0ps+cKzP4GImBof8dP37
	 n31OMNsN3JSftnNnGA16mfmwu85tmgivK6ktMkawmN3HJF40rt0dxz0hK/3CUmE1yv
	 UtXUaPYYSGnB4uhuiXjxT+AsjuUiwowWLKIsE5nVXfSzO+KFYl9aIoA9FH5wv4TESi
	 DVG4VIUvepmsQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/11] mm/damon/lru_sort: ignore damon_stop() return value
Date: Sat,  4 Jul 2026 11:11:29 -0700
Message-ID: <20260704181135.132956-7-sj@kernel.org>
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
 mm/damon/lru_sort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 2dd0cd0d26273..e8c389ad3226f 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -409,8 +409,10 @@ static int damon_lru_sort_turn(bool on)
 {
 	int err;
 
-	if (!on)
-		return damon_stop(&ctx, 1);
+	if (!on) {
+		damon_stop(&ctx, 1);
+		return 0;
+	}
 
 	err = damon_lru_sort_apply_parameters();
 	if (err)
-- 
2.47.3
