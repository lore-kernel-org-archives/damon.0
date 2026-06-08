Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DC23B774F;
	Mon,  8 Jun 2026 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929179; cv=none; b=TzMNB/ywcmOX4JGE2HEyfwwAlo9izWnCPYs9T1HWRkdYIZoiW8VP/dGQGQhLlL1++BiH/AxIkyo4JyPUFZVVlX/YF8aG6sd1aWxGghJWx6053OBgumtg6tCtq6YaKwDqQ53VJMyVdSWCvRh96bKfuRsRKoXvHx4E0OIY/TvVKig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929179; c=relaxed/simple;
	bh=e0Iw/K92Cup+OzGbERgiEBNCMw61r0AuolmKzIUFIrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClCs2V50nme8JXZLnrttrxUQrXBL/BCwG++o5Ka16y4rfcdCGXKGbL76BKBz2NPZ6OoP7b0ZyFD5M639+0RpRK7usopaSiZYiTJI21OyU7MBy3FHQTmcQZuHDmBZjfe0qdlgunXgePff5rm4fHBPxE6P43A2N2N3N9DAx+tC8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEsURHEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEsURHEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1F21F00893;
	Mon,  8 Jun 2026 14:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780929178;
	bh=Qy6RsutX/3EyVvMKECKZYGii+tGoP9bV2Cwg6nx5MYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEsURHEf+SyzeAxZqsgtOJg6ZDapk8ZljfaEDNhoKiKBwqIoUfkXVTVRH2YlKK17P
	 Rv3AB3+hIAkCAKvTE4ImtOEsqj/I0QTrihl04ffmcoKkWW+EkJJTc2wEZNF7+rk+b/
	 tQXl8BQ1/hMHLIDy/O+xITkpYuuHWnyoR0Nf35JYBOvAu34+vHU4hCw/8XI+Yja1Ml
	 +PLPVMrXqIedo43nx1UcSHJC9usaHhGIsMquSuSEheOS4Jq6Dyq+iCrx5Sc/7zJsSL
	 oiF9oVYNlGEQ5X1o8nRTVcOENm6PekOG2F1fqlla+yyVmZz6E/vnKsR5QT37hNCXTg
	 RJn/uEb+rjgEw==
From: SeongJae Park <sj@kernel.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	wangzhigang17@huawei.com,
	liqiqi23@huawei.com
Subject: Re: [PATCH] samples/damon/mtier: fail early if address range parameters are invalid
Date: Mon,  8 Jun 2026 07:32:49 -0700
Message-ID: <20260608143250.69024-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608111534.264-1-yuzenghui@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 8 Jun 2026 19:15:34 +0800 Zenghui Yu <yuzenghui@huawei.com> wrote:

> The comment on top of `struct damon_region` clearly says that
> 
>     For any use case, @ar should be non-zero positive size.
> 
> which is now verified in damon_verify_new_region() if the kernel is built
> with DAMON_DEBUG_SANITY.
> 
> The WARN_ONCE() can be triggered if the mtier sample module is enabled
> before node{0,1}_{start,end}_addr have been properly initialized, which is
> obviously not good.
> 
>  ------------[ cut here ]------------
>  start 0 >= end 0
>  WARNING: mm/damon/core.c:116 at damon_new_region+0xf0/0x118, CPU#39: bash/34144
>  Call trace:
>   damon_new_region+0xf0/0x118 (P)
>   damon_sample_mtier_build_ctx+0xd4/0x368
>   damon_sample_mtier_start+0x1c/0x90
>   damon_sample_mtier_enable_store+0x98/0xb0
>   param_attr_store+0xb4/0x128
>   module_attr_store+0x2c/0x50
>   sysfs_kf_write+0x58/0x90
>   kernfs_fop_write_iter+0x16c/0x238
>   vfs_write+0x2c0/0x370
>   ksys_write+0x74/0x118
>   __arm64_sys_write+0x24/0x38
>   invoke_syscall+0xa8/0x118
>   el0_svc_common.constprop.0+0x48/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x54/0x370
>   el0t_64_sync_handler+0xa0/0xe8
>   el0t_64_sync+0x1ac/0x1b0
>  ---[ end trace 0000000000000000 ]---
> 
> Fix it by checking the validity of parameters right before
> damon_new_region() and fail early if they're invalid.

Good catch, thank you for this patch.

> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  samples/damon/mtier.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 775838a23d93..4a5d3fb12e1b 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -118,6 +118,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
>  	} else {
>  		addr.start = promote ? node1_start_addr : node0_start_addr;
>  		addr.end = promote ? node1_end_addr : node0_end_addr;
> +
> +		if (addr.start >= addr.end)
> +			goto free_out;
>  	}

Sashiko found [1] same issue can happen if detect_node_addresses is true, and
nodes 0 and 1 are both memoryless.  It shouldn't be a blocker of this patch,
but fixing it together can be very simple by moving this address check to the
out of the above if block, right here.  Zenghui, could you please update this
patch to do that?

Also, seems this patch is based on an old tree.  Could you please use
mm-new [2] as the base of your DAMON patches from next time?

[1] https://lore.kernel.org/20260608112455.274231F00893@smtp.kernel.org
[2] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
