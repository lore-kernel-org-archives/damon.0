Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9926E976;
	Thu,  6 Mar 2025 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283962; cv=none; b=NJF4H9mwRjQ/KUmBZs8Grqql83DKVT/O9pJ7/AXJKN2uCFkglRyJfi/UxDdVyg6LlOY8i3xSMX9MJLkswdRH+6PGiAb5EWCjXU2NOTKk3PmHpeEkw4FXp5+ny5CIcSLDvctDlpa3IxEHx8BtqH9do/5xE+d2C/+rne3UhM2OHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283962; c=relaxed/simple;
	bh=GLzNjNzoqFiPhTNA5KWvEmI61gvwVWoLHB2Kc36Fd2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M2MjxyqEMsla+kMpp2xHHTOCzaUBxNOF2vAmrbXehTE4OaVhZVnAs0Pld1QskJ4lAXIXpjOFhjQeNbQ+rdeP+NgXK/5DBP4oYQcXOW6bl51CrICwODRV3LJ6FOz9pKcLD7WMUHir72+M6ZU+wePjJJ+FRV8LkDE0fLvfuqfvipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erZYTq86; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erZYTq86"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648EDC4CEE9;
	Thu,  6 Mar 2025 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283960;
	bh=GLzNjNzoqFiPhTNA5KWvEmI61gvwVWoLHB2Kc36Fd2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erZYTq86Muoe+ngK+l8uFZkQmK24b0sIV9xkOZI/wHdKgAlqF07w3QclG8rJUEtt8
	 azNg2lsCWGWyyEVOh2ak4BD5Io128WbCrygzc3VC9UX3mmg4z0nbeqAsdZIUTuzcxD
	 hG84wS3cy6s1nK7AFt/uQaGaFILjk74/2GkbNcrpDKsef91CysP4SGpiDYXw+MlCF0
	 hGtD4DsYsf2qA9K4v14hBqp1GE0GXtsAVGkkezSyTMNlKvCMFt6GoEJDIsAR8CTjgn
	 eELoCkIQRv7gn9Bj+qMd90PhpcARNPlobRsIjOb2VcQEdd1i0bjZMDSRUFsDyaDVHT
	 eZqtABr7ZuxxA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 07/13] mm/damon/sysfs: remove damon_sysfs_cmd_request and its readers
Date: Thu,  6 Mar 2025 09:59:02 -0800
Message-Id: <20250306175908.66300-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306175908.66300-1-sj@kernel.org>
References: <20250306175908.66300-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_cmd_request is DAMON sysfs interface's own synchronization
mechanism for accessing DAMON internal data via damon_callback hooks.
All the users are now migrated to damon_call() and damos_walk(), so
nobody really uses it.  No one writes to the data structure but reading
code is still remained.  Remove the reading code and the entire data
structure.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e5bcf019086f..1af6aff35d84 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1238,25 +1238,6 @@ static const char * const damon_sysfs_cmd_strs[] = {
 	"update_tuned_intervals",
 };
 
-/*
- * struct damon_sysfs_cmd_request - A request to the DAMON callback.
- * @cmd:	The command that needs to be handled by the callback.
- * @kdamond:	The kobject wrapper that associated to the kdamond thread.
- *
- * This structure represents a sysfs command request that need to access some
- * DAMON context-internal data.  Because DAMON context-internal data can be
- * safely accessed from DAMON callbacks without additional synchronization, the
- * request will be handled by the DAMON callback.  None-``NULL`` @kdamond means
- * the request is valid.
- */
-struct damon_sysfs_cmd_request {
-	enum damon_sysfs_cmd cmd;
-	struct damon_sysfs_kdamond *kdamond;
-};
-
-/* Current DAMON callback request.  Protected by damon_sysfs_lock. */
-static struct damon_sysfs_cmd_request damon_sysfs_cmd_request;
-
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
@@ -1555,8 +1536,6 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 
 	if (damon_sysfs_kdamond_running(kdamond))
 		return -EBUSY;
-	if (damon_sysfs_cmd_request.kdamond == kdamond)
-		return -EBUSY;
 	/* TODO: support multiple contexts per kdamond */
 	if (kdamond->contexts->nr != 1)
 		return -EINVAL;
@@ -1796,8 +1775,7 @@ static bool damon_sysfs_kdamonds_busy(struct damon_sysfs_kdamond **kdamonds,
 	int i;
 
 	for (i = 0; i < nr_kdamonds; i++) {
-		if (damon_sysfs_kdamond_running(kdamonds[i]) ||
-		    damon_sysfs_cmd_request.kdamond == kdamonds[i])
+		if (damon_sysfs_kdamond_running(kdamonds[i]))
 			return true;
 	}
 
-- 
2.39.5
