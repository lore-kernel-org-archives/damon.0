Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF312FD1A0;
	Mon, 25 Aug 2025 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134917; cv=none; b=Z6hyCHTM84TuZSZ/8sx7um1B9Ech5PgDc9ueM69ifbgZEkPNOenK+7+pujKZKJZFumS9kKX1RMPyTRu8DokUSiWJldNThYa7LR/H1fGQpLuGb1iCtCf5Sp1TN1I8Y26pHAIBNATBI6xgbAA2vBijr0437tXXwMDozmmOfBcCeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134917; c=relaxed/simple;
	bh=7tycD1zCJNlDY1KA90lS8EoR/M9TmWIK/PYUIBU4mWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpqkNx3voYzvK9s5GNj2sI0BkgoQg208oK2CBfwaiqVSFhnwLyaevx8N2aFk0aevu71hkZoeUTrEicvTo8qCEm0p9h81UqCGoY7kZ+PznQpyavC4WY20tULigFa1akCEr0t0IxV84ZmtEmNS6Mk5TjMcWlLSDI/HdCBfdvt3dtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7LM5h6r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7LM5h6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5F8C4CEED;
	Mon, 25 Aug 2025 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756134916;
	bh=7tycD1zCJNlDY1KA90lS8EoR/M9TmWIK/PYUIBU4mWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7LM5h6rNaU8atANolgGgAVEiTB51h4wGV3Rtm5WwLDh/1kO8+4mE5xM7F4VoWu1o
	 c6CA1LGbm1mYTIKsgCONmDo0d4YmSGSmkyuBqZiQvV+1XHKK9B2fVHSVtXhu7KLNUc
	 UBdkISmi9YaoqOz+RZFJh5QG/FD7LCmxzt9UDqFSfvz7kaKsMc6MfZYLjSyfj2i3OJ
	 nFtYkPEgmBPVl8Jox7I23MYJ+0p0Aa/I6XWi70ezIo8HYDiB/tcqYZwvnWqKvbWZwu
	 nB+Gab29wxO113RRdn5osBVuo0MrJxgx/5Fh1p/7IDisS96Os2kAEI0Swo8nItOxel
	 X15y64ZEUQl6w==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com,
	kernel-team@meta.com
Subject: Re: [PATCH v2 05/11] mm/damon/paddr: support addr_unit for MIGRATE_{HOT,COLD}
Date: Mon, 25 Aug 2025 08:15:13 -0700
Message-Id: <20250825151513.36488-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822093420.2103803-6-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 17:34:13 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_MIGRATE_HOT and DAMOS_MIGRATE_COLD
> action handling from the DAMOS operation implementation for the physical
> address space.
[...]
> -	return applied * PAGE_SIZE;
> +	return applied * PAGE_SIZE / addr_unit;
>  }

This can cause __udivdi3 linking issue similar to a report [1] from kernel test
robot.  Andrew, could you please add below attaching fixup?

[1] https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/


Thanks,
SJ

[...]

==== Attachment 0 (0003-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_migra.patch) ====
From hackermail Thu Jan  1 00:00:00 1970
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Cc: kernel-team@meta.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Date: Mon, 25 Aug 2025 07:46:24 -0700
Subject: [PATCH 3/3] mm/damon/paddr: use do_div() on i386 for damon_pa_migrate()
         return value

Otherwise, __udivdi3 linking issue happens on certain configs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6fb92ecc513d..34248b742a73 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -286,7 +286,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 	applied = damon_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
 	s->last_applied = folio;
-	return applied * PAGE_SIZE / addr_unit;
+	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
 }
 
 static unsigned long damon_pa_stat(struct damon_region *r,
-- 
2.39.5
