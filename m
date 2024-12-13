Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6732F1974EA;
	Fri, 13 Dec 2024 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126800; cv=none; b=JLkgbuLTsMiSOTb6JvCawDFPpMtPFrW2HOs033iKxXArD7kxGBXh0kk56dIoIZY/lA4lxmceSmaFv+SHzv7k94FvIbP1NVIaqWNEdLPBZSXBqyK2//qPElkNsZpEHbDRnqHx+3W0EDIJ4m91f6GUdPUNYuCrDUsnr4mFaq05dfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126800; c=relaxed/simple;
	bh=KeUP+pCvuxkILHBLCBzmbDq6X8tGBEnSsOyYCFO9ER4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UlTqAzYzoWhWSMpvaK5e1gY9pRP8EslwK6YGjsa6G6cv8A/RwGw2IXeK+rr09prkhkyY9z7yqV31cl/Oqu9fPiiRwZglA1mMzQQOPrjJAxqo2Cm8/6U559VeDOvoZWlLQe0E05JeE/zabG5n1cKCkqO+11cAYLXe7Cjx0LyMHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfdfXvct; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfdfXvct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C029EC4CED0;
	Fri, 13 Dec 2024 21:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126798;
	bh=KeUP+pCvuxkILHBLCBzmbDq6X8tGBEnSsOyYCFO9ER4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nfdfXvct2DhdTzFkuAL1Stw3Y9RViraAPNw5F4RuvEghu7rw6op1PLPMfFfxpXCW0
	 5LJzRigU/GJ/mRfHzc9VQX6l6oHyTTVCjmB9NMg0DaZg8agdG/eD724XV5v3X9BMAi
	 F8qDykQFR2H+N7nxiKbeCVnAwvj4lGlyycCkP1QBWzgUresQuwCq0rRtPS1Q1yTnwm
	 jYmDkEEN8fr5jrWWDF4LZiZ8va00lghmI5bs2sfzaC4+pRXzfHZmrHofsw4b0jbcSx
	 TOvfpyKgFLqU6NqZqvLD6isQxnHwsVeDea5QfsfInrora/kv2V1GBtWIlGzoQE31aU
	 B9FT0mSE6X4Bg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/9] mm/damon/sysfs: handle clear_schemes_tried_regions from DAMON sysfs context
Date: Fri, 13 Dec 2024 13:52:59 -0800
Message-Id: <20241213215306.54778-3-sj@kernel.org>
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

DAMON sysfs interface handles clear_schemes_tried_regions from DAMON
callback context (damon_sysfs_cmd_request_callback()).  But no DAMON
internal data is accessed for the work.  Directly handle it from DAMON
sysfs interface context, namely damon_sysfs_handle_cmd().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c |  2 +-
 mm/damon/sysfs.c         | 17 +++--------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 65f6d3339a77..6c8f9eae75af 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2265,7 +2265,7 @@ static void damos_tried_regions_init_upd_status(
 	}
 }
 
-/* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
+/* Called while damon_sysfs_lock is hold */
 int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, bool total_bytes_only)
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 71bc2622ab35..8cb940d21fbe 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1254,17 +1254,6 @@ static int damon_sysfs_upd_schemes_regions_stop(
 	return damon_sysfs_schemes_update_regions_stop(ctx);
 }
 
-static int damon_sysfs_clear_schemes_regions(
-		struct damon_sysfs_kdamond *kdamond)
-{
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-
-	if (!ctx)
-		return -EINVAL;
-	return damon_sysfs_schemes_clear_regions(
-			kdamond->contexts->contexts_arr[0]->schemes);
-}
-
 static inline bool damon_sysfs_kdamond_running(
 		struct damon_sysfs_kdamond *kdamond)
 {
@@ -1417,9 +1406,6 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 			damon_sysfs_schemes_regions_updating = false;
 		}
 		break;
-	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
-		err = damon_sysfs_clear_schemes_regions(kdamond);
-		break;
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
 		err = damon_sysfs_upd_schemes_effective_quotas(kdamond);
 		break;
@@ -1549,6 +1535,9 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		return damon_sysfs_turn_damon_on(kdamond);
 	case DAMON_SYSFS_CMD_OFF:
 		return damon_sysfs_turn_damon_off(kdamond);
+	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
+		return damon_sysfs_schemes_clear_regions(
+			kdamond->contexts->contexts_arr[0]->schemes);
 	default:
 		break;
 	}
-- 
2.39.5

