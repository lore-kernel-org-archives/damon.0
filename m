Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F11B140D;
	Fri, 13 Dec 2024 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126803; cv=none; b=ro4QPdNzRdR078GRunCuCzUBAgcenH+syPPB+6TZjkUIRKT8by2F2oEVcsmxD10o3DRAnogpW2AZznQxbcMWb4lBDg4Hi5VpTjYqwejdLHw0KlVbZmZnG6KeHi/DQ1VnjiDHeZz4czHPjX7F4jrfOfxbSqmQKIU4CJVUVFI0MuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126803; c=relaxed/simple;
	bh=rp/tcYNceH/iVxFLl5+nJOs7qKY1obY5L2t2IlLP5LI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crSWSzC37YyBFMekzL6oS7NzAealNFEHpOA0b0tSRMEJZw/RD5V4e4IhwMmJVUyG+OjSCjqjBCM9NBa/Vf5XHAx0m7rpODYaMcCcviisxh9wUeGDBpVQ1/wA36P+Rm9+/ZE5B4UxXI0t2+9uP8bnXO8kJSwEuNPvwsC+nJPvgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2j387Kv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2j387Kv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F62C4CED4;
	Fri, 13 Dec 2024 21:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126803;
	bh=rp/tcYNceH/iVxFLl5+nJOs7qKY1obY5L2t2IlLP5LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d2j387KvOWKzzdbwcgD4HvlbKrHfywY4HSrfo8zIbYOUUR5p24WyVaSb+IKwsr7Nq
	 YgVhXSg1ecg2rKGrjlSTmlyXSGSVqSfUIx8KTUW4mS4gKV0Wccm3ZHwpcGEkcKg0XM
	 9LkPkiDyWf+XOAhZCX1a+TkX1n9fMr2Bl+V9tvvCUASUbUknjmeASY9uRp0IhMoOh6
	 bU+F5FTaEaiiU/m+U5sNFzdWlJpWT+EeRB0lBNgs8HCBWT1aRNiNVzKy1Y2ac1fwyp
	 1jrVs5j8fu8KID5KLBbiR6olcszj7m4UCkoLV5A/0+Rqx/jLYblQ469k8dhVSo54p4
	 UId4w5K1SGvMA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/9] mm/damon/sysfs: use damon_call() for update_schemes_effective_quotas
Date: Fri, 13 Dec 2024 13:53:03 -0800
Message-Id: <20241213215306.54778-7-sj@kernel.org>
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
facility to handle update_schemes_effective_quotas command.  But
damon_call() can support the use case without the additional
synchronizations.  Convert the code to use damon_call() instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 24070f36fa7c..978de4305f2b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1327,20 +1327,18 @@ static int damon_sysfs_commit_schemes_quota_goals(void *data)
 /*
  * damon_sysfs_upd_schemes_effective_quotas() - Update schemes effective quotas
  * sysfs files.
- * @kdamond:	The kobject wrapper that associated to the kdamond thread.
+ * @data:	The kobject wrapper that associated to the kdamond thread.
  *
  * This function reads the schemes' effective quotas of specific kdamond and
  * update the related values for sysfs files.  This function should be called
  * from DAMON callbacks while holding ``damon_syfs_lock``, to safely access the
  * DAMON contexts-internal data and DAMON sysfs variables.
  */
-static int damon_sysfs_upd_schemes_effective_quotas(
-		struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_upd_schemes_effective_quotas(void *data)
 {
+	struct damon_sysfs_kdamond *kdamond = data;
 	struct damon_ctx *ctx = kdamond->damon_ctx;
 
-	if (!ctx)
-		return -EINVAL;
 	damos_sysfs_update_effective_quotas(
 			kdamond->contexts->contexts_arr[0]->schemes, ctx);
 	return 0;
@@ -1400,9 +1398,6 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 			damon_sysfs_schemes_regions_updating = false;
 		}
 		break;
-	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
-		err = damon_sysfs_upd_schemes_effective_quotas(kdamond);
-		break;
 	default:
 		break;
 	}
@@ -1550,6 +1545,10 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
 		return damon_sysfs_schemes_clear_regions(
 			kdamond->contexts->contexts_arr[0]->schemes);
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
+		return damon_sysfs_damon_call(
+				damon_sysfs_upd_schemes_effective_quotas,
+				kdamond);
 	default:
 		break;
 	}
-- 
2.39.5

