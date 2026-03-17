Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04502288CA3;
	Tue, 17 Mar 2026 04:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773721605; cv=none; b=IO1pFKfGyYLX9BqBMWFGL+4zLfPwxt40YDPYoyUlU/zXQYXeYGmlBdAwh1gSuscBgVLrsIXdbP+Fi4VcFYfBxlSnp/1hDN/AeA8Jd0MVQLPShaeAqyC4uC+VkYh2ib1egend48MzzZGQMXrE+vXf5RgDNIqm+zanTesEePRvozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773721605; c=relaxed/simple;
	bh=9Awbsg9vh3gWdgsI7WEfqFc76xhAUT4VlXF2nd696zU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INKlJCPRwq9WKSySzky+YLYyV4wQBhzPFcxExIXdTT/Rc1NqWFRsA/J7RzNO6lQoDTv6fqn9VeZtaou/vQOon2GaIVyUri/6QGXHawTMnjGxwUWx+ZzVH5BpIJ97Z/qDVAEM8ULxEZPaE8ik4HqHu1Tc7Ii7sG1qCMiUWLQbcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTlKDKdU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTlKDKdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE1DC4CEF7;
	Tue, 17 Mar 2026 04:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773721604;
	bh=9Awbsg9vh3gWdgsI7WEfqFc76xhAUT4VlXF2nd696zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTlKDKdUnmgfyYNkASSEovavhFg0JzcPEcID2tWKD+t9hZfDJIphX6Jwe4Ovvb0fw
	 NakPVIK08JsWL08u9dQpaD2h5EcPIXxFn0vg+3fn9u/KKKtVvfEN+pe/Rrq87fDPYX
	 izLXK/AkoxyMwP2PMH43/WVP3p1Cr6bqwLSYlxBu61OjSvcp8Rm1zRrhKkuAuZHOtO
	 z3ywTtyCOBYy1/NIHPxQPgmqND/5wuLB2r3+tjf1FCmvvFci7ijoxyA/Rl0C7TRxE4
	 WsBAoVoWZSkq/Xrb6PU+i54mTsoMi+J2aTPXrDdHRX3G1OXCtKA+xi2kHObVpz3hCl
	 ERRYYI8whqoBg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 02/10] mm/damon/sysfs: add pause file under context dir
Date: Mon, 16 Mar 2026 21:26:36 -0700
Message-ID: <20260317042637.917-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315210012.94846-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 15 Mar 2026 14:00:01 -0700 SeongJae Park <sj@kernel.org> wrote:

> Add pause DAMON sysfs file under the context directory.  It exposes the
> damon_ctx->pause API parameter to the users so that they can use the
> pause/resume feature.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 576d1ddd736bf..4cbb8b9aaba3c 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -866,6 +866,7 @@ struct damon_sysfs_context {
>  	struct damon_sysfs_attrs *attrs;
>  	struct damon_sysfs_targets *targets;
>  	struct damon_sysfs_schemes *schemes;
> +	bool pause;
>  };

sashiko.dev comments [1] below.

: Is the new pause field left uninitialized when a context is allocated?
: 
: Looking at damon_sysfs_context_alloc(), memory is allocated via kmalloc_obj()
: which does not zero-fill by default, and the new field is not explicitly
: initialized:
: 
: static struct damon_sysfs_context *damon_sysfs_context_alloc(
:                 enum damon_ops_id ops_id)
: {
:         struct damon_sysfs_context *context = kmalloc_obj(*context);
: 
:         if (!context)
:                 return NULL;
:         context->kobj = (struct kobject){};
:         context->ops_id = ops_id;
:         context->addr_unit = 1;
:         return context;
: }
: 
: If a user reads the pause sysfs file before writing to it, could this return
: uninitialized kernel heap memory?

Good catch.  I will add below fixup to the next spin.

'''
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1432,6 +1432,7 @@ static struct damon_sysfs_context *damon_sysfs_context_alloc(
        context->kobj = (struct kobject){};
        context->ops_id = ops_id;
        context->addr_unit = 1;
+       context->pause = false;
        return context;
 }
'''

Btw, somehow sashiko.dev added the comment to not this patch but the sixth
patch of this series.

[1] https://sashiko.dev/#/patchset/20260315210012.94846-7-sj@kernel.org


Thanks,
SJ

[...]
