Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3454C1A8F75;
	Fri, 13 Dec 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126802; cv=none; b=j3DaDxFILgBfM/8EPnAJAiPuzqrIMe7VLOT2yfC8G2Om2453z55lu/oTeKR+gwDpdAt+0sQByb7iSz8AHwagTE4JsMSthgisBrcvwOY1fmjg1cO9054XO+qp2F9QkkU+lTogbXYecVg8yR0PQRI2i/c+c1CtX8DanZDRkagjV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126802; c=relaxed/simple;
	bh=FCh8a972zYqAWkurp7V4i9/Q5lpzQYSovyP9XVSlO7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EbGDQcIe2HoC4O5k1UpVKwwDYLTVOTzhDS2+Ied5FZLM1edxfwi1tDn9jzrC9MWn5A2rw1agXssXExZWPPBHnnzXquYF0qiYeRLS3pKN8tHlywT7kMsqFq5b+ualqqXfX6MtCgOZLy+MwNeBM2gGnS6RbRv5qpBMrNWj1PKsFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mESrzqYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mESrzqYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E025BC4CED4;
	Fri, 13 Dec 2024 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126802;
	bh=FCh8a972zYqAWkurp7V4i9/Q5lpzQYSovyP9XVSlO7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mESrzqYbfUdBHy6ECESgpIB7ns1eso/niqE8lgDzC14iji3R2caZzJIdB121YcKSA
	 8usUtKuIPKkO/x3wdfnm3dAQkxrswObf5qC8QijOuBtxK/T3uxAAQQ/8qreOYKuh6Z
	 1NvECbd4WtD5wK8m4kksLRl8GuDTjNzZhMp/TYB2CNMq60Wi7Fg2oAWh18BO6pNiDO
	 IV2UBs9Koal3A7QNNrWVbA3XdCYhxss0yiG5F0OyP8krUg1xLYWB7M92oTuKlJLrkM
	 rer32ycbaMVQDw4eoOUAVBerPN2QKp5fCqaghHGGtPKKgFHAN89WUp2h7CICRGBCUC
	 nCWH2nqhD4d5A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/9] mm/damon/sysfs: use damon_call() for commit_schemes_quota_goals
Date: Fri, 13 Dec 2024 13:53:02 -0800
Message-Id: <20241213215306.54778-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241213215306.54778-1-sj@kernel.org>
References: <20241213215306.54778-1-sj@kernel.org>
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
index d30d659c794e..24070f36fa7c 100644
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

