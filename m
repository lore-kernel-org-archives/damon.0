Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C128E59E
	for <damon@lists.linux.dev>; Thu,  3 Jul 2025 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519932; cv=none; b=JjisouZQhcCwaDzuroSQul9RPQ861U6oXfseJsE6tDzLtsPa0yioo8sJhL2ZtM4GNLL1j8d69Wj4tM/0QEmADoq83QGcI5gKvb28tx63KS9+NhtWlq6x21kcz4gaTvCXbUloDMe7GCg1yfzR2aRijw6k9UCBEzFAqOK06FlyaUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519932; c=relaxed/simple;
	bh=od6BMh77nLIn/LqNh/jPu9UNnj32+d4SbcjasfbAgEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpyQKH/VG6+BfmKcH6wRaXZOyBShaaZyhthng0VkTrR3yy2m47tDPD06jQDRLMdXwiwRpZqxG7lT5XE7YWdZqrldfWOV+uPJzMgEUB0X7aOSWCCzzdIng3pkyVxmZcMW2xRXgPpaosoJkXK0dcY3SGTsWqFLBzXQyslfVH38Qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-e9-686612ae7f4d
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com
Subject: Re: [RFC PATCH 1/2] samples/damon: convert node id to physical address
Date: Thu,  3 Jul 2025 14:18:33 +0900
Message-ID: <20250703051836.1759-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250701235407.57420-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsXC9ZZnke46obQMg91vTS3mrF/DZvHk/29W
	i8u75rBZ3Fvzn9Xi8Nc3TA6sHptWdbJ5bPo0id3jxIzfLB4vNs9k9Pi8SS6ANYrLJiU1J7Ms
	tUjfLoErY8OMZ6wFM9QrfrxfydzAOF++i5GTQ0LARGLL2VssMHbDqWeMIDabgIbEwUMnmUFs
	EQFBif7HM1i7GLk4mAXmMkocOfMerEhYwF/i/aNzYM0sAqoSWz/cBLI5OHgFzCV+v3KFmKkp
	0XDpHhOIzSlgLDHzyQuwViEBHolXG/aD2bxA80/OfAI2hllAXqJ562xmkF0SAjPYJI58O8YE
	MUhS4uCKGywTGPlnIemZhaRnASPTKkahzLyy3MTMHBO9jMq8zAq95PzcTYzA0FxW+yd6B+On
	C8GHGAU4GJV4eB3kUzOEWBPLiitzDzFKcDArifDyySZnCPGmJFZWpRblxxeV5qQWH2KU5mBR
	Euc1+laeIiSQnliSmp2aWpBaBJNl4uCUamA069+3/7wkO+PdKd+tZnyQOPT5v+blS33zXijZ
	7OJ/OSljmum1JTpTqsWrsxQ/Oz+ZVvkj1u3A89fsjXP+bV2298XqPkcpARWHsI/BkX/qfx+I
	PVX46+2qNqEzlX5Sc8wuXuPSmnB2395Wzd3Xr/FEi+19Ymq0fFNUnWak1LbZO09ILJpt7xKb
	ocRSnJFoqMVcVJwIACjIEGdJAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsXCNUNWR3edUFqGwd6bWhZz1q9hs3jy/zer
	xednr5ktDs89yWpxedccNot7a/6zWhz++obJgd1j06pONo9Nnyaxe5yY8ZvF48XmmYwe3257
	eCx+8YHJ4/MmuQD2KC6blNSczLLUIn27BK6MDTOesRbMUK/48X4lcwPjfPkuRk4OCQETiYZT
	zxhBbDYBDYmDh04yg9giAoIS/Y9nsHYxcnEwC8xllDhy5j1YkbCAv8T7R+dYQGwWAVWJrR9u
	AtkcHLwC5hK/X7lCzNSUaLh0jwnE5hQwlpj55AVYq5AAj8SrDfvBbF6g+SdnPgEbwywgL9G8
	dTbzBEaeWUhSs5CkFjAyrWIUycwry03MzDHVK87OqMzLrNBLzs/dxAgMvWW1fybuYPxy2f0Q
	owAHoxIPr4N8aoYQa2JZcWXuIUYJDmYlEV4+2eQMId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe
	4akJQgLpiSWp2ampBalFMFkmDk6pBkazVB4ZrlC3w16tDlGfMiQyD8dOq8q65WMvadtVVnrk
	WuJsDv19HssvG4lfjE+M/18jNHfiMk/nd0I7f2cZFzUf285mxm5WecA4p2HOFn035R1HstbK
	Llz9X5c7xDeDbY4V//mX+/Y124i+15CfP89sW/mtZ8Gruho387DukWbuqzXR0vX3V2Ipzkg0
	1GIuKk4EAK+2G/o5AgAA
X-CFilter-Loop: Reflected

Hi Seongjae, thanks for your review :)

On Tue,  1 Jul 2025 16:54:07 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hi Yunjeong,
> 
> On Tue,  1 Jul 2025 17:54:16 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > This patch removes the `node#_start_addr` and `node#_end_addr` knobs,
> > and introduces logic for converting numa node id to physical address.
> > It only checks whether a numa node is online and calculates the
> > start and end addresses of the node. It does not verify whether each
> > memory block within the numa node is `usable` or part of `System RAM`,
> > as performed by `damo` [1],[2].
> 
> This is just a sample module, but I'd like to avoid making unnecessary
> user-breaking changes.  How about keeping the existing knobs but adding yet
> another knob for the automatic detection, say, 'detect_node_addresses'?
> 

I agree. From my understanding, 'detect_node_addresses' can be set to 
either 'Y' or 'N'. If it is set to 'Y', mtier converts node0 and node1
to their physical addresses internally. If it is set to 'N', it uses
the existing knobs. Is that correct? 

> > 
> > [1]
> > https://github.com/damonitor/damo/blob/v2.8.5/src/damo_pa_layout.py#L72-L90
> > [2]
> > https://github.com/damonitor/damo/blob/v2.8.5/src/damo_pa_layout.py#L92-L10
> > 
> > Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
> > Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>
> > ---
> >  samples/damon/mtier.c | 44 ++++++++++++++++++++++++++++---------------
> >  1 file changed, 29 insertions(+), 15 deletions(-)
> > 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index f3220d6e6739..ba6938a89c21 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> > @@ -12,18 +12,6 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  
> > -static unsigned long node0_start_addr __read_mostly;
> > -module_param(node0_start_addr, ulong, 0600);
> > -
> > -static unsigned long node0_end_addr __read_mostly;
> > -module_param(node0_end_addr, ulong, 0600);
> > -
> > -static unsigned long node1_start_addr __read_mostly;
> > -module_param(node1_start_addr, ulong, 0600);
> > -
> > -static unsigned long node1_end_addr __read_mostly;
> > -module_param(node1_end_addr, ulong, 0600);
> > -
> >  static unsigned long node0_mem_used_bp __read_mostly = 9970;
> >  module_param(node0_mem_used_bp, ulong, 0600);
> >  
> > @@ -44,6 +32,28 @@ MODULE_PARM_DESC(enable, "Enable of disable DAMON_SAMPLE_MTIER");
> >  
> >  static struct damon_ctx *ctxs[2];
> >  
> > +struct region_range {
> > +	phys_addr_t start;
> > +	phys_addr_t end;
> > +};
> > +
> > +static int numa_info_init(int target_node, struct region_range *range) {
> > +
> 
> checkpatch.pl complaints as below.
> 
> ERROR: open brace '{' following function definitions go on the next line
> #82: FILE: samples/damon/mtier.c:40:
> +static int numa_info_init(int target_node, struct region_range *range) {
> 
> > +	if (!node_online(target_node)) {
> > +		pr_err("NUMA node %d is not online\n", target_node);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* TODO: Do we need to support more accurate region range?  */
> > +	unsigned long start_pfn = node_start_pfn(target_node);
> > +	unsigned long end_pfn   = node_end_pfn(target_node);
> > +
> > +	range->start = (phys_addr_t)start_pfn << PAGE_SHIFT;
> > +	range->end  = (phys_addr_t)end_pfn << PAGE_SHIFT;
> 

I'll fix them in the next version.

> Let's use PHYS_PFN() instead.

Okay, I'm going to change it with PFN_PHYS()

> > +
> > +	return 0;
> > +}
> > +
> >  static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  {
> >  	struct damon_ctx *ctx;
> > @@ -53,6 +63,7 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  	struct damos *scheme;
> >  	struct damos_quota_goal *quota_goal;
> >  	struct damos_filter *filter;
> > +	struct region_range addr;
> >  
> >  	ctx = damon_new_ctx();
> >  	if (!ctx)
> > @@ -82,9 +93,12 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  	if (!target)
> >  		goto free_out;
> >  	damon_add_target(ctx, target);
> > -	region = damon_new_region(
> > -			promote ? node1_start_addr : node0_start_addr,
> > -			promote ? node1_end_addr : node0_end_addr);
> > +
> > +	int ret = promote ? numa_info_init(1, &addr) : numa_info_init(0, &addr);
> > +	if (ret)
> > +		goto free_out;
> 
> Yet another checkpatch.pl complain.
> 
> WARNING: Missing a blank line after declarations
> #119: FILE: samples/damon/mtier.c:98:
> +       int ret = promote ? numa_info_init(1, &addr) : numa_info_init(0, &addr);
> +       if (ret)
> 
> > +
> > +	region = damon_new_region(addr.start, addr.end);
> >  	if (!region)
> >  		goto free_out;
> >  	damon_add_region(region, target);
> > -- 
> > 2.34.1
> 
> 

Thanks for your detailed reviw! Next time, I will make sure to check 
checkpatch.pl:)

Best Regards,
Yunjeong Mun

> Thanks,
> SJ
