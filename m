Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA2A2E1EE6;
	Mon, 25 Aug 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134836; cv=none; b=i4oRt2PYThPfJpu+Mrv7UOB485c0Wn+UkBfYyp/yFUPFm0y+emxBqClHoMHvZbMKDS7I7dV2CPkUG6snnsknba8lLPoUZ7xw9iX4Zq0x7aFHM4rET0K2anQzz46GrGtScWoGyRGZXRTnfA9rZrMQOZCEILPkodC8JOlGvyCklRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134836; c=relaxed/simple;
	bh=WZz+BEh/Ios9GLEN/uIEsnq1OHEvgWzXABBqfRy6Akk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iarLznP8c3Ywx6ikafQqHofIAyJnHREkr5XGAKcwiB/5IeIPQLjvKDa+DVCSqJnNKjdj8F0ZbUh4ADza8zGy7fJS8vSLbJv0NqhyIViSwcx5GjQTBTNbDCWbtETP9BpE6xx2Q7HDp9IxSn5O1P/bG1ZfCud+wHEWSkd1Zn3dsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi3KNdil; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi3KNdil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E0FC4CEED;
	Mon, 25 Aug 2025 15:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756134835;
	bh=WZz+BEh/Ios9GLEN/uIEsnq1OHEvgWzXABBqfRy6Akk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bi3KNdilY7L65uSGuh+wXZHJcTlHRrqDDZGm/3FiF5ruHGiEQNhqc6YfGiHitK+F1
	 dPqSNqGqGBBND2/c8uQCURQaRSadSmRLyY7aO7PKOxjv9o5bI4JZkH+ISVpn7hER8S
	 k5JaeR4QTvO4dP26VxEWXP6MQpV1IHzwkc/b08X7HGZdnwfrYFsweHn3TKu+maBWK8
	 ZgSq5xeVm+jzYe5970Y+VcwsuyIlASBk0DPRK29VbjOU3PBYXii9145mL4R7yTdsy0
	 SEM52H/4Fabq1MNznSczUogzmbdz2tgh3IClQsc1X82qdK+aO0o9LWf0LrNnmjj7xe
	 uuIAvIhCVEXFA==
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
Subject: Re: [PATCH v2 04/11] mm/damon/paddr: support addr_unit for DAMOS_LRU_[DE]PRIO
Date: Mon, 25 Aug 2025 08:13:53 -0700
Message-Id: <20250825151353.36392-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822093420.2103803-5-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 17:34:12 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_LRU_PRIO and DAMOS_LRU_DEPRIO action
> handling from the DAMOS operation implementation for the physical
> address space.
[...]
> -	return applied * PAGE_SIZE;
> +	return applied * PAGE_SIZE / addr_unit;
>  }

This can cause __udivdi3 linking issue similar to the report [1] from kernel
test robot.  Andrew, could you please add below attaching fixup?

[1] https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/


Thanks,
SJ

[...]

==== Attachment 0 (0002-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_de_ac.patch) ====
From hackermail Thu Jan  1 00:00:00 1970
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Cc: kernel-team@meta.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Date: Mon, 25 Aug 2025 07:45:24 -0700
Subject: [PATCH 2/3] mm/damon/paddr: use do_div() on i386 for
         damon_pa_de_activate() return value

Otherwise, __udivdi3 linking issue happens on certain configs.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 09c87583af6c..6fb92ecc513d 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -236,7 +236,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		folio_put(folio);
 	}
 	s->last_applied = folio;
-	return applied * PAGE_SIZE / addr_unit;
+	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
 }
 
 static unsigned long damon_pa_mark_accessed(struct damon_region *r,
-- 
2.39.5
