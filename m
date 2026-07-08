Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0C3B1EC0;
	Wed,  8 Jul 2026 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478946; cv=none; b=pnS99cl3eNpveA+rVlc2lBn5gYKOolaObkGKqw9O0xA9T9/vrrMh57o+ZcWj93XGUXm4Gva8OkabWqAXI1TcavfyPuj97xhv9JiIdbHfSe75dTYvTcCOQxToDbc+RD1lpPtaX+TD+P1FQqQHhbdlr2RjQIEcc7Fit3XP2ThI4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478946; c=relaxed/simple;
	bh=N+xN3CluLOBOkn9xtHqn16aeWaAwK4USSNvEYrH9q98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBny+peCq/ISHph+opxLjxb1WweCyHX/kt1xwR800b+LWoC0oquDTCLvQG7XAdL4d15LOGbc7RD7AHfvn7/NlCHl0UsjDKAQNdIxyrmqfve+E9GdODDSMBZCgdN21KKRgLZoVyJnDyf//+Waxu7APwe2ilh90ZHK/0j7Zu8lfzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7da8BrI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7da8BrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE22F1F00ACA;
	Wed,  8 Jul 2026 02:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783478945;
	bh=oA5QgRVwAQqXAsPa92ekv3Nt4l6hxznyCttmnCPVif0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7da8BrIJPZiSZ1wFMxO5mAX6hj4rbKZqjgz7wFXXNOYtJ3yi47fHcMAptnSsNWaJ
	 UrOD+afHUSLgDQilipphYZBdNWJba/MbST5R0FtRQcnP9miN/AzoRq3iB3lykybUdv
	 lmqRUukNoEhhi2ilz9tOcLmJwwPiEyBDKSuFyReBC/Q6A1wtDMW8MJNIsALLjdzSX7
	 OUfO5WdrfTwZl2+PLhPNSsBiqt3dOnyCPP3aU61VuU1G9Uhlbnvo3+cKFSzs/50lwC
	 VNKTcIcbWAnObHatGV3MxSb9UYt1WFCBh2Lrd0NZfWix8vsHopALi7qvfslZef+TIK
	 k6ViS9s4LKQLA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Date: Tue,  7 Jul 2026 19:48:50 -0700
Message-ID: <20260708024855.116614-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708024855.116614-1-sj@kernel.org>
References: <20260708024855.116614-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_to_accesses_bp() actually converts a positive sample
count to the ratio.  Rename it to better describe what it really does
and not confusing for more general uses.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dea63083917b0..718268df27fa7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -883,19 +883,18 @@ static unsigned int damon_sample_bp_to_count(
 	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
 }
 
-/* Convert nr_accesses to access ratio in bp (per 10,000) */
-static unsigned int damon_nr_accesses_to_accesses_bp(
-		unsigned int nr_accesses, struct damon_attrs *attrs)
+/* convert sample count to ratio in bp (per 10,000) */
+static unsigned int damon_sample_count_to_bp(
+		unsigned int count, struct damon_attrs *attrs)
 {
-	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
+	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
 }
 
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
 	return damon_sample_bp_to_count(
-			damon_nr_accesses_to_accesses_bp(
-				nr_accesses, old_attrs),
+			damon_sample_count_to_bp(nr_accesses, old_attrs),
 			new_attrs);
 }
 
-- 
2.47.3
