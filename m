Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534613;
	b=MVdLO6BnL6LAHr0/BKsHTAjAxQk9uU61AppmNlCY99yeAdINHc54QTnCbuzxuvrQ6a4U
	 V2jXDHIzpxpu38xLiUbNIBi3mT4+TJWT3uk93LLOrLuwSyF8olsiCUqzqFqtxmRhZkn1e
	 xZUtIqxO8Jcp+Y6i+MwBV4swCz4YGR1Hi7gg7kf5LX6Wc0G6Cxo9eEmlI+P87wJ1BS6h4
	 PO9Z5A8uhOVBc/72EcyrfM+JNiFLCmejDmOC35Y0pyZOjHd1q9+Soe7Aa78v9lsQ0wfoL
	 eq8gyyhAKYqwfNJHmERp1gUEHo2aQQ7/lKRAkUAdEkFRZmg1WUz06f7E5HAj8nIupdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534613;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=biXTWaSvJqqpcUUoUjddCAvbnOUyLvQxAIn/hPXuU84=;
	b=EnLXyapzJ5tdNAnrXsrGClsc3c0k5kmOGG//ewN6j7cooHSOcTJ1k8did6WUOsqh5wtm
	 vV6Y3Af3IWP7lXM/0M6jU2+/4X4swZwA4OhT2iVVqCvGLfoDX3lTzG1tg6fgNdQFxb76o
	 JovFoJYQJu6gYMJkb1d8aPXE3nKNnBn2VoxgniJClb60kNpic5kdk+YUaF+ThzAZBxyx1
	 Jz2gqhePjaEQF0qIHgd20HlQ6PU2BHcshGnnve1gZjpQBJjMc2vwNjK5iLmaYIPrUEoVB
	 BMRFyxqmwBFsRcZqGPQa6q+1D+g6OKs20daKMtUbmRrI0EVkYBne1Q951EFecRERtRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAjjkP6H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924E606A326
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAjjkP6H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8219B1F000C4;
	Tue, 24 Nov 2026 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534612;
	bh=biXTWaSvJqqpcUUoUjddCAvbnOUyLvQxAIn/hPXuU84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JAjjkP6HpBkGxa67ba014jvwH2+hY2PZmDcbEUwv8Tt8O0BccP3/QCZ8u6l5hmLG7
	 eIKc3LzwyJ5uKEd7k4AMLQkma2bYMNcnQE5+2o1V+WFs3qVzFywkutSfnFm7aOXTrM
	 gOOJjDZw/QP+893zYpPgDoc+yeupkN8dSSZJfmFs13qMbkRUsXyp5nrYpRN58QRB4M
	 Rzd9KQhdf9bgCMAZWuA8mcl2och9J1DWD0rALpTL0NBth+rK4YND+m80ele3IUDEZ4
	 UjLiGzOPdvb6YD+g0UtrnndK3fNDYnP3F2n/F1nUThXEaFT0C0JejebtlUJJkbxfGw
	 uk3rta7DlFY/Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 11/27] Docs/ABI/damon: update for report producer sysfs files
Date: Tue, 24 Nov 2026 07:36:17 -0800
Message-ID: <20261124153636.91854-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added data attribute report
producer control sysfs files.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 92348178e48a0..b5e5004ec9fb7 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -702,3 +702,23 @@ Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
 Description:	Reading this file returns the number of data-attribute
 		monitoring probe-hit positive samples of the region.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/nr_producers
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing a number 'N' to this file creates the number of
+		directories for controlling each DAMON report producers
+		named '0' to 'N-1' under the 'producers/' directory.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/report_type
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets the type of
+		the reports the producer will generate and submit.
+
+What:		/sys/kernel/mm/damon/admin/reports/producers/<P>/producer_state
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	A file for requesting actions including enablement and
+		disablement of the producer.  Refer to
+		Documentation/admin-guide/mm/damon/usage.rst for more details.
-- 
2.47.3
