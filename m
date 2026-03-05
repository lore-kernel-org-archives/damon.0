Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6832882B7;
	Thu,  5 Mar 2026 05:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772689167; cv=none; b=GuiJTryOQlQutKNgD7gm/gxJLOfVo2dTatIUqIGFvxruzZrLwJ8k/UlysNbVaEC4WD4JK9OZAhfz1qvTTqLj5XGgISYZtv4HuZ4hX7xZ357LLKAa6SxG218Lb3aHZvzmPQYg8aw8oFNvhk5eqK2lwc1DnhNzUNwrBLloyuqeeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772689167; c=relaxed/simple;
	bh=kZ7koKz8qVMB9D4eDY9APGuQt2En5THDUr0Tf4sclNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWZaDCa7EbCCqi5tUTaUTHY9MOe1tazHPtoGDbJaLSF+JWLErlAVLNwDyyYS4WKvQDGcn3vEb+f6nNdVFIpoct22W5DO92jLvm3OILWi0pFNWm4NXOG7RvMEPgp2wEmqohv4qWHZwInbnXMqbrDA9OCpdF4z1IfMCwFDu3UbaXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFxfg2G0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFxfg2G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658DBC116C6;
	Thu,  5 Mar 2026 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772689167;
	bh=kZ7koKz8qVMB9D4eDY9APGuQt2En5THDUr0Tf4sclNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eFxfg2G0MgGzE6YO6yM0TECJsgz7CkfK1YkIMVCHdR2GmW+C9Ip9QJk6GN6HOVUDp
	 FQ1+rIWi4WnjADGn5r1raE8kZscNrzDg1SRHnLh4b6/YbAwj9/kMKnFu2IRJDYVZac
	 w7tBvrdg33heRurOcaFdAz40Pf0Dd4wJL7q6OVtiQ8GaVFu4mwm8UwhuvyHOvjMmPi
	 Ba+DhAOG1FKH8YkqbKX1LoHmTO4zbpUhzRoSbMIVhuV9chljNyY2b/jOsSb6PHqlte
	 QXrL9p5SSA5wA7QtlsLl36i8NJqHDeKbgkbcGs4oMtFUOqJ6T8DzGKUe4qovPMuImp
	 VsLErYTguWahQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/5] mm/damon/reclaim: respect addr_unit on default monitoring region setup
Date: Wed,  4 Mar 2026 21:39:16 -0800
Message-ID: <20260305053918.83786-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305053918.83786-1-sj@kernel.org>
References: <20260305053918.83786-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the past, damon_set_region_biggest_system_ram_default(), which is the
core function for setting the default monitoring target region of
DAMON_RECLAIM, didn't support addr_unit.  Hence DAMON_RECLAIM was
silently ignoring users input for addr_unit when the users don't
explicitly set the monitoring target regions, and therefore the default
target region is being used.  No real problem from the ignorance was
reported so far.  But, the implicit rule is only making things
confusing.  Also, the default target region setup function is updated to
supports addr_unit.  Hence there is no reason to keep ignoring it.
Respect the user input addr_unit for the default target monitoring
region use case.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 01f2f6cdbcdfe..86da147786583 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -201,12 +201,6 @@ static int damon_reclaim_apply_parameters(void)
 	if (err)
 		return err;
 
-	/*
-	 * If monitor_region_start/end are unset, always silently
-	 * reset addr_unit to 1.
-	 */
-	if (!monitor_region_start && !monitor_region_end)
-		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
 	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
-- 
2.47.3
