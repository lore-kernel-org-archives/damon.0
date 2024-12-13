Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F171991C3;
	Fri, 13 Dec 2024 21:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126801; cv=none; b=kEwdB6MUy11J1zgFbFxFah6tIRBNEvCoaKppzs68Hm9rQHW3WLsCpBV7gzEU/j1lBfriFPFfzBuA32lyL2qrzuUj3dI9DPnopmLys0JmD/Ppj0Ot5DWNyUrQCCmSYhKMTA0+ZoH5RuMD7sQxUt+wXnnBMT3xKA3VCppAj50bbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126801; c=relaxed/simple;
	bh=yGKlblsUzxnMA0YCWYFB2DujgbVF+67M4pYSvqkOPCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KzJhJhhdA5Gb2jgnNzOlazHlKUjfNvTwJ8BrnC8ketXiCBMtZyP/a0y3Is8Y9bMmV23dvxquN7bz+71fQ57xx27DOL+B7gYFeHHUWPeLRL5TBw3P4Z9c1rFkjQvgl2iLNXvsw8mJAgJ3/5h/WfGdTdlKuGde59qJa4f2m+v6Joc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK3ykhyp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK3ykhyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D330AC4CED0;
	Fri, 13 Dec 2024 21:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734126801;
	bh=yGKlblsUzxnMA0YCWYFB2DujgbVF+67M4pYSvqkOPCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CK3ykhyp/Jp3ORy0ACMRS8jA23yGFl2KYbBgQQu/8F5MazUNFhMQm200EQUyH+G9d
	 uPIc2wL6UrU9abFd4v0sbGQYhQiy4u0iiUePXYgF4yr2Tb5rIZCdytcj31l0yhgjrz
	 7Gk5+LUUBlj8sa6LoWDxHUR/2eV+8jp73thX8tlPfaTcMyaEyTh6HEw9sWezw5NNXa
	 6TQsHIIvVaALG835aoLSEINpEWnKvbgWwaMsO5J+7kqAUEo387KfSxC7ebQ2q3GcAX
	 2kKStFtgtvuPQeUCT8XacA35Iu9+tW1VPhpAI1HRky4XCFmsRdjtgo3Auq13PXdIam
	 TlQULl+TbYLmw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/9] mm/damon/sysfs: use damon_call() for update_schemes_stats
Date: Fri, 13 Dec 2024 13:53:01 -0800
Message-Id: <20241213215306.54778-5-sj@kernel.org>
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
facility to handle update_schemes_stats kdamond command.  But
damon_call() can support the use case without the additional
synchronizations.  Convert the code to use damon_call() instead.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 8cb940d21fbe..d30d659c794e 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1214,19 +1214,19 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 
 /*
  * damon_sysfs_upd_schemes_stats() - Update schemes stats sysfs files.
- * @kdamond:	The kobject wrapper that associated to the kdamond thread.
+ * @data:	The kobject wrapper that associated to the kdamond thread.
  *
  * This function reads the schemes stats of specific kdamond and update the
  * related values for sysfs files.  This function should be called from DAMON
- * callbacks while holding ``damon_syfs_lock``, to safely access the DAMON
- * contexts-internal data and DAMON sysfs variables.
+ * worker thread,to safely access the DAMON contexts-internal data.  Caller
+ * should also ensure holding ``damon_syfs_lock``, and ->damon_ctx of @data is
+ * not NULL but a valid pointer, to safely access DAMON sysfs variables.
  */
-static int damon_sysfs_upd_schemes_stats(struct damon_sysfs_kdamond *kdamond)
+static int damon_sysfs_upd_schemes_stats(void *data)
 {
+	struct damon_sysfs_kdamond *kdamond = data;
 	struct damon_ctx *ctx = kdamond->damon_ctx;
 
-	if (!ctx)
-		return -EINVAL;
 	damon_sysfs_schemes_update_stats(
 			kdamond->contexts->contexts_arr[0]->schemes, ctx);
 	return 0;
@@ -1371,9 +1371,6 @@ static int damon_sysfs_cmd_request_callback(struct damon_ctx *c, bool active,
 	if (!kdamond || kdamond->damon_ctx != c)
 		goto out;
 	switch (damon_sysfs_cmd_request.cmd) {
-	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
-		err = damon_sysfs_upd_schemes_stats(kdamond);
-		break;
 	case DAMON_SYSFS_CMD_COMMIT:
 		if (!after_aggregation)
 			goto out;
@@ -1511,6 +1508,18 @@ static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
 	 */
 }
 
+static int damon_sysfs_damon_call(int (*fn)(void *data),
+		struct damon_sysfs_kdamond *kdamond)
+{
+	struct damon_call_control call_control = {};
+
+	if (!kdamond->damon_ctx)
+		return -EINVAL;
+	call_control.fn = fn;
+	call_control.data = kdamond;
+	return damon_call(kdamond->damon_ctx, &call_control);
+}
+
 /*
  * damon_sysfs_handle_cmd() - Handle a command for a specific kdamond.
  * @cmd:	The command to handle.
@@ -1529,12 +1538,14 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 {
 	bool need_wait = true;
 
-	/* Handle commands that doesn't access DAMON context-internal data */
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
 		return damon_sysfs_turn_damon_on(kdamond);
 	case DAMON_SYSFS_CMD_OFF:
 		return damon_sysfs_turn_damon_off(kdamond);
+	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS:
+		return damon_sysfs_damon_call(
+				damon_sysfs_upd_schemes_stats, kdamond);
 	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
 		return damon_sysfs_schemes_clear_regions(
 			kdamond->contexts->contexts_arr[0]->schemes);
-- 
2.39.5

