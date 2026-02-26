Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA923A7849
	for <damon@lists.linux.dev>; Thu, 26 Feb 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772146160; cv=none; b=l2wU1aSPFGzlvT1gyA+oHjZvG2cfk9BQBu4HtWiqUXWwOHb+EqyfUw22AraqhnYgafRbvOjb2Sr7mfJtXw53B1Ee8aN0YAXzYDgSvmaFROvMb6UK43imJyuR82RHyxphSE69ElBmOnA/8PmmVIeoTEVVLuRYsiaWx35HlmsV3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772146160; c=relaxed/simple;
	bh=9XJprUJHH+fYbJ7JRjThngQYjlckG3iYgJf41aqrPaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLAYffIjxfmDQ6Oj2kcWwrSrHfboWWcmkhTEjKwWGw06qxkTftrb0jUlsvYbhOaMyO+PvVifYzKVDKjTmXlfH2qOfTYH+7+afYCjFp+aAbezcVANnBRzKyIlLtz5/geJBG1rP7F2ePo2Lcy/G6+ESPypNzaxyrtu8KhpE89mIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TiS0+2aE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TiS0+2aE"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506bad34f51so11029191cf.2
        for <damon@lists.linux.dev>; Thu, 26 Feb 2026 14:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772146158; x=1772750958; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYDaj+HYxxwd2SoII0inXN8E5ab2WhHpXFva2vqM1nA=;
        b=TiS0+2aEpiVShNseEpQBSKSL6lYefR0SxGedDeLOsDzQmKi4fuN1XLaQhKjzMoAFY8
         qqQx5GRWeHosiluNvP+wujFEGna8D2pRgV9ufoea+1pkKr6Vehit92/QNjXC+Pt9uWio
         Aurcz+5WdKcujOrIpq0E/KnlXJM8a1+/JiF+dAW5VePB8rHtjcz8l8IOtIk+b8Fysck3
         EB120PUE7H0eusD3FLe7N0P7GXeEHho6Du5CVBlKLAzCLjDTCbgjJ2IdX6fxEpGLijSC
         9PPRYhIN45Ky28zAPGyBQczK3XiYLk+ghVJlL9USI6IGGynuGXDpOmTW6KQwvIaCttA9
         D/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772146158; x=1772750958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYDaj+HYxxwd2SoII0inXN8E5ab2WhHpXFva2vqM1nA=;
        b=Lf+iCRbA4vA8OaBzRfv8Z2HEL8IYkUFZuupyTQgO/MI4PaaJSPOrORQY7tHEfRX+xB
         Y4GhXaNrL12YsnkFSKMf1PwCxjyca64HFaSjTJKVpd2/vMNZ79U8MN9Su/e3E/6lSsEO
         gPLIJPfl6vuzAeTVRQCy6dBENoTUfRVJCKhPMnnC4416yaDpXCEXJwWcXNZDMHty5+mz
         MfWcL3TVvO2baa0H9+fT+wXkFFuIn6UYrhFcOzTDoANlO1wZdRQEa4whoLaL2+jD3dUB
         TFMJxsHk6enMlU91Z1M4SFv/1mgAaHh6BKgfLOZLNiL+4p5fejNwTnDRALJoTdOjesTT
         kwuA==
X-Forwarded-Encrypted: i=1; AJvYcCX3j/3hFkhTsTZSsNsJ4jeQa6bQRsLposMlSQ/g88pE7yuRjdtdFXKxC/aO10rMTrendGPjfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO4e82KLLVd8oNGdqD79BcF1sfnyXCn58fEs4J6TFXVOXRLaD1
	rQaWVAtjBdyKoGoFdHKXkeQDGQW0HNSe7bS5OVBbqAdqFPGvc49lfdJxUBgNvWOcEyQ=
X-Gm-Gg: ATEYQzziV7cRZEIgNXitbAEi0oifd903nlPDRRmU3SyFO6nnmnYKMNnjR1ewl9VT5dE
	7GY6k138hiGPTxtEy24lf9sdsB3+i0NjwJQk4WmE+QRC/6l/1XZHH6E0LKsT0QyigRKF5rhZ3SZ
	if3f20PovtMkhyqh7mz0jniTjhm4qEIqsDvpFR6j+FGdUZpxNI/5og/YS8Tea1fmjVNj3Lp+6mW
	cyz2WlsPTvdSsrqK3P0usc42yix+XQK6TBOW0ibkrZ5zu0AJfi/s2Z75Y9F40yeGyaVS4cSY6Z7
	JNHt9N1IpXq2reXteZrAIZthXsX3k9b4PSLumJEnlvyy0RL1YSvaE75+rd1+DFyLds1nYKJnRdG
	YikBmiZAiJOYB/kAtLsNMRpcX+XnK25wJYGU9fbw5lC4hGZup0hJ9rowUeIyVi5K7+AWXYGoxlt
	lc4mLYn8scf6EQyBU0JkqW4qPULx6xjtDU9W7p3XcCSXjPmSc8Q24HMSQbeeWcLQm1Da8FcNYM9
	3AbTrJeCg==
X-Received: by 2002:a05:622a:1984:b0:502:a100:4054 with SMTP id d75a77b69052e-507528c1f89mr8534231cf.23.1772146157581;
        Thu, 26 Feb 2026 14:49:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7159b72sm29449326d6.7.2026.02.26.14.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 14:49:17 -0800 (PST)
Date: Thu, 26 Feb 2026 17:49:14 -0500
From: Gregory Price <gourry@gourry.net>
To: Alistair Popple <apopple@nvidia.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aaDN6ocubzGUz6zc@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <fzy6f6dpv3oq3ksr2mkst7pz3daeb3buhuvdvcw4633pcl7h6u@mxjgiwpg5acv>
 <aZ3BEn_73Rk8Fn7L@gourry-fedora-PF4VCD3F>
 <a6izpi2wlqro72erhbvxhlx2lwdnae7my3ghfs6t33ivtixo4h@bi2u4x6qv7ul>
 <aZ_gALm7aE3d4IcP@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ_gALm7aE3d4IcP@gourry-fedora-PF4VCD3F>

On Thu, Feb 26, 2026 at 12:54:08AM -0500, Gregory Price wrote:
> On Thu, Feb 26, 2026 at 02:27:24PM +1100, Alistair Popple wrote:
> 
> > > If NUMA is the interface we want, then NODE_DATA is the right direction
> > > regardless of struct page's future or what zone it lives in.
> > > 
> > > There's no reason to keep per-page pgmap w/ device-to-node mappings.
> > 
> > In reality I suspect that's already the case today. I'm not sure we need
> > per-page pgmap.
> >
> 
> Probably, and maybe there's a good argument for stealing 80-90% of the
> common surface here, shunting ZONE_DEVICE to use this instead of pgmap
> before we go all the way to private nodes.
> 

Out of curiosity i went digging through existing users, and it seems
like the average driver has 1-8 discrete pgmaps, with Nouveau being an
outliar that does ad-hoc registering in 256MB chunks, with the relevant
annoyance being the percpu_ref it uses to track lifetime of the pgmap,
and the fact that they can be non-contiguous.

tl;dr here:  a 1-to-1 mapping of node-to-pgmap isn't realistic for most
existing ZONE_DEVICE users, meaning a 1-op lookup (page->pgmap) turns
into a multi-op pointer chase on and range comparison.

Not sure that turns out well for anyone (only on ZONE_DEVICE / managed
node users, all traditional nodes still have a simple pgdat or page->flag
lookup to check membership).

There's an argument for trying to do this just for the sake of getting
pgmap out of struct page/folio, but this only deals with the problem on
NUMA systems.

For non-numa systems the pgmap still probably ends up in folio_ext
(assuming we get there), but even that might not be sufficient get LRU
back.  Might need Willy's opinion here.

~Gregory


