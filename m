Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C918283C97;
	Thu,  9 Oct 2025 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044848; cv=none; b=pJX1U9/zP0VWarV+kuPzgOgx1nwYv/B5NI4uvf0I7R89O5bAWx+5KbR+ALbSaSugpvXju1PlHM49A4ilstqthGHb41hRH+yF49T/wFLxEwRxob2ZPDridzkTZXo/3oHr0RFX3OPdxWkEDFowCEn9Sen4hrWYhi+EjZlauhTtynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044848; c=relaxed/simple;
	bh=w2pLgMeh4x2vtx8hkxpF0higLdemtjuZby1GC48TrEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XgexVGSbTHZaHDGrK+rSQCNLcggpcVQ91vTYqzi6joF8XoUS0xck1nQMZsAFQEMQAhXLT0Y7zZuJ1gL/zkjWJjbKnE6yFk3g0rSfyzCMsULnZ718dIYvXgYa4iGMglp/2UsyKWowvftmPQATDloCmX6Fc3rsaVkWCHFyuGO52/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoE0x/Bc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoE0x/Bc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB76C4CEFE;
	Thu,  9 Oct 2025 21:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044847;
	bh=w2pLgMeh4x2vtx8hkxpF0higLdemtjuZby1GC48TrEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoE0x/BcAqmaV2Wgjw0N5gfW/vKHaPIWbzMAPPNOuwRHVJx+nfGi6F9/eOMbJrETc
	 lOUGYD4jUkMYnd7r/uqczxMG5O0feC1chueyOngV2+s5nsbBO6UeA7I6Ea7oHviRe5
	 Zwswpw3JBw/w7ejFNRTDruikLC7I3+0NVCbbqRD0VegD2C1McfJDwVbxBtY6IAmfFp
	 0DIcIrFxGF2AQ6UJLmuZMHz4CJB362AvW6Y12Sl62UAvt18BjZwKeBkdCCe2xGHwse
	 3zZ9uxxCSH37afEwUd/j9HCdMUUWFSm2F+6lheSXl7SF6kPDuIYCxkW0AN30Nq7jqW
	 EMw9vpuJaGmkg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/10] mm/damon: document damos_quota_goal->nid use case
Date: Thu,  9 Oct 2025 14:20:33 -0700
Message-Id: <20251009212042.60084-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009212042.60084-1-sj@kernel.org>
References: <20251009212042.60084-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota_goal kerneldoc comment is not explaining when @metric is
used.  Update the comment for that.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index cae8c613c5fc..dc9c310e0e75 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -176,6 +176,9 @@ enum damos_quota_goal_metric {
  * If @metric is DAMOS_QUOTA_USER_INPUT, @current_value should be manually
  * entered by the user, probably inside the kdamond callbacks.  Otherwise,
  * DAMON sets @current_value with self-measured value of @metric.
+ *
+ * If @metric is DAMOS_QUOTA_NODE_MEM_{USED,FREE}_BP, @nid represents the node
+ * id of the target node to account the used/free memory.
  */
 struct damos_quota_goal {
 	enum damos_quota_goal_metric metric;
-- 
2.39.5
