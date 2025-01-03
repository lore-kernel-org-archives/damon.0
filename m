Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7D19342B;
	Fri,  3 Jan 2025 17:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926257; cv=none; b=ruKrblyRvRhvGTmoFA0Yr0N8uOdnDvr5s4tu5KgaKSBeAfMTgJ/fh35eBBTQLvyWb/RUQjsWRtRCBeHYS9CPPEShTKo5wDetZO31XwY9RjFOrI8Yqd0YBvA0nGUzxHe+v0+SJWMTqdk7LzoqzDfW1yOOAUGiGOSh/ZmSGR2RaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926257; c=relaxed/simple;
	bh=Qli68w9RR6OLGHO/urSk5Kw3GxzgWY+dpbdZAM29uik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCwIRWYs8v/v120x/Qtb1BXlMpS1MWgCPytTDVKzUC3fF6Pc12eLyn40CLqVr9ewABPjXC2RmTAfZaYOSpw7THcE20WcGODTcbmu5gvIBFg7wbFY7H64tSatRnsYmGPGilQ5zWApMAkwEsnfHj4jNRVXH1IHUv5MY+P6fGaw8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgU/JbFv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgU/JbFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D48C4CECE;
	Fri,  3 Jan 2025 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926256;
	bh=Qli68w9RR6OLGHO/urSk5Kw3GxzgWY+dpbdZAM29uik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgU/JbFvqWQxRNZrwv2u3F+e81eK1EgkWJYkhOHqGLuj7+9iCsEdy8uz0/EUuv2no
	 IDaP5sZ58eVF5W03tH3XdL0IA/sDRyGBeBeTprwsygO7K9AYfQdv3zJs8jfwS6yCzz
	 Az07ONWHLy4u2Fl3svvpsN7qVGh3Nbb9GkmrSrCrNrByHVxlE6iRNLxFFVAvRQdJec
	 ICTLWpnV+Fgj3ajHByMevRJKnExULKU1MfF/d3EgBupzZqtPZsxNNttxMTDzE0Ujik
	 U5LUpgi07rIR8HyHfkT2HTBaLms/BaZDA6QIGEJFx3S2zIOYfqG9WvxbfjtSzMJZmJ
	 qldWRQ/c7hwEQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 05/10] mm/damon/sysfs: use damon_call() for commit_schemes_quota_goals
Date: Fri,  3 Jan 2025 09:43:55 -0800
Message-Id: <20250103174400.54890-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250103174400.54890-1-sj@kernel.org>
References: <20250103174400.54890-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface uses damon_callback with its own synchronization
facility to handle commit_schemes_quota_goals command.  But damon_call()
can support the use case without the additional synchronizations.
Convert the code to use damon_call() instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 708c2ffdd620..7c2aa9830edc 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1307,9 +1307,9 @@ static int damon_sysfs_commit_input(struct damon_sysfs_kdamond *kdamond)
 	return err;
 }
 
-static int damon_sysfs_commit_schemes_quota_goals(
-		struct damon_sysfs_kdamond *sysfs_kdamond)
+static int damon_sysfs_commit_schemes_quota_goals(void *data)
 {
+	struct damon_sysfs_kdamond *sysfs_kdamond = data;
 	struct damon_ctx *ctx;
 	struct damon_sysfs_context *sysfs_ctx;
 
@@ -1376,9 +1376,6 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 			goto out;
 		err = damon_sysfs_commit_input(kdamond);
 		break;
-	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS:
-		err = damon_sysfs_commit_schemes_quota_goals(kdamond);
-		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_BYTES:
 		total_bytes_only = true;
 		fallthrough;
@@ -1543,6 +1540,10 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		return damon_sysfs_turn_damon_on(kdamond);
 	case DAMON_SYSFS_CMD_OFF:
 		return damon_sysfs_turn_damon_off(kdamond);
+	case DAMON_SYSFS_CMD_COMMIT_SCHEMES_QUOTA_GOALS:
+		return damon_sysfs_damon_call(
+				damon_sysfs_commit_schemes_quota_goals,
+				kdamond);
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
 		return damon_sysfs_damon_call(
 				damon_sysfs_upd_schemes_stats, kdamond);
-- 
2.39.5
