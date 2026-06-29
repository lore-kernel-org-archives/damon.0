Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6062436371
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746856; cv=none; b=gKOQfa5yVyOOiXggkCBtb3hpQYdAv1wb1YfNDbmVQoiWh+l7LKD+vx4dLvo0jVWVE04aWi3PKJ1MAPS4gP+g8dCWQaRM57dvk6rP2lKX3Vbk3838h00omKmO86HZI+p0Sc/ka1eCGn1blPIXYXjDRw5YggHrvWoJZYTs9Na3eVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746856; c=relaxed/simple;
	bh=S0czybLrYjf/ynP1kVMlwjsL14pOds5Rs5BBJNaJCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUHjofw94cvgCZ59IJzzqDUCupj1QxxaxpBLZoG67LMDImTZdDI8EaUdc+aAK6XcpE7nREzTRH/vBEuxfmgWlZTawkbt9KvkPZANfn3dXglw+SmD+BFpnhK1QA0LQLaCeb/gTCrOEy1m91AOTcTnDeK1kmIkJeKF/EneYsfLOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fufOXl26; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fufOXl26"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92c7a0a7059so197272985a.0
        for <damon@lists.linux.dev>; Mon, 29 Jun 2026 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782746853; x=1783351653; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YVSnUoP7z1l2IjNO7QqWpl688BIslf+DGUxd2Ln6LGs=;
        b=fufOXl26tddYEvKC9n+5h20T60XIDuGzZaxm3DvodwVPf+JqcdTp9Zbk57UJhs/BlV
         6cIRccfI65up7RvtovUaeJzlcSF9edYwm+msMfKIk+aPTBflTWtjH5jBHW9jW42e/rAH
         x0EokZrzpDaQQlxX6rmMLyrbBiPA1nrnbPM63zMtMfeIipv/EyOJaPRTLCzrbNrLaEEF
         62nXcPQER/7QoDGXmwkese/240SzhdL1lkja3ct2pY05OqUb1MnmdhM2hfQ5P/hEzAhu
         L7P0sTp3mRgWT3q9RSOJjPPeb5NQd38SpB8Z7zJpcT2Gexyl28GRwHqQCgHH1lUrn0Wr
         4b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782746853; x=1783351653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVSnUoP7z1l2IjNO7QqWpl688BIslf+DGUxd2Ln6LGs=;
        b=pcR6jnm+MEDorneNu8VqqBkFqhVxQhK9BpQQU/67rc2pvwWagY2pya2M+DHKIyEy1s
         VYcUn8PHYMLK15SPxYO4zzJCfZpmZUdPJM8S9dVqq/wTpCwfe8lGHybULRrhHWc91pxH
         qASTjBOsNYcPrTL7Pm79ejxqDmPxeUCMElrB6fimZ8jl6bXvgJEt0O+0n2FEuLtFSlFP
         IVfCUwI7a1OY/7MZsF4XGQH6Uh8kL6902wr7tYPbbp6m528mnKbRIc7pdBKtEx0rM+HY
         ktD9wVCN87nMXLDHjcpw0BCuXyuRSQMtBue2EbqBreVfrfYuaz0RnyxeVNQT/2j6msy2
         JRvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XVg04tvYYX6wjpcwz/bfXCjyJ+k8hCmMisOsyXU9N5JvVLyWYWgWoDeFs3iy1Mox0RQekuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3GcKWjzyyABgjtzSwsS0BYwYsiWLNGYkGpvR0esU9dkmvozMg
	OIIlomOXgjxniRW8vSWNB/yzuKJcyD/rmhOgxG2eZFTr28EYC5Psbi/Xf38yjiScH1A=
X-Gm-Gg: AfdE7cl1EPe7VTrvSdlPxGO7Tth8OYzKWE8U8fhvj0C0/a1qjPKuewPaiwFLMEbN+dl
	asHr6c+ZC1fNH8pFZn/o/o0s2pmbq2oEmModac65u9XgnRS0kp9O8E6xHY2zHmPRrLvlhc4nhbI
	KkeqAJD6naOjRcQe5d4/JRs0k8hUqTxkFyoo76YWCW094vEkd6yrZRGBxhfpYdRerhjWWz11oRJ
	53VEG8SF21nbsUf9OwA5swDb1Z8viMm5JHD8lerkqF8o3sJtU3KIAII6CS/FLXJEmJO0t3ww+mI
	Cz0leB/IHBGYqn9Pn9BUuEr8P9KMKHbqpbbBTYI2t2uV+v54+sdoOZqt42ZAgsslbR8x42B6Kzs
	L57teGzOpS07Tg1uHOAgp8bgDGi62fcAGiZ94iU6yiVbWDXEcoVWfEtTnOk5k6Sl+a2GHM0xh3N
	Uwy6MEqC5am5kZBFo8uCtIgj7RtaoMTMRTK0a8CaQlgcGw6lbJveqWiyuRlwdTXAO4wsKm6hXIf
	yINiPA=
X-Received: by 2002:a05:620a:7002:b0:921:9df8:d38f with SMTP id af79cd13be357-92e62785c63mr1415985a.43.1782746852526;
        Mon, 29 Jun 2026 08:27:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e621943b3sm7429785a.19.2026.06.29.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:27:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:27:26 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
	Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH 01/30] mm: move vma_start_pgoff() into mm.h and clean up
Message-ID: <akKO3vnNmWIJAZ7z@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b28b698df4c009e85c4728446ca5863d8e633164.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28b698df4c009e85c4728446ca5863d8e633164.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:12PM +0100, Lorenzo Stoakes wrote:
> vma_last_pgoff() already lives there, so it's a bit odd to keep
> vma_start_pgoff() in mm/interval_tree.c. Move them together.
> 
> These each return unsigned long, which pgoff_t is typedef'd to. Make this
> consistent and have these functions return pgoff_t instead.
> 
> Additionally, express vma_last_pgoff() in terms of vma_start_pgoff(), since
> we wrap the vma->vm_pgoff access, we may as well use it here.
> 
> Also while we're here, const-ify the VMA and cleanup a bit.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

