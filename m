Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E231E831
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 11:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916856; cv=none; b=Kai6WMCEFgPovyjqzYRYGXv65NpDBEOz0nuuqvY67/HlNeW80o5X/rEqfwvHujhNaqMvcjG1px5hSZMPIUZOtrJPjidTZkpSHZoASGSj8g1j79Pb+YemMTa1jDeaXs9hv4o/l0NBXb9pEcCPs81r2N9IehS79t1YnwbikfTAWxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916856; c=relaxed/simple;
	bh=3mjX7WcfcancTtegbS+e+IhbqCYDl5myDSgD+gW0G9M=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LwQJvg0zWqV7GqHzUmDaPzrgkHJypNlBWIUNSl0RuHm5/KWhEhvaHcQm19aHlhVLyuvqQf5yVtXEqovtt9hyhxAJfGb3BpKcPjqKZRNHQvZ2zFXzaC6cEaN8bvhCysK8SJHugarfKnVfw1oLzWOhfqzy8blHyMdS6Szd+NQOVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=A0Mp30cD; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="A0Mp30cD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uG90aYSeh/H3DujcabP88VD34ebcZah8ySgmQg5FsGE=;
	b=A0Mp30cDKgYORhoj7WPHdEiyd5t06YCo7QjLgjieghNgf4hjJ4R+gvmI8ZDNr+mR5uxHkl30+
	TB3ZO/E/Etxp8gAj47jCon49EPReSQybkAkwJD3rXIrt680l/IvYsCszZ8vWS7V16i2t3Ey/BDK
	WlvaQDJk4dONS98eA+OosIc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gYpvs36QJzRhQx;
	Mon,  8 Jun 2026 18:59:37 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 2425740561;
	Mon,  8 Jun 2026 19:07:30 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Jun 2026 19:07:29 +0800
Subject: Re: [PATCH 02/10] mm/damon/core: add damon_new_region() debug_sanity
 check
To: SeongJae Park <sj@kernel.org>
CC: Zenghui Yu <zenghui.yu@linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20260607165305.93321-1-sj@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f8d25003-357d-cd65-dcf6-568dcbdc6412@huawei.com>
Date: Mon, 8 Jun 2026 19:07:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260607165305.93321-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200017.china.huawei.com (7.202.194.83)

On 2026/6/8 0:53, SeongJae Park wrote:
> Hello Zenghui,
> 
> On Sun, 7 Jun 2026 23:24:27 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:
> 
> > Hi SeongJae,
> >
> > On 3/6/26 11:29 PM, SeongJae Park wrote:
> > > damon_new_region() is supposed to be called with only valid address
> > > range arguments.  Do the check under DAMON_DEBUG_SANITY.
> > >
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > > ---
> > >  mm/damon/core.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > > index f1a97e85824ac..0c1353164ec81 100644
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -109,6 +109,17 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
> > >  	return err;
> > >  }
> > >  
> > > +#ifdef CONFIG_DAMON_DEBUG_SANITY
> > > +static void damon_verify_new_region(unsigned long start, unsigned long end)
> > > +{
> > > +	WARN_ONCE(start >= end, "start %lu >= end %lu\n", start, end);
> > > +}
> > > +#else
> > > +static void damon_verify_new_region(unsigned long start, unsigned long end)
> > > +{
> > > +}
> > > +#endif
> > > +
> > >  /*
> > >   * Construct a damon_region struct
> > >   *
> > > @@ -118,6 +129,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
> > >  {
> > >  	struct damon_region *region;
> > >  
> > > +	damon_verify_new_region(start, end);
> > >  	region = kmem_cache_alloc(damon_region_cache, GFP_KERNEL);
> > >  	if (!region)
> > >  		return NULL;
> >
> > This can be triggered with
> >
> > 	echo Y > /sys/module/damon_sample_mtier/parameters/enabled
> >
> > because both node{0,1}_{start,end}_addr are 0 if people forget to properly
> > initialize them.
> 
> Nice finding!
> 
> > This can be avoided by checking the parameters right
> > before damon_new_region(). But I'm not sure if this is the correct
> > solution.
> >
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index 775838a23d93..4a5d3fb12e1b 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -118,6 +118,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  	} else {
> >  		addr.start = promote ? node1_start_addr : node0_start_addr;
> >  		addr.end = promote ? node1_end_addr : node0_end_addr;
> > +
> > +		if (addr.start >= addr.end)
> > +			goto free_out;
> >  	}
> >  
> >  	region = damon_new_region(addr.start, addr.end);
> 
> Because mtier is just a sample module, and this doesn't cause a catastrophic
> situation like system crash, I think this is very urgent.

I assume you meant "this is not very urgent" ;) .

> But, given the
> simplicity of the change, this looks good to me.  If you'd like to send a
> patch, please feel free to do.

Sure, I will send it out shortly.

> 
> The real problem in my perspective is, however, the fact that DAMON core is
> not providing a central parameters sanity check.  As a result, each DAMON core
> API callers are implementing their own validation that often and repeatedly
> turns out to be incomplete, like this.  I'm working on such central sanity
> check and further refactoring DAMON API.  Some of work in progress [1] is
> available at damon/next tree.  While the work is ongoing, adding this kind of
> additional check should also be fine.

I do agree with that!

Thanks,
Zenghui
