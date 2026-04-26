Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E727B357;
	Sun, 26 Apr 2026 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777231889; cv=none; b=aefFjSRVwITt8ouHX2sDVyB14AghG4ETk2LR2iGZg5FIGjjGcGa9JnF8fb+DU1I3tY1d0csPYaS9RJ6+qq1cl+4r0IxuWPy8xDCHbcwMIuXBUA4PgB4RfCE9ogA/DtOW/9GVJBnmzD66kWzcjPRSUUPzkJKH3stY72cswZaKrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777231889; c=relaxed/simple;
	bh=4tHvdx6TSi/pE4+uHCV/opn0vKxPFOFkJhVFTnizMW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+inEOZLGYVImoZVUgLaVCvEWqqMmn6QZMODaZiVqceedXGEudL7WD6/F3DnZn1wEagZuUeEqQjc6rjtP96sKvkH/IRt43KDTX4JVzzkxB7XXgbS/vf1MWApGM0uxD5uya1Mr4JUTQRA4g/fa9tny1aPvKbxnJwCKdLxMyAgrjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecgvEWfo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecgvEWfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29F2C2BCAF;
	Sun, 26 Apr 2026 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777231889;
	bh=4tHvdx6TSi/pE4+uHCV/opn0vKxPFOFkJhVFTnizMW0=;
	h=From:To:Cc:Subject:Date:From;
	b=ecgvEWfoOCQW+9FcinGb/eNNBQ5wVGjaz9PTP/nTxJS8UV1yCIvLTT+ZL8uvWgSK5
	 IXDpkq3+Lfvvwcy65ImxVZA5awY6MMEDSoektVgQ61cptvIBMHu7SfO1Z+MhoJ/Edo
	 csVppEq7QzYxM+eoTe5aE/23uhCiuPkz75kbUaCZrI+jf6lD92McFB99sRINzq9JEX
	 DL+QX/coAOamnQDV4ksTRFrGvQ/knGBdl21litoSY59yBxCAD9zFh3s7efkWwtghBd
	 J82LDP5pB5c1nUbmiBnTjY/sviZeKKrGmHOkBzTOqiiy5Ru49gLTSErNajqAaoGEZP
	 wNJUQoE2ezQjA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 7 . 0 . x" <stable@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] mm/damon: fix damos_stat tracepoint format for sz_applied
Date: Sun, 26 Apr 2026 12:31:17 -0700
Message-ID: <20260426193119.88095-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The print format is wrongly marking sz_applied as sz_tried.  Fix it.

Fixes: 804c26b961da ("mm/damon/core: add trace point for damos stat per apply interval")
Cc: <stable@vger.kernel.org> # 7.0.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 24fc402ab3c85..7e25f4469b81b 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -41,7 +41,7 @@ TRACE_EVENT(damos_stat_after_apply_interval,
 	),
 
 	TP_printk("ctx_idx=%u scheme_idx=%u nr_tried=%lu sz_tried=%lu "
-			"nr_applied=%lu sz_tried=%lu sz_ops_filter_passed=%lu "
+			"nr_applied=%lu sz_applied=%lu sz_ops_filter_passed=%lu "
 			"qt_exceeds=%lu nr_snapshots=%lu",
 			__entry->context_idx, __entry->scheme_idx,
 			__entry->nr_tried, __entry->sz_tried,

base-commit: 2e98f54b5a2b874905c71f3bc40eb8c0e8e757f0
-- 
2.47.3
