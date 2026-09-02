Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2C38E8DC;
	Wed,  2 Sep 2026 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329652; cv=none; b=LvyqC+BNWAqhSoQvb7D/94nXSDPJM6BcLwVRGVHY4FahRG1soNqT7JtbBtx+HlnT4bNMq0La2luOHsfdgM3SjqSo/tc7RVkme3G730VtJ1M5CLiu8lRJb1GDnziyhiUfiWRiUFQ8TkhoyOdK846Kg/+KUY3r3JTHxQP8CYFRRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329652; c=relaxed/simple;
	bh=KpmFv3av8tJKSZwWoE+ljhVHf5UhB9x9vRyYoQJVCC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDOC88ubFf+XBcQniXJT5k6mAcWKU/Hle7/0EILXP09Gmnft5CC3Wwb/SuVE0Y8FLgyLjL9eoRwUNIDOkhqQXIiJLny/RO3Czg0YcsN7cmI2M/po6xmvbxe/K2qI1Ahnj5yKtB5Yq1njqtCzHHxo42QJYjGlU0VE8xwQva1IZ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0HEzdLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0HEzdLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672511F000E9;
	Wed,  2 Sep 2026 06:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329648;
	bh=K5x2CbYRmNV3MA8rM8UuqBOVvPVm0QxSLiJJvUd4pl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J0HEzdLcQyh+gjzjo4CoIOYJFrANeLY4gXMg1LyNcjFr6rWcrj0m/Hafy9aqPlCSF
	 ALFYGKLVhJmI+q6ot5Cvvenug3O+vhPsA5Dig7YijlgHp48jO1apupvCWM5RxwsPR0
	 ZSmAYVD1chgBRb3d4X+RsEKZqmhvo0CQ5h1gNXbLTMHitAkbG19K+nc/GFekZmLVww
	 CZRdawX6Kt4Qdf4noDfuKuFk0CoGYSs4ghtC2riWMDu603LGfoKn6YxOve03JgNrgD
	 Zwttkptd+C2o5Nk2KWES1+sZ78juWyiHPYDlVnZHYopac3ztyAQhZKdwJrgKdp7thx
	 xte1xVh8i/GBQ==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 02/12] mm/damon/core: remove debug messages
Date: Tue,  1 Sep 2026 23:14:00 -0700
Message-ID: <20260902061401.104419-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  1 Sep 2026 22:47:35 -0700 SJ Park <sj@kernel.org> wrote:

> There are a few debug messages in DAMON core.  Those have not really
> been used in a meaningful way for the last few years, though.  Remove
> those.

Hi Andrew,


Sashiko found with this patch, string_choices.h can also be excluded.  It is
the only finding.  I guess reposting entire series for the small change is too
much?  Could you please add below attaching fixup patch when you pick this?
Let me know if you prefer reposting.


Thanks,
SJ

=== >8 ===
From b9c86e50efd30bab8c5cb99b3063bd823184b033 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 1 Sep 2026 23:08:16 -0700
Subject: [PATCH] mm/damon/core: remove string_choices.h include

It is no more being used.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index a7ed7724c85af..84f6bc634f377 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/string_choices.h>

 /* for damon_get_folio() used by node eligible memory metrics */
 #include "ops-common.h"
--
2.47.3

