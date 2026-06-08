Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8433312832
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934070; cv=none; b=ijHglmIdeqWOqcrYtf+sAZYT8HycBb/WIyRcrI4yquaPRoXszA6xsXCgbT2eQWZOCzmiI41nwxV08vuYF2UYGXnqH6xuk6ZJbKCp/kgRlKaPURcY0bPuixTVMoXmKPsTFGviTQVfyz02viR9+xlamdvmSkzyl4/E9tbTzFn64aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934070; c=relaxed/simple;
	bh=vxCvneRwA2LKmJ43VX3SfCHAl/SNcNM3zWzgNdAVRDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3eIL7jHPn+CDN1MYNqQ1A2db9paMoYU6h0+AlgmGs5S/MlNAxcToD75SKA30Qy84V+WT4CBM/FlSiD8g/OmH5O/HkcP38Yfk2Jag9lTzQYTb0xDD6bau7M9tQHMwD23IobFoB85KXIn9KOol3iJyQ7tGNML7u1BIbKPvmp5w2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rNPbqq1I; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rNPbqq1I"
Message-ID: <a0945974-5e58-477e-9786-e14ea2fbcdbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780934065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e2VJEUHPiaVEzDajlyn44RRt816M9gMkmZzGYOPYKs=;
	b=rNPbqq1I7hkbyj7+TSLh7GUGIafvhL/CrNoQS89F78tQY8IyKTNll6zSvfH+Sv7h+4xjkc
	QsF5QGVQSTsv9n0ITb3SeskKIhfABcUz1mfN7/wRz9A1OJTwv0ZfxVN0ScUi/1Ih1umJUs
	ubYHA+pS+iTErOxRwpTwXGJ9p1GDr1c=
Date: Mon, 8 Jun 2026 23:54:13 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH] samples/damon/mtier: fail early if address range
 parameters are invalid
To: SeongJae Park <sj@kernel.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 wangzhigang17@huawei.com, liqiqi23@huawei.com
References: <20260608143250.69024-1-sj@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260608143250.69024-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi SeongJae,

On 6/8/26 10:32 PM, SeongJae Park wrote:
> On Mon, 8 Jun 2026 19:15:34 +0800 Zenghui Yu <yuzenghui@huawei.com> wrote:
> 
> > The comment on top of `struct damon_region` clearly says that
> >
> >     For any use case, @ar should be non-zero positive size.
> >
> > which is now verified in damon_verify_new_region() if the kernel is built
> > with DAMON_DEBUG_SANITY.
> >
> > The WARN_ONCE() can be triggered if the mtier sample module is enabled
> > before node{0,1}_{start,end}_addr have been properly initialized, which is
> > obviously not good.
> >
> >  ------------[ cut here ]------------
> >  start 0 >= end 0
> >  WARNING: mm/damon/core.c:116 at damon_new_region+0xf0/0x118, CPU#39: bash/34144
> >  Call trace:
> >   damon_new_region+0xf0/0x118 (P)
> >   damon_sample_mtier_build_ctx+0xd4/0x368
> >   damon_sample_mtier_start+0x1c/0x90
> >   damon_sample_mtier_enable_store+0x98/0xb0
> >   param_attr_store+0xb4/0x128
> >   module_attr_store+0x2c/0x50
> >   sysfs_kf_write+0x58/0x90
> >   kernfs_fop_write_iter+0x16c/0x238
> >   vfs_write+0x2c0/0x370
> >   ksys_write+0x74/0x118
> >   __arm64_sys_write+0x24/0x38
> >   invoke_syscall+0xa8/0x118
> >   el0_svc_common.constprop.0+0x48/0xf0
> >   do_el0_svc+0x24/0x38
> >   el0_svc+0x54/0x370
> >   el0t_64_sync_handler+0xa0/0xe8
> >   el0t_64_sync+0x1ac/0x1b0
> >  ---[ end trace 0000000000000000 ]---
> >
> > Fix it by checking the validity of parameters right before
> > damon_new_region() and fail early if they're invalid.
> 
> Good catch, thank you for this patch.
> 
> >
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > ---
> >  samples/damon/mtier.c | 3 +++
> >  1 file changed, 3 insertions(+)
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
> 
> Sashiko found [1] same issue can happen if detect_node_addresses is true, and
> nodes 0 and 1 are both memoryless.  It shouldn't be a blocker of this patch,
> but fixing it together can be very simple by moving this address check to the
> out of the above if block, right here.  Zenghui, could you please update this
> patch to do that?

Yup, it's worth fixing. I will address the detect_node_addresses issue
in v2.

> 
> Also, seems this patch is based on an old tree.  Could you please use
> mm-new [2] as the base of your DAMON patches from next time?

Ah, I'm not familiar with the development process of DAMON and I created
this patch against mainline kernel. I'll re-test the whole thing on top
of mm-new. Thanks for the reminder!

Zenghu
