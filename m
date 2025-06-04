Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2D1E47AD;
	Wed,  4 Jun 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070584; cv=none; b=qsdLMiBpdrJMrMZPAbM5+ZhrKNnEJkCXhMD1F/LQbp2aq9gCQdJrEr/wnC/yH3yBnmYtexRWGjnHK5f/hLM86xqBI6oww0DDyM6M6s7soPDl1swK8SYq5SsxXj2/ngBqyuaKPUMYxmy4nftFIhusC0oZ0UBUlKxx5VBII/aatRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070584; c=relaxed/simple;
	bh=Xrqp4qshtj+SrwBUZQ6jlW6C4TgbY0f+Gxe9VE3u0CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3N/R0ya8kiKlDX7+gklTwD7e2KsCfGhXidGl15pYb76Q2KgzHep2kDt3Yc8R2pMdiPlTxNsUWAFFlZ+c0+1fV5Pqfsy7d1uTnrcvZwZ5m2zySZ84Sy4V2sGTdnldffcGk9T31ELOhXQmk2kLw+QTqfdh0qNTFYvE5BHzn/zOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffOLn00/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffOLn00/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAACC4CEE4;
	Wed,  4 Jun 2025 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749070584;
	bh=Xrqp4qshtj+SrwBUZQ6jlW6C4TgbY0f+Gxe9VE3u0CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ffOLn00/Fi1eLYMq8xonnGIUQ2AsEk1k2hn+xcR4W+Qcr+3pcUQ8/34gdM3EHdHr1
	 f39V/UjMTM0PZ9ChkBX2Y6SMTXDaXvTOjojZ+GeyyUQuBPoqlqykJH6GRnh58PddUW
	 zgQGtH3rvVgi3gc4PeQTZYdyqfF3Fmk6RWW4q3wRRbSxKKuAAHPNr0USNXeTYncnfc
	 6mRYxz7er6KQuObqq/UKdTVdIYzJXathq5G9SGXZiGDjq2AZFIAESrnPHGw610JkL/
	 /fY/sF/BExRhHBZ7qodlOvpIGz12ZaB/zq82rA147OXjNLBNiPWePl3185sa79mc9x
	 krSmKMAL/XjTw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/4] mm/damon: introduce DAMON_STAT module
Date: Wed,  4 Jun 2025 13:56:19 -0700
Message-Id: <20250604205619.18929-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604183127.13968-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed,  4 Jun 2025 11:31:24 -0700 SeongJae Park <sj@kernel.org> wrote:

[...]
> --- /dev/null
> +++ b/mm/damon/stat.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Shows data access monitoring resutls in simple metrics.
> + */
> +
> +#define pr_fmt(fmt) "damon-stat: " fmt
> +
> +#include <linux/damon.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sort.h>
> +
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "damon_stat."
> +
> +static int damon_stat_enabled_store(
> +		const char *val, const struct kernel_param *kp);
> +
> +static const struct kernel_param_ops enabled_param_ops = {
> +	.set = damon_stat_enabled_store,
> +	.get = param_get_bool,
> +};
> +
> +static bool enabled __read_mostly = CONFIG_DAMON_STAT_ENABLED_DEFAULT;

Oops, I forgot using IS_ENABLED() here.  Andrew, could you please add below
fixup?


Thanks,
SJ

===== >8 =====
From bc2a2c580f6f89f3f7d4f92c2bde3f4a4fac3409 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 4 Jun 2025 13:48:30 -0700
Subject: [PATCH] mm/damon/stat: use IS_ENABLED() for enabled initial value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The initial value of enabled parameter is set as
CONFIG_DAMON_STAT_ENABLED_DEFAULT, so get below build error when the
config is not enabled.  Fix it using IS_ENABLED().

    mm/damon/stat.c:27:37: error: ‘CONFIG_DAMON_STAT_ENABLED_DEFAULT’ undeclared here (not in a function)
       27 | static bool enabled __read_mostly = CONFIG_DAMON_STAT_ENABLED_DEFAULT;
          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 7ef13ea22221..3686f67befc3 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -24,7 +24,8 @@ static const struct kernel_param_ops enabled_param_ops = {
        .get = param_get_bool,
 };

-static bool enabled __read_mostly = CONFIG_DAMON_STAT_ENABLED_DEFAULT;
+static bool enabled __read_mostly = IS_ENABLED(
+               CONFIG_DAMON_STAT_ENABLED_DEFAULT);
 module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");

--
2.39.5
