Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC01F91D6;
	Sun, 29 Mar 2026 04:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774759145; cv=none; b=Eam+E5TDBk2mpQSXlNWOxjTKC0czX25Wtud9FbtfcMLTtjr6ONZOblnq7NfZSgqkMRDw/hGO5AsFWsn8P0M8TbiTurLd04rB/vBeluGXm/2Ch3hKdyuDD1RuZ/O09puub8Yn0oatfEzJAqWYLSwFVsWb5YBIrhpyhkzkD9aBLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774759145; c=relaxed/simple;
	bh=EHLWGxW7vsnb0JYbS1TWbmzJf4dzLg0vok6TKbBxOAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okJQdnsikSePL1/DE1FTneT4+C/NCgKJA+8xJJt76NGixGEBOLKL1GspFr5OV1hOD5cR/ZdhUR1CT1+szKQ/YXZA4ckCJih0zp8O4VE8yZaFZbW/ugy0jIBxN4gIyP6GYa547bGvTtT/TwTIcmIXd2x8JFe7v3kGlMQA92WTsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRiQBnpb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRiQBnpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED03C2BCB2;
	Sun, 29 Mar 2026 04:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774759145;
	bh=EHLWGxW7vsnb0JYbS1TWbmzJf4dzLg0vok6TKbBxOAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRiQBnpb3XEA6rAA2mvK45qT/sGo9EjJNFM+Sm+SPUYiEqKvL35//LdstMht86/HP
	 DLPR+lCWNEoMOkaD8BQJs5tOqjukX8qhEowT/b8epdtLSnHpTVscHbGIuCfwHWy3W7
	 D9heDL3idd2cC8nXU378P2ejN4NPzWPl9pgzFKI4MTppraMimCoCQWgVqb6jWCUl9a
	 XPif1dFwd/SWoFae3gIFFnpGLade3TPKuyFVvUoxBtvr8y1J6yP/H/Go0cfLbGbjGc
	 KGlLq/4ZsGr9wBGXwAyTeUZoOWHLRTx1utPGe54LAxKznfXrv6cRfDupL+EzH5Si+y
	 8DYVHH6JP/eRQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/2] mm/damon/core: validate damos_quota_goal->nid for node_mem_{used,free}_bp
Date: Sat, 28 Mar 2026 21:38:59 -0700
Message-ID: <20260329043902.46163-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329043902.46163-1-sj@kernel.org>
References: <20260329043902.46163-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users can set damos_quota_goal->nid with arbitrary value for
node_mem_{used,free}_bp.  But DAMON core is using those for
si_meminfo_node() without the validation of the value.  This can result
in out of bounds memory access.  The issue can actually triggered using
DAMON user-space tool (damo), like below.

    $ sudo ./damo start --damos_action stat \
    	--damos_quota_goal node_mem_used_bp 50% -1 \
    	--damos_quota_interval 1s
    $ sudo dmesg
    [...]
    [   65.565986] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000098

Fix this issue by adding the validation of the given node.  If an
invalid node id is given, it returns 0% for used memory ratio, and 100%
for free memory ratio.

Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics for memory node utilization")
Cc: <stable@vger.kernel.org> # 6.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ddabb93f2377..9a848d7647ef 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2217,12 +2217,24 @@ static inline u64 damos_get_some_mem_psi_total(void)
 #endif	/* CONFIG_PSI */
 
 #ifdef CONFIG_NUMA
+static bool invalid_mem_node(int nid)
+{
+	return nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY);
+}
+
 static __kernel_ulong_t damos_get_node_mem_bp(
 		struct damos_quota_goal *goal)
 {
 	struct sysinfo i;
 	__kernel_ulong_t numerator;
 
+	if (invalid_mem_node(goal->nid)) {
+		if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
+			return 0;
+		else	/* DAMOS_QUOTA_NODE_MEM_FREE_BP */
+			return 10000;
+	}
+
 	si_meminfo_node(&i, goal->nid);
 	if (goal->metric == DAMOS_QUOTA_NODE_MEM_USED_BP)
 		numerator = i.totalram - i.freeram;
-- 
2.47.3
