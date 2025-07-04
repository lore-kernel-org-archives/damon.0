Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17D1274B43
	for <damon@lists.linux.dev>; Fri,  4 Jul 2025 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751612776; cv=none; b=qK47BWLwc++LygrElqT7BJvWbFsgZprNz6zvNYi6BOctrGk5Odpy1U2saKmg9ipa2WXtTZyG8rSKM3GmVVF7abMSKMHBh1FXVvu6F1iGqXq6QSzuskYZggzzzGjbXvJYJZmhGvmA/h21cni0/rpsxRCYi5/bsmGFMpQnWKEVG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751612776; c=relaxed/simple;
	bh=z8BuCXeoPjju7vEFWwtgdEFi07D5GI8t4nJ81VSua2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIVMgQI0ATBj8AfxB3aONncBOA69bON+HBC5nNL3neQSsxkqA7Qn8eTAtxAmUl7yIwO6Kkl8ofAxnb8lFWYdIF0IizwjYd9bjFd7yJZ5e5ITNO7zfgY4I6ewaBzM+59iXuLIaPq4ktaDIq0jMTsD38N8/tqJ8WEqA/EN6k/ujXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-8f-68677d5b45aa
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH v2] samples/damon: support automatic node address detection
Date: Fri,  4 Jul 2025 16:05:59 +0900
Message-ID: <20250704070600.1786-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250703165237.43771-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsXC9ZZnoW50bXqGQcs3Vos569ewWTz5/5vV
	4vKuOWwW99b8Z7U4/PUNkwOrx6ZVnWwemz5NYvc4MeM3i8eLzTMZPT5vkgtgjeKySUnNySxL
	LdK3S+DKWDb9GUvBfcWK96vmsDcwHpHqYuTkkBAwkTi44BcbjL36038WEJtNQEPi4KGTzCC2
	iICgRP/jGaxdjFwczAJzGSWOnHnPCJIQFgiWONo0G6yBRUBV4vjS3UwgNq+AuUTj5x/sEEM1
	JRou3QOLcwoYSzw4Ox+sV0iAR+LVhv2MEPWCEidnPgGbwywgL9G8dTYzyDIJgTlsEl9nbmWE
	GCQpcXDFDZYJjPyzkPTMQtKzgJFpFaNQZl5ZbmJmjoleRmVeZoVecn7uJkZgcC6r/RO9g/HT
	heBDjAIcjEo8vBuS0jKEWBPLiitzDzFKcDArifCeFEzPEOJNSaysSi3Kjy8qzUktPsQozcGi
	JM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cBo0l0y8Y3zs6bf3J63DM+bXWtYI6TZnHrVc6Op
	9sctfxRW5v/9YGY9za2iuXvCpfjy9nBBVuvTy+Y+bRVi8dpyaIXeQuFvkp0GeRdfLL5y+s3c
	IwYu86/9mOkdl+YV8bz83GQlm0Ml3fV+6pUvP+/xr2jy2Kd0za30896PmY7LJ9/Su7p97uq3
	SizFGYmGWsxFxYkA3PmVj0oCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsXCNUNWRzeqNj3DYMZxC4s569ewWTz5/5vV
	4vOz18wWh+eeZLW4vGsOm8W9Nf9ZLQ5/fcPkwO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfGsunPWAruK1a8XzWHvYHxiFQXIyeHhICJxOpP
	/1lAbDYBDYmDh04yg9giAoIS/Y9nsHYxcnEwC8xllDhy5j0jSEJYIFjiaNNssAYWAVWJ40t3
	M4HYvALmEo2ff7BDDNWUaLh0DyzOKWAs8eDsfLBeIQEeiVcb9jNC1AtKnJz5BGwOs4C8RPPW
	2cwTGHlmIUnNQpJawMi0ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzD4ltX+mbiD8ctl90OM
	AhyMSjy8G5LSMoRYE8uKK3MPMUpwMCuJ8J4UTM8Q4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusV
	npogJJCeWJKanZpakFoEk2Xi4JRqYBQ2Z/2Tbvnl9L1Pf8r+1nE5vBSO87iqtkEw+ED9df/V
	Kve/ztKdvNmualr91BmL+uqU/ou6Z+mxT7gkwzHNbZ2hfO7n3H079C5Mb/e4cdPvzeMlM6dp
	SRl0vdhYafH+4V3BLx95i58mfX2q4n74/7SqQqHYCr3/WcvEvL4rqt2oND0ipK23gUuJpTgj
	0VCLuag4EQAFrRV1OgIAAA==
X-CFilter-Loop: Reflected

Hello Seongjae,

On Thu,  3 Jul 2025 09:52:37 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hello Yunjeong,
> 
> On Thu,  3 Jul 2025 16:44:22 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > This patch adds a new knob `detect_node_addresses`, which determines
> > whether the physical address range is set manually using the existing
> > knobs or automatically by the mtier module. When `detect_node_addresses`
> > set to 'Y', mtier automatically converts node0 and node1 to their
> > physical addresses. If set to 'N', it uses the existing
> > 'node#_start_addr' and 'node#_end_addr' to define regions as before.
> 
> Thank you for this patch!
> 
> > 
> > Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>
> 
> > ---
> 
> From next time, please consider adding a summary of what changes have made from
> the previous version here, like suggested[1] on the documentation.

Ok, I'll add it next time, thanks:)
One concern I have about this patch is the requirement to set
'detect_node_addresses=Y' before setting 'enable=Y'. Not following
this order causes an error, which makes it difficult for users to use
the module. So, how about removing 'detect_node_address'? Instead, we
could convert node0,1 to physical address automatically by default, and use
existing 'node#_*_addr' values only when those files are explicitly set.
The diff is as follows:

```diff
diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 3a6ae78efafe..03e0540611e0 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -42,9 +42,6 @@ static bool enable __read_mostly;
 module_param_cb(enable, &enable_param_ops, &enable, 0600);
 MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");

-static bool detect_node_addresses __read_mostly;
-module_param(detect_node_addresses, bool, 0600);
-
 static struct damon_ctx *ctxs[2];

 struct region_range {
@@ -110,10 +107,12 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
                goto free_out;
        damon_add_target(ctx, target);

-       if (detect_node_addresses) {
+       if (!node0_start_addr && !node0_end_addr
+                               && !node1_start_addr && !node1_end_addr) {
                ret = promote ? nid_to_phys(1, &addr) : nid_to_phys(0, &addr);
                if (ret)
                        goto free_out;
+
        } else {
                addr.start = promote ? node1_start_addr : node0_start_addr;
                addr.end = promote ? node1_end_addr : node0_end_addr;
```

> 
> >  samples/damon/mtier.c | 42 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 39 insertions(+), 3 deletions(-)
> > 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index f3220d6e6739..3570ebe10fab 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -42,8 +42,34 @@ static bool enable __read_mostly;
> >  module_param_cb(enable, &enable_param_ops, &enable, 0600);
> >  MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
> >  
> > +static bool detect_node_addresses __read_mostly;
> > +module_param(detect_node_addresses, bool, 0600);
> > +
> >  static struct damon_ctx *ctxs[2];
> >  
> > +struct region_range {
> > +	phys_addr_t start;
> > +	phys_addr_t end;
> > +};
> > +
> > +static int nid_to_phys(int target_node, struct region_range *range)
> > +{
> > +
> > +	if (!node_online(target_node)) {
> > +		pr_err("NUMA node %d is not online\n", target_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* TODO: Do we need to support more accurate region range?  */
> 
> I understand you are saying we might need to remove address ranges in the node
> that DAMON will anyway unable to check accesses, e.g., reserved memory.  Since
> those are uusally only a small portion and this is a sample code, I think we
> don't really need to do that, so I think you can drop this TODO comment from
> your next version, if you are gonna make it.
> 

Ok, I will drop that comment from next version.

Best Regards,
Yunjeong Mun

...snip...

> 
> [1] https://docs.kernel.org/process/submitting-patches.html#commentary
> 
> 
> Thanks,
> SJ
