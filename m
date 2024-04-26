Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8E250EC;
	Fri, 26 Apr 2024 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161182; cv=none; b=jnLqtN6vs7jtvIvFJSQIsIPm2/rd+CNrK1fYdgVqv63F90NVA0tU7WcOeKCFvV1kpvxAtB147+HfdOGComeZlc+wzGtILKOzHU1l0DF0JLEmi8AKDIh29+nh0XJzW1uxEsIj4OoiXMErqcnfTI64d+K0ckKyso77tBNcsElgBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161182; c=relaxed/simple;
	bh=46Ldc4399x5vGxfdUW5g3TDQSnO265hzzOnyBh65g88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9XkKsZ85ICIfGv25PTN3rFHaLeuRrNXrR8LqU6EeF7xgroCuwErk1acMGKJNviHcP+bf50fBLpzHycW4SJw9vT26OwT6jnYTGlRvFhEN3XrlKyUKp03d9NMND0gYBcgXD5Qh9n7ll4BsI20WeiCXBpdDO2A+OeoA4XvgGixq7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHJRU25s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHJRU25s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA417C32782;
	Fri, 26 Apr 2024 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161182;
	bh=46Ldc4399x5vGxfdUW5g3TDQSnO265hzzOnyBh65g88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHJRU25sNcZ3kflmc9l32q9W9O5dkcFuYIFx4htbsFTTzuLcIKoq9OYjbHSgGAoxN
	 wBr7lR9mubXiLcmQPxKdxlvdKtYeIYiPQ7w48zCP0wR2rlG9ASPxuxwMIucHe+55b+
	 PwKyiWbJnIBFXfDxrmCkwgTTKrd1pSIv/QPS29wLCzkg20hJXH6VeSafdXfQ7AD30s
	 rAEh9hr00Eso94b+xhsEI0G0OE8QVQmM59lL2AvNN9bdQJlGnTWcKsVnLcWnbjGBpA
	 SmA35yWD0jqw4y4ByPWOtykdRf1ZPqrAfDlIs3DlgjtwHhAVkseI7H82QAVJ9/txXc
	 y0gQttRPRGmbw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 3/7] mm/damon: add DAMOS filter type YOUNG
Date: Fri, 26 Apr 2024 12:52:42 -0700
Message-Id: <20240426195247.100306-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426195247.100306-1-sj@kernel.org>
References: <20240426195247.100306-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define yet another DAMOS filter type, YOUNG.  Like anon and memcg, the
type of filter will be applied to each page in the memory region, and
see if the page is accessed since the last check.  Based on the
'matching' parameter, the page is filtered out or in.

Note that this commit is adding only the type definition.  The
implementation should be made by DAMON operations sets.  A commit for
the implementation on 'paddr' DAMON operations set will follow.

Signed-off-by: SeongJae Park <sj@kernel.org>
Tested-by: Honggyu Kim <honggyu.kim@sk.com>
---
 include/linux/damon.h    | 2 ++
 mm/damon/sysfs-schemes.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 886d07294f4e7..f7da65e1ac041 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -297,6 +297,7 @@ struct damos_stat {
  * enum damos_filter_type - Type of memory for &struct damos_filter
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -315,6 +316,7 @@ struct damos_stat {
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
+	DAMOS_FILTER_TYPE_YOUNG,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 53a90ac678fb9..bea5bc52846a6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -343,6 +343,7 @@ static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
 static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
+	"young",
 	"addr",
 	"target",
 };
-- 
2.39.2

