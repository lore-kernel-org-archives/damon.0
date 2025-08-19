Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480C3450F2;
	Tue, 19 Aug 2025 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584545; cv=none; b=LHHcmgmz3oTGdxzrN0/x7FLtfHXpt/l48YT584KzYMIib2OQ/8N0TGKo5EooDxhNfrBF5I9QlPIn1bpYUYjJKgA8QG7jyIornTXzvbPo6D+8iqfVu78W832UYCUJX0eGdLiVQxY1TiO00qT4bgQecf1jLS44o9WV7oTVPdQIyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584545; c=relaxed/simple;
	bh=3nbQrS/gkAUwokWSC86E2CAQasLgtUAgcgITiuqnb3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UkxQ6GyxAD0KiXEhIM9oAqGC6cf1s+PL0Dk/XDVPtYCYhEg2U1vBq3oJX2vIX585fwOTMTOpAASDNeuvBANNDRbU3YxMwih1IvjD8+sFLIeZ9pw5GEW4ea7jsjIIIRPxYrR/D+xQESUv1EQDWJsM4CFHiv72O8J37+xkV30Jitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMiTN6X7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMiTN6X7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E66BC113CF;
	Tue, 19 Aug 2025 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584540;
	bh=3nbQrS/gkAUwokWSC86E2CAQasLgtUAgcgITiuqnb3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMiTN6X75cP+4YuNRdwJhHmS8VD46UmR+wd5DAVqWWKRSILtGJzE4/TvX734lui2X
	 VpBDibWFhM2ExB1zHBE9+6kBFwbXvzMapkYL2+EltzQr7p2U6JCaiudL24O95atbQ0
	 OnBIyvWpF3hNLh0cn3AHgNGI0yKq+eM0b5w6NmFeIXmxG/SoOkT8jkHuXD1v6mdZaV
	 ZNT5ggRr22TZkNVBXV24pj/I7bVw0c1evAPOz8zD90PQCki/SDBP0WCpdPfn7hIoX2
	 wCaN0ETIF6zkdy7ZgNxkmpKosOXEiKAlpH0VSMJ34SKnU825glaBUWD1fODoWF4/Xa
	 SWLD6iHEn1UgQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 06/16] mm/damon/paddr: support addr_unit for DAMOS_STAT
Date: Mon, 18 Aug 2025 23:22:17 -0700
Message-Id: <20250819062217.39729-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-7-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Quanmin,

On Wed, 13 Aug 2025 13:06:56 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_STAT action handling from the DAMOS
> operation implementation for the physical address space.

As I suggested on another reply[1], please squash attaching patch to this one
when you post next version of this series.

[1] https://lore.kernel.org/0001-mm-damon-paddr-set-DAMOS_PAGEOUT-stat-in-core-addres.patch

[...]


Thanks,
SJ

==== Attachment 0 (0001-mm-damon-paddr-set-DAMOS_STAT-stat-in-core-address-u.patch) ====
From 30d5bccbebe4ff5ae4d7d73ad857526f1648e786 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 13 Aug 2025 21:29:05 -0700
Subject: [PATCH] mm/damon/paddr: set DAMOS_STAT stat in core address unit

Operations layer should set DAMOS stat in core layer address unit, but
paddr is returning that for STAT in paddr address unit.  Fix it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index beee3bfc503d..5fad2f9a99a0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -296,7 +296,7 @@ static unsigned long damon_pa_stat(struct damon_region *r,
 		}
 
 		if (!damos_pa_filter_out(s, folio))
-			*sz_filter_passed += folio_size(folio);
+			*sz_filter_passed += folio_size(folio) / addr_unit;
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
-- 
2.39.5

