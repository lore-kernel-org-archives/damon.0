Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A877D56462
	for <damon@lists.linux.dev>; Fri,  5 Apr 2024 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297361; cv=none; b=uOPJ4h/U45WcAqBEFyJuZalzn4nX/lZKLGSj4OmwVUs7BIrlLkS/TPEKTukNVXrjpMB0NffynWnBm7zqBWP0HyXldGdK+BA9q5mIYgFoupNrU8RJd8Gvj5BqbsiTnX7G6SSO8nc2oPYDDqhhfA7CSTTNtT8dKDaVAV5oWTNDKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297361; c=relaxed/simple;
	bh=o36KKxNNzRI1ApXBSop+WnIeRqTOalGKAAqceMCAphw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cq0a5uu6h0MJkZ5jidwz2uPKK0L6ftZrAqnmuWZgdGbkmXoLf7ThASL380Jll9B3M8RWVRDEqYLhUgiMKc7sB/TpHXPIW6QS0V2/XHSgnEPzkCRHpfxHOIYLQuA7hWS1AmstkPVgteJBmIkDPUg/EA9e52ArHCMLG+EjRPJekjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-ac-660f95839088
From: Honggyu Kim <honggyu.kim@sk.com>
To: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: [RFC PATCH v3 4/7] mm/migrate: add MR_DAMON to migrate_reason
Date: Fri,  5 Apr 2024 15:08:53 +0900
Message-ID: <20240405060858.2818-5-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20240405060858.2818-1-honggyu.kim@sk.com>
References: <20240405060858.2818-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsXC9ZZnkW7zVP40gwtftS0m9hhYzFm/hs1i
	140Qi/sPXrNb/N97jNHiyf/frBYnbjayWXR+X8picXnXHDaLe2v+s1ocWX+WxWLz2TPMFouX
	q1ns63jAZHH46xsmi8mXFrBZvJhyhtHi5KzJLBazj95jdxD2WHr6DZvHhiYgsXPWXXaPln23
	2D0WbCr1aDnyltVj8Z6XTB6bVnWyeWz6NInd48SM3yweOx9aerzYPJPRo7f5HZvH501yAXxR
	XDYpqTmZZalF+nYJXBknrl9kLljGWdH56zdTA+M99i5GTg4JAROJo4s3sMHYS29tBYuzCahJ
	XHk5iamLkYNDRMBBYtVXhS5GLg5mgf/MEpd7f7GC1AgLuEks6b/ODFLDIqAqcXZXBEiYV8BM
	4mvzK0aIkZoSj7f/BBvJKWAuMe/xBjBbCKjm08Fj7BD1ghInZz5hAbGZBeQlmrfOZgbZJSFw
	jF1iycwdrBCDJCUOrrjBMoGRfxaSnllIehYwMq1iFMrMK8tNzMwx0cuozMus0EvOz93ECIy6
	ZbV/oncwfroQfIhRgINRiYfXYy5fmhBrYllxZe4hRgkOZiUR3m4H3jQh3pTEyqrUovz4otKc
	1OJDjNIcLErivEbfylOEBNITS1KzU1MLUotgskwcnFINjFPbvzneWznp19+TfxrmB6zesuOw
	3I2v99MX+EoF7jfYzx23k31L8c2Pn3nSmfT++TjcefyPIUFHQnaz7+Z3l5fcDhVxZCu/uy5Z
	eqbEBbPcP2uV51SF9GTc5bu9Mn9S8KKNMsqvn8ZOecE6UfPgo1XptVM+X153m3vTr5lsNzvn
	P90v57fSrGq+EktxRqKhFnNRcSIA6JiNaLYCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCNUNLT7d5Kn+awdaNMhYTewws5qxfw2ax
	60aIxf0Hr9kt/u89xmjx5P9vVosTNxvZLD4/e81s0fnkO6PF4bknWS06vy9lsbi8aw6bxb01
	/1ktjqw/y2Kx+ewZZovFy9UsDl17zmqxr+MBk8Xhr2+YLCZfWsBm8WLKGUaLk7Mms1jMPnqP
	3UHcY+npN2weG5qAxM5Zd9k9WvbdYvdYsKnUo+XIW1aPxXteMnlsWtXJ5rHp0yR2jxMzfrN4
	7Hxo6fFi80xGj97md2we3257eCx+8YHJ4/MmuQCBKC6blNSczLLUIn27BK6ME9cvMhcs46zo
	/PWbqYHxHnsXIyeHhICJxNJbW8FsNgE1iSsvJzF1MXJwiAg4SKz6qtDFyMXBLPCfWeJy7y9W
	kBphATeJJf3XmUFqWARUJc7uigAJ8wqYSXxtfsUIMVJT4vH2n2AjOQXMJeY93gBmCwHVfDp4
	jB2iXlDi5MwnLCA2s4C8RPPW2cwTGHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85
	P3cTIzDSltX+mbiD8ctl90OMAhyMSjy8HnP50oRYE8uKK3MPMUpwMCuJ8HY78KYJ8aYkVlal
	FuXHF5XmpBYfYpTmYFES5/UKT00QEkhPLEnNTk0tSC2CyTJxcEo1MDpx3F2kWvVkQoFu4dPq
	S4ucpTqXWJdf37nXh7dbWL3HWsfwxtdei2iTye6vdVXX2wgWVSpe6fUJy7xZoNebH7kpJ587
	/fIH0eMTVt+0vZV+1s+dp+3DFfdK4xgOpW1njuc2cJ/WXHH4XeLsubP4Nv/+4L2pvtEo6g6H
	WnztlUvqBsKsRs++KrEUZyQaajEXFScCAKFMwPWwAgAA
X-CFilter-Loop: Reflected

The current patch series introduces DAMON based migration across NUMA
nodes so it'd be better to have a new migrate_reason in trace events.

Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
---
 include/linux/migrate_mode.h   | 1 +
 include/trace/events/migrate.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index f37cc03f9369..cec36b7e7ced 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -29,6 +29,7 @@ enum migrate_reason {
 	MR_CONTIG_RANGE,
 	MR_LONGTERM_PIN,
 	MR_DEMOTION,
+	MR_DAMON,
 	MR_TYPES
 };
 
diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index 0190ef725b43..cd01dd7b3640 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -22,7 +22,8 @@
 	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
 	EM( MR_CONTIG_RANGE,	"contig_range")			\
 	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
-	EMe(MR_DEMOTION,	"demotion")
+	EM( MR_DEMOTION,	"demotion")			\
+	EMe(MR_DAMON,		"damon")
 
 /*
  * First define the enums in the above macros to be exported to userspace
-- 
2.34.1

