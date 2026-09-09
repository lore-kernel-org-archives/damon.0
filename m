Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8658F087
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963969; cv=none; b=H5n0zHMvr0Lov0E5LuPBxIVx2bY4PqhP9/araJvDe81YjicKhgMQzMfgzCU6JeYQjhVaBMeYXvjaJZ8WliMgKbNDhSLz50IDvrZ/DcPAQmbNL+3rYlt7qs/wS2H/cWnbSwxvtFxfIJ6zKbp+4l5VJf6MnNVHpyGOalpw0ZjM7xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963969; c=relaxed/simple;
	bh=/JZBWkbPMNO2Wbck+fb29JHZnM9if6zq5ZB5GMviNY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DIbr20Vt1e28Ldq6/DXZOHSLf6qdKia4/kTpprAIKy6vSCTtqUw4vh/MQHKAM3tAu5TNtb5fUb6Ny4/xUU/O2QZTIbEZdAqsO+U3qCuIFE6tPvWLWGetNrkdu6fibOVyIXx/x2v1h6uMx8xg9ByfToNjB862NC0x8USsTQE4I5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b=NS5VlChU; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei-partners.com header.i=@huawei-partners.com header.b="NS5VlChU"
dkim-signature: v=1; a=rsa-sha256; d=huawei-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KW2RH9Ty/MdWv03UCeHROV7nkGt/GjJzoRCaA3lG9QM=;
	b=NS5VlChUHQnDGlfjHbgtKyLbpa1LeNZBAxGSb9dg5o/ZpnoIdR/A5pxXvv0edfCXBEIGgNxlz
	SqDIWm1BKuT+5oLz27TfH/NNR4yp03O+btU/bbs7LTZD6FxIVjHXa74C0fQiL27Wp6FhAkezOBE
	FWwAjEwrq9bruxkSiahHCdI=
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hg33k3JQYzHnGj0;
	Wed,  9 Sep 2026 22:24:50 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 416564058D;
	Wed,  9 Sep 2026 22:25:52 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 17:25:51 +0300
Message-ID: <6f1e4bde-da16-4510-b1c6-16ba2a24d3f3@huawei-partners.com>
Date: Wed, 9 Sep 2026 17:25:51 +0300
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH REPOST 0/5] mm/damon/vaddr: support {prep,apply}_probes
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: <damon@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20260909140408.104699-1-sj@kernel.org>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <20260909140408.104699-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi SJ,

On 9/9/2026 5:04 PM, SJ Park wrote:
> DAMON supports data attributes monitoring.  However, only the physical
> address space operation set (paddr) is supporting it.  Add the support
> to the virtual address space operation set (vaddr).
> 
> Patch 1 adds prep_probes support to vaddr.  Patch 2 moves probe filter
> handling code in paddr.c that can be reused by vaddr to ops-common.c.
> Patch 3 adds minimum apply_probes support to vaddr.  Patch 4 extends the
> support for hugetlb.  Patch 5 extends the support for pgidle_unset
> filter.
> 
> Test
> ====
> 
> I confirmed it can capture ~48 mb working set of masim in vaddr mode,
> like below.
> 
> First, start masim [1] to access ~48 mb memory at a time, in the
> background.
> 
>     $ ./masim/masim.py run \
>             --config_file ./masim/configs/stairs-50mb.cfg \
>             --repeat 10 --quiet &
> 
> Note that the config says the working set is 50mb.  It is 50 million
> bytes, so ~48 MiB.
> 
> Start traditional access monitoring of masim's virtual address space
> using damo [2].
> 
>     $ sudo ./damo/damo start $(pidof masim)
> 
> Confirm it can capture the ~48 MiB working set as the 4-th region on the
> snapshot.
> 
>     $ sudo ./damo/damo report access
>     heatmap:
>     11111111334[...]3000000000000000000000000000000000000000489999997777777743333333555556[...]8
>     # min/max temperatures: -1,150,000,000, 80,009,499, column size: 6.963
>     MiB
>     intervals: sample 5 ms aggr 100 ms (max access hz 200)
>     0   addr 85.355 TiB   size 55.703 MiB  access 0 hz   age 9.500 s
>     1   addr 85.355 TiB   size 18.984 MiB  access 0 hz   age 6.700 s
>     2   addr 127.183 TiB  size 278.516 MiB access 0 hz   age 11.500 s
>     3   addr 127.183 TiB  size 7.570 MiB   access 0 hz   age 900 ms
>     4   addr 127.183 TiB  size 48.133 MiB  access 190 hz age 800 ms
>     5   addr 127.183 TiB  size 54.977 MiB  access 0 hz   age 1.700 s
>     6   addr 127.183 TiB  size 55.113 MiB  access 0 hz   age 6.700 s
>     7   addr 127.183 TiB  size 37.902 MiB  access 0 hz   age 3.900 s
>     8   addr 127.990 TiB  size 120.000 KiB access 0 hz   age 11.400 s
>     9   addr 127.990 TiB  size 8.000 KiB   access 70 hz  age 0 ns
>     10  addr 127.990 TiB  size 4.000 KiB   access 0 hz   age 11.200 s
>     memory bw estimate: 8.931 GiB per second
>     total size: 557.027 MiB
>     record DAMON intervals: sample 5 ms, aggr 100 ms
> 
> Stop access monitoring and start probe-only mode access monitoring.
> 
>     $ sudo ./damo/damo stop
>     $ sudo ./damo/damo start $(pidof masim) --probe_prep set_pgidle \
>             --probe_filter allow pgidle_unset --probe_weight 1
> 
> Confirm it can also capture the ~48 MiB working set as the 11-th region
> on the snapshot.
> 
>     $ sudo ./damo/damo report attrs
>     heatmap:
>     00000000113[...]40000000000000000000000000000000000000000000000001111114999999533333336[...]6
>     # min/max temperatures: -840,000,000, 330,002,000, column size: 6.961
>     MiB
>     probe prep: set_pgidle, filter: allow pgidle_unset (weight: 1)
>     intervals: sample 5 ms aggr 100 ms (max probe hits 20)
>     #   size         address       age           probe_hits
>     0   8.000 KiB    127.990 TiB   8.700 s       0
>     1   120.000 KiB  127.990 TiB   8.600 s       0
>     2   55.543 MiB   127.183 TiB   8.400 s       0
>     3   110.008 MiB  127.183 TiB   8.300 s       0
>     4   55.352 MiB   127.183 TiB   8.100 s       0
>     5   55.605 MiB   127.183 TiB   8 s           0
>     6   55.691 MiB   85.355 TiB    7.900 s       0
>     7   54.430 MiB   127.183 TiB   7.900 s       0
>     8   50.391 MiB   127.183 TiB   6.900 s       0
>     9   18.879 MiB   85.355 TiB    6 s           0
>     10  52.844 MiB   127.183 TiB   3.500 s       0
>     11  48.039 MiB   127.183 TiB   3.300 s       20
>     12  4.000 KiB    127.990 TiB   8.500 s       20
>     memory bw estimate: 0 B per second
>     total size: 556.910 MiB
>     record DAMON intervals: sample 5 ms, aggr 100 ms
> 
> [1] https://github.com/sjp38/masim
> [2] https://github.com/damonitor/damo
> 
> Changes from v1 original post
> - v1: https://lore.kernel.org/20260906184417.96621-1-sj@kernel.org
> - Rebase to latest mm-new.
> Changes from RFC
> - RFC: https://lore.kernel.org/20260905202634.88102-1-sj@kernel.org
> - Drop RFC tag.
> - Rebase to latest mm-new.
> 
> SJ Park (5):
>   mm/damon/vaddr: support prep_probes
>   mm/damon/paddr: move probe filter handling to ops-common
>   mm/damon/vaddr: support apply_probe
>   mm/damon/vaddr: extend apply_probes() for hugetlb
>   mm/damon/vaddr: support pgidle_unset probe filter type
> 
>  mm/damon/ops-common.c |  32 ++++++
>  mm/damon/ops-common.h |   2 +
>  mm/damon/paddr.c      |  23 +----
>  mm/damon/vaddr.c      | 232 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 267 insertions(+), 22 deletions(-)
> 
> 
> base-commit: da659d141e9797b3a2e5d0e2b457bfa4e8a8cb2d

Nice to see the progress with probes.

Since you are adding prep_probes for vaddr, do we need to check for
the existence of prep_probes in kdamond_fn?

How about this?

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 645cb367019a..7b308cbf21ab 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3935,7 +3935,7 @@ static int kdamond_fn(void *data)
                if (kdamond_wait_activation(ctx))
                        break;
 
-               do_prep = ctx->ops.prep_probes && damon_has_prep(ctx);
+               do_prep = damon_has_prep(ctx);
 
                if (!access_check_disabled && ctx->ops.prepare_access_checks)
                        ctx->ops.prepare_access_checks(ctx);

And maybe change the name of the variable to has_prep.

-- 
Asier Gutierrez
Huawei

