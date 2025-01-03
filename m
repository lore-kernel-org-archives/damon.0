Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922181FC111;
	Fri,  3 Jan 2025 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926253; cv=none; b=nOdUT4u80vI0JsP9YjNrATwxyUvm6qAWlMHm1WC7ErVZYX/cy0Uowy7YHP0SXyQwEuC16ilx8OZkRuorMl+ja/TcbdyAdAfvbT4rqFmJwPiglPe1/O26sS8vL7Z/Eey0Cv3A6gs6mOR+n6yCpFHryBEne4Sjqsyp6rOwASekwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926253; c=relaxed/simple;
	bh=HDW7FthU1uRvJZ3MkhWqZ07vrMNtcqEXeZfp37Ljvk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HV452AlKxl24yMXbGYuywiM+psnl1oz/jc9r/1zFL0lMQ5XJnDdBtlx1frH1bbU1JCBttmBmEO69YzQNp//lxO/zE0x84vP1ju2/vUrA40FHbG+hJh0u1yBkmO0KhStKg2qdlEECWohf8m71orrUNRtoLkQjSfIo0dHtlntt+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4ZPHopH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4ZPHopH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C2CC4CED6;
	Fri,  3 Jan 2025 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926253;
	bh=HDW7FthU1uRvJZ3MkhWqZ07vrMNtcqEXeZfp37Ljvk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4ZPHopHQ4zwcT/ioK5B4zxE+LQ9Jblr6ZzjHB8UoIGpZkpSGE40nGqMLk/0MtGNv
	 QSwWX1u63oc08L37F/G7LjqtBKn/UOv0mxeVv+5G4apc+W5noR+RcRNrwCE4GaLfCk
	 TsmYIJlW5tnIZ2ugEFATGMPQffvTm/7jhZMVJXJ6iwnk/0PLFOP//qcXQlzt1dlwvI
	 6NC2FP1Dx7CYJNq+IQ4Sv+TD6AohzmbZtczclEbxyDJAPRVzzcqts6Il/yQ30ifkyx
	 KJo3F0lyuXFp/lQ8TtuvDhBPby8BNLqvL1Ginb1s6ZdS82tUuNpRn8HHHBF6/zuh46
	 AO7OUX81CjKGQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 02/10] mm/damon/sysfs: handle clear_schemes_tried_regions from DAMON sysfs context
Date: Fri,  3 Jan 2025 09:43:52 -0800
Message-Id: <20250103174400.54890-3-sj@kernel.org>
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

DAMON sysfs interface handles clear_schemes_tried_regions request from
the DAMON callback context (damon_sysfs_cmd_request_callback()), which
is designed to be used for safe access to the related DAMON context
internal data.  But no DAMON context internal data is accessed for the
work.  Directly handle it from DAMON sysfs interface context, namely
damon_sysfs_handle_cmd().

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c |  2 +-
 mm/damon/sysfs.c         | 17 +++--------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 2aa34778a472..c57ab47686ff 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2260,7 +2260,7 @@ static void damos_tried_regions_init_upd_status(
 	}
 }
 
-/* Called from damon_sysfs_cmd_request_callback under damon_sysfs_lock */
+/* Called while damon_sysfs_lock is hold */
 int damon_sysfs_schemes_update_regions_start(
 		struct damon_sysfs_schemes *sysfs_schemes,
 		struct damon_ctx *ctx, bool total_bytes_only)
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 789804986ab0..4f6e4720b7ce 100644
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
