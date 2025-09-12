Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7553F23ABBE;
	Fri, 12 Sep 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644800; cv=none; b=N3OsCwWR/KgrPy5nzKIo4L4Q2DCte+b2aH+gMg38Uh/1Lq1bm5z5Ba1GqFKxDS3FEOWPKYDvd1XDiO2ZOJ1dsPFJmE16ZJQScOVmDbFxfBDKXvGO3pA+3cBJkXq1gBvwKGcgSD9qSMHiLM8FXgVNbixedj9790Vg0kaMUv+R5bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644800; c=relaxed/simple;
	bh=4uQscG4mYr4g+dERacoLlCCtLcp3o3ScovLzzqmdpAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OM3qbs12yywPnKKYsGR9eunq3iItubpUWof/BpFe/ArXHNvbui0/xm/zRvSdgNpGPPfQLXdFuhXZA7fcEU95VM6ge8M3uADhpQDWJlxWufxUMV7lhlJ9YxCuEgwIsUPk/+bh+gcCLWMoJgeukxcLV1Fb5t32TeqmRrH2fWZzoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jknMytDh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jknMytDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF9CC4CEF1;
	Fri, 12 Sep 2025 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757644800;
	bh=4uQscG4mYr4g+dERacoLlCCtLcp3o3ScovLzzqmdpAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jknMytDhn7nH98vCJ2dHC23SjVhQsA7hX+cBhn4LpIR29BoB46OaU5hnMA1/Qzgo9
	 nqj+qbImVWHWeUwPwbCQReUvKwxq89ndr53Z2gXBpCFQl2J4S0zkQo0OPuWvgnjuUL
	 7czcLLS3K1iZjTLeysSyJJGWTkmWo+HPNar+zD7snR/EhsfupSTmRtMpVjfQJnkkd5
	 AUvtI55YVd0NxkNULBTEWG8CDdyzULDgdmO78DOe2uPNFYWt+UV68i61p5MficOXMX
	 eKGaW5X4GzuKz+bZAqTAXUga9ErisdgD3M4JpamvPRA0i0gkJzDIO9XxAZ+fPUjoy2
	 N2iNk7JcRnxMg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 7/7] samples/damon/mtier: use damon_initialized()
Date: Thu, 11 Sep 2025 19:39:46 -0700
Message-Id: <20250912023946.62337-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912023946.62337-1-sj@kernel.org>
References: <20250912023946.62337-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sample_mtier is assuming DAMON is ready to use in module_init
time, and uses its own hack to see if it is the time.  Use
damon_initialized(), which is a way for seeing if DAMON is ready to be
used that is more reliable and better to maintain instead of the hack.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index beaf36657dea..775838a23d93 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -193,8 +193,6 @@ static void damon_sample_mtier_stop(void)
 	damon_destroy_ctx(ctxs[1]);
 }
 
-static bool init_called;
-
 static int damon_sample_mtier_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -208,7 +206,7 @@ static int damon_sample_mtier_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
-	if (!init_called)
+	if (!damon_initialized())
 		return 0;
 
 	if (enabled) {
@@ -225,7 +223,12 @@ static int __init damon_sample_mtier_init(void)
 {
 	int err = 0;
 
-	init_called = true;
+	if (!damon_initialized()) {
+		if (enabled)
+			enabled = false;
+		return -ENOMEM;
+	}
+
 	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)
-- 
2.39.5
