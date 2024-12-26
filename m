Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A261C54AC;
	Thu, 26 Dec 2024 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251303; cv=none; b=iRl53geeW2LA5a/1VMKGpZr/IFbYAYI3umXU0VlAmMdhhI6tnEcOo8X5tpzHIV96pSFKKK6RvScjYur9jocZt8LqY9+BtpF25FAfAM9YBlGXMU3lB1jHXILhSotsBmaY5jwPPKqzWR7jWAAlKZi8iqEGONpF/z6rv0PPIe12o9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251303; c=relaxed/simple;
	bh=SeMHzC1M39t8q6CCCk8soRnhB4lB7Sy3qIRyk7EYfrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JwXdFabGFqNyIBCDc0FiRPqeLqAo8lfXd4wwojpjjxLapzv/W3n+LTNh4IDbjxQ+Yj22kYnzmWYA+xnUVfVL5EycBBExxKdE3az3id3eSSo6z/JCIiWROVZYr5BDIBTBulZsBSdfn78nng6TLyz3fLTNPA6vWQmDtzve8jA7LBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQElKYiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQElKYiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503EC4CED3;
	Thu, 26 Dec 2024 22:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251303;
	bh=SeMHzC1M39t8q6CCCk8soRnhB4lB7Sy3qIRyk7EYfrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQElKYiZrPg10ZTDGDGyOYXrYb40QGFH1A9Y1Nu+H2xaepgLZrm/1KOAOPnpknTJM
	 SmP9DEpnyiJ+XJFxdT2OadsMaV1fnfgO8i3WagP7Qr0nZpl3nn7xrUrhx9qlzPxeGr
	 1iltpyUwvAxgkY4reWZBID4op2SRkyO1WWlfWo2ZPYrLAFgoVFeIgkR6dbA5Fqr6Mj
	 DgfSG3uP2K5EiMtRjSqSKmzOSubKrTR6wIVrFRfpneJTvThwlTFHlpEBX8HuwrmUPr
	 zPCPzDUo18dVoUrPk3dcUE0DO3ub++l8qwhumfRJsKly23bi683QmfcyQDauxw5AXz
	 HuVVFKKHEfaVA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 04/10] mm/damon/paddr: support damos_filter->pass
Date: Thu, 26 Dec 2024 14:14:39 -0800
Message-Id: <20241226221445.78433-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'paddr', a DAMON operations set implementation for the physical address
space supports a few types of DAMOS filters (anon, memcg and young), but
ignoring the ->pass field.  Update the logic to support the behavior.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b0c283808ba6..71cb02128b46 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -198,7 +198,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static bool __damos_pa_filter_out(struct damos_filter *filter,
+static bool damos_pa_filter_match(struct damos_filter *filter,
 		struct folio *folio)
 {
 	bool matched = false;
@@ -237,8 +237,8 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, scheme) {
-		if (__damos_pa_filter_out(filter, folio))
-			return true;
+		if (damos_pa_filter_match(filter, folio))
+			return !filter->pass;
 	}
 	return false;
 }
-- 
2.39.5
