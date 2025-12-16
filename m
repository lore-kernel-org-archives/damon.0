Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05F3446B6;
	Tue, 16 Dec 2025 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872112; cv=none; b=GCVA0z81j4DVv7FdFfZkPlPNHTmELpC31snQlxCZixIXUMlnnsD7ruZnOhKc5WlMjDyTyGHrwQrJXJJnNdww5GtMz/IYAp33kLpCQpLtkP1uiEOEoKt/GLzLGLrUWJWNeOW1ZadBl1bXD3kmMLPC1yK3vh4NjkRRkIu21jbWcL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872112; c=relaxed/simple;
	bh=CMU/MAqiw92B3IvzGFYdKBKpTTJU4mdm4PDik0TPe5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2DIFyc9RItiLLzYsOxfOW+uJC4ZVED/CZLolahI21No0vd/mvyhaIBqpXMnlx2Io6OHADJBMDmIZqEmEZArmxqafRHe54qZsBd9VmYi79fFqgcotzcNSRTDxj2c8fquVRd5QP5Q5Tf6BFk6DCVSKqWhbHhFWoscbJ9r0fKwRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubgibi1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubgibi1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2D5C113D0;
	Tue, 16 Dec 2025 08:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872112;
	bh=CMU/MAqiw92B3IvzGFYdKBKpTTJU4mdm4PDik0TPe5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubgibi1oh5rwQYBQm0dtApjfZUlrc5w0TF7s0jJdAMTPpLkeyUh0Xp79yQJAL937x
	 sqq3MwE2FgAtXW38Ew88nTKFuVBaXggJAZOjQ5eDBPgMM8pOHWHxJG8MLmNdUP1rMo
	 2bP7q1mKE4VYIcZJ5cR1+Jb36KZPD6yOMX7ileyKOIDike1DdMvjyH0Mb2QfXDGJuC
	 E0YFBdS6jWtslSndn43dkwS65KOvC7iv3//W9NnvRo1a9uY/+ego9Gl4bgqgk+0+la
	 1UbRL4aQ+p9lR/btcRC7aOD16DSIyB2sso3N6ln9TAPulZvOAab/0oCqcr4Y4w6JSH
	 eZY99cw0M3KoA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/12] Docs/ABI/damon: update for nr_snapshots damos stat
Date: Tue, 16 Dec 2025 00:01:18 -0800
Message-ID: <20251216080128.42991-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added damos stat, nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 4fb8b7a6d625..7571aa78b7bb 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -516,6 +516,12 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the number of the exceed events of
 		the scheme's quotas.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/nr_snapshots
+Date:		Dec 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total number of DAMON snapshots
+		that the scheme has tried to be applied.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/total_bytes
 Date:		Jul 2023
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.47.3
