Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5862D8767
	for <damon@lists.linux.dev>; Mon, 20 Jul 2026 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577920; cv=none; b=gKUvS8ODYeLiCcNCXoDB0ASCBc29jioLWYRTY2aqFSLmJHxhXdTHflu1KtaCFnh577SMvv0bEdWuus9oK+kf366+4vQtKVcB5HKUwJPPaShszRYFd9XYH32LnqYypYi53vHyDXBGmRLEiNUuB4HqYVI0tSBzcR9lZF4j5qOWs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577920; c=relaxed/simple;
	bh=1rjpSQ8mu+YON7kDziz+Eqqp4mTUxp3NIFQjmqIoKtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+AUEk7wdmBlQU321N1SqIABNbXdvHh5KfYmsll84Z0yfUR+IEoZf37KXd/n45SXXCdMJTUvf6tl/Kt3+XtrjuZHtcSXjXFhoQEzcM1CbjX7KQh5Ask1SVbfbGiaGZmaQO98M5jdBj6NaGbcLSI4kK9zlXxaisFu60oJ13cneys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20251104.gappssmtp.com header.i=@osandov-com.20251104.gappssmtp.com header.b=LjRpjt5U; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20251104.gappssmtp.com header.i=@osandov-com.20251104.gappssmtp.com header.b="LjRpjt5U"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38096590070so1722276a91.3
        for <damon@lists.linux.dev>; Mon, 20 Jul 2026 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20251104.gappssmtp.com; s=20251104; t=1784577918; x=1785182718; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KYywQuRzpuUyQQKl8IkB8b6aSBOL9lUxtR3YJXQirrU=;
        b=LjRpjt5UGCGfKpRcDg/SbzE7fTnZmYvDL/N8MqAyW3yHAuIX3vCZpxSBltfPe79xrd
         bMMkJXVJnxvhstaRvPoJ81fSXbSMoFdCYF5LYezGEuRr4dardrT31e9cPrvGD4pSEULW
         vPL3olF3xjEd2zKEafKIsplcPVK1yVz28PhcugMqrC3JfyFtwizgRJ2SxS8AZ4i4uY1J
         WirIGedwHOzG8lxAUZa/ZL+fItnGTUMIcWYWGUwDUWqk+nB9yACOs3RlepmaVGMtXFa0
         ps08dsIPbtEBG5PoafmUMQpFPq3+IhAfShOxEttgR0DP0irlgIxTldy0EISRYtnZO0EB
         8lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577918; x=1785182718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KYywQuRzpuUyQQKl8IkB8b6aSBOL9lUxtR3YJXQirrU=;
        b=BrB3k5vOhsY7fx0oYC4iPpewNL9KGnX8l7GhwV1uegG5svkXFU/YJByZuR7kkwJ+LN
         rtRFFXK+u1acxWazqIeGCi9E72eD0qW7tBEBedDrpxMPPa/9aD4j0/wbczXhOz8ZIguS
         9mBFPWon/8KvT3/OXbcS4hmdSpbQwRpe17v1VLM1TRtY1Z6JB3fmQpYt5Lb4+jqQOBKJ
         UCLtCpGj9O2XKKazfvuw47C1FfrIGjevcyOHxHKrTkV3clx+5ux1d9/Aoa3iAMSVyogD
         h2oPaGP/WE7WqJYZsa9OS69YLj7vvx36EnbzCDNFjOXfFNIOSEY3v+VYzxvqfNmXxlbF
         ArVw==
X-Forwarded-Encrypted: i=1; AHgh+RqQNU7VFTBL3X7lyWVr01dp4gbHx0v0WXgjTWsA+3unzGNQjU4uzzS/qTpcYwvYj3c514pjfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcoYfix4l8cHyDZ2JCDaJbxpE2ncGZuHuHctOLw9z+zhTYWShi
	tpcxNN28r2Pfkrvl6d0dgimXGV7SyTEI264ZksElF4qmNmFOCCZb+s2+QHepDRoxPqg=
X-Gm-Gg: AR+sD13FsHhXHii5VJO2LsACMTmOlx0Wf/xCJu9ZOYyb1+K/nIUba2BNtylsvB9FIiM
	PW2dCBePQh+kXiFC9B5ivCrZSgcj7aVczHXqCwt/EVVCS35FkQR/f7w7+gdpOhEJqLwx0ZLMqzV
	lCevtq+OBmF+SJG/QBYmw5h264gt6+oTSMe3IxKmvfeMo0lmFX/hXAgOiO46e9Dfsf4FxuAqrWh
	ATinuLYlUAmxSUyz/xAqeTYTK23ecxJ5YZsFAmiSmDawl9t+nRUe5Ci5cFH5Q6Krtq2a9oQDIru
	VnWqXqokUl5aQyzqnspewlbwRct7F5qpXqid3+zmaLKyJp08KuLQRnqBdd3IQLtQURj2gjN8Ns7
	DACZLcjLQPmMPpLyl6PM1/rzhcWMULPbAvToG/EKqhZIJiluNyXIn+XxFa6PLTXY4x0oARK1kzE
	Jpkxh8r/VxOIm6t+YA
X-Received: by 2002:a17:90b:58c5:b0:37f:eda5:516f with SMTP id 98e67ed59e1d1-38e9283cd0bmr318608a91.0.1784577917883;
        Mon, 20 Jul 2026 13:05:17 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:500::5ee8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29e13a8sm33372118c88.4.2026.07.20.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:05:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:05:11 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, Zhigang.Luo@amd.com, arun.george@samsung.com,
	balbirs@nvidia.com, brendan.jackman@linux.dev, yuzenghui@huawei.com,
	apopple@nvidia.com, alucerop@amd.com, matthew.brost@intel.com,
	akpm@linux-foundation.org, david@kernel.org, ljs@kernel.org,
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, corbet@lwn.net,
	skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, jannh@google.com, pfalcato@suse.de,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	pbonzini@redhat.com, osalvador@suse.de, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org,
	mkoutny@suse.com, sj@kernel.org, jgg@ziepe.ca, jhubbard@nvidia.com,
	peterx@redhat.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, lance.yang@linux.dev,
	usama.arif@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-debuggers@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
	cgroups@vger.kernel.org, damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 21/36] proc/kcore: include private-node RAM in the
 kcore RAM map
Message-ID: <al5_d2XCbaRBhqdJ@telecaster>
References: <20260720193431.3841992-1-gourry@gourry.net>
 <20260720193431.3841992-22-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720193431.3841992-22-gourry@gourry.net>

On Mon, Jul 20, 2026 at 03:34:15PM -0400, Gregory Price wrote:
> The kcore_ram_list bounds its scan at the highest pfn in N_MEMORY.
> 
> As a result, private nodes placed above the last N_MEMORY node, which is
> the common case for device/CXL memory - is truncated out of /proc/kcore.
> 
> Include N_MEMORY_PRIVATE nodes in the scan boundary.  /proc/kcore is
> root-only (CAP_SYS_RAWIO), so this exposes nothing new - it just lets
> a debugger read private-node memory like any other RAM.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  fs/proc/kcore.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index 390547b992acd..f67194dc2a9b8 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -251,11 +251,14 @@ static int kcore_ram_list(struct list_head *list)
>  {
>  	int nid, ret;
>  	unsigned long end_pfn;
> +	nodemask_t mem;
>  
>  	/* Not initialized....update now */
>  	/* find out "max pfn" */
>  	end_pfn = 0;
> -	for_each_node_state(nid, N_MEMORY) {
> +	/* Include private node memory in the scan */
> +	nodes_or(mem, node_states[N_MEMORY], node_states[N_MEMORY_PRIVATE]);
> +	for_each_node_mask(nid, mem) {
>  		unsigned long node_end;
>  		node_end = node_end_pfn(nid);
>  		if (end_pfn < node_end)
> -- 
> 2.53.0-Meta
> 

I'm sure this is the least of your concern with this series, but FWIW:

Acked-by: Omar Sandoval <osandov@osandov.com>

If everything goes well, kcore.c is quiet enough that this can probably
just be merged through whatever tree takes the rest of this work.
