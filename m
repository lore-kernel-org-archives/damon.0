Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804F4657D0
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834415; cv=none; b=jxk4NyhhU5KOMLCP/xpnxhY+SOQkVXGthXwzt0gMbsLiJTuGiY9MdHte+aAQ7hQ150NMn0Kyb1AYTxYelv6e2+VPETVNXFIZHpDAnpFwwHPQb8/I2PN3C7QsBvMoN5AQLM6TCE1IAcR1KRT3si9I0xjcqFA9dTP0AyEheZfZwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834415; c=relaxed/simple;
	bh=dDmXL5XwXaYV+8+puY+mAXsJDpis0aF3tebQ04m+2HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/Q9iOzO8tccuHYYy+KSPPXRRYoyHFDMwFjOXVAXe1Ujxo6Q31/m9Phyzp8U37lcsbbTGDrvjj1FrHor9JmKpcJTtxZrZC7kCcBqt6MHo2YQtpa0ikJJnSQROzl0moB8jckHDcXpe/BubBaMRNzcPqQHPtg7gAmFmTaM8N0WU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sC2YQpPc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sC2YQpPc"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e65e18969so87970785a.1
        for <damon@lists.linux.dev>; Tue, 30 Jun 2026 08:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782834412; x=1783439212; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3V1BQpPjw58FUuLj010lwChkcBGTpKii5KT4CVPULY=;
        b=sC2YQpPcwy5ia7j1FG5jQDsE5CsL2Lgol2k3URKDbBERnY8r1p8uO8pCAXl0TOvfib
         8wv3CsBpKm1xSlWcv0T1vnLOGYoaML79hDO/qPifMAIUHbZZ/4h640vXHLVc93n9Ehb3
         Z/+0W/wKsiRAbEbqWfnxSTwVjaFAXeZyjID2ASCx7+kf2/fH5sph85bj7Lk0AwzKVBUC
         h4nwI5XBRfQ0LkuhchIg2aUJC4/k1nt9P6prFt8Kh6S2y+p4bUY3byyVWiw5PF0swxvX
         jeM2zeADMqUC2hGxtStBT19HHMrckri/q795Z7nj5C6i5iOdjGMn1nzwBBCoNaUVWRSe
         bZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834412; x=1783439212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3V1BQpPjw58FUuLj010lwChkcBGTpKii5KT4CVPULY=;
        b=DAocE/lpTt0PlGqU5wmaKPgXDWX8D81BfaEcKKHOXKgEJpdLlnWUEhgvZF2mcla8TB
         NQC8/4/N5djay24nqMsL+8nCqgUHZh9t8KDkN9NaEG2ZX6ZQUoPak2T+zuRtRtlr9q8B
         WYafFZMx2NQq02QQO5sxKzxRS2xMUpGe5ENpmz20aJwWPDUavMq7A8kyNRIKhSPfhpjO
         0zERaHNAP3RCVQDlL9f8SNQXGlCFrAQwteL1GYG3ZJdgr5VTXw5W5Fv71atOE2kpIM8S
         i7nBhxAzpMiRFyKNh3pVyuKBKlze0YYGwaiow1Ga3wUaIwAYdmApFba+Yx/I/sCqk/4J
         xi2A==
X-Forwarded-Encrypted: i=1; AFNElJ9fhYeLtg4V8aviEJjRVKALUp3BbICB0hv5fzjA5mwyfdTrhXrQAV0XJPw12V6Js3X9LelZXg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+DqBk1prxxLsRhjqrXD36r1bgcV0S7oW0ZCh0FhGp/G9uAKGZ
	9ayijqE1S8OEwkqNCe1FKi2N3z85xVb5ZSaiGu9ipQr6lBurE1jy8CYalj/QFe4nkz8=
X-Gm-Gg: AfdE7cljb/95fIsZeHlhE0aVwj+rqJYcdOeuzfKkuiwFy26UNPR3vG3yiDkwElu7jTs
	uwID/W4ZhWONvGO8AIbggnYK0qq1CbYsUSIq/MPWkCISLVV0w+hTyYl+zDkS+1Bq4+NR9RYqVMo
	CRMXLM8m1R0XqqlOvhJUvf6tjwB7FK2Q+3xfV9TH70aFljXk988hSQTTwxd6aUnQ82ld9uRpwIC
	9n7UsHQvn0CTVExUK+Avogh0AWozj9LUWgrQEPkaX6coogxRaWbrPUaopZTAJ252piV4/fPnEo0
	qo7GQ4ltDO2xXph1R5b0WaJceLiiDD88MrJg1uG5Fx2CSviizSPpMtop9dXtqWdrfDXs06fkukf
	3ITHuxRjRh57+ieZv1dzum4/YwbSKZswtO6MuMbMIGXjp5vxK+GO/qmfvCCg+8QnViUp0/QvPwm
	sgo6ao31SM7zR/n/rN8QmK3Otr1ye/hqExHT0rwcFmnbPW7SskpL/vz8ExRIjxS2lb/vDo
X-Received: by 2002:a05:620a:2913:b0:915:a47c:f721 with SMTP id af79cd13be357-92e6974d636mr316697685a.21.1782834412151;
        Tue, 30 Jun 2026 08:46:52 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6233a5acsm267797785a.35.2026.06.30.08.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:46:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:46:46 -0400
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
Subject: Re: [PATCH 09/30] mm/rmap: parameterise anon_vma_interval_tree_*()
 by anon_vma
Message-ID: <akPk5o_gHD1SxX_0@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <1c1df7b905ef340cbf2effef769a4e770a8e0eb1.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1df7b905ef340cbf2effef769a4e770a8e0eb1.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:20PM +0100, Lorenzo Stoakes wrote:
> Similar to what we did with mapping_interval_tree*(), let's declare
> anon_vma_interval_tree*() in terms of anon_vma rather than rb_root_cached.
> 
> In each case the rb tree referenced is &anon_vma->rb_root, so just pass
> anon_vma and the functions can figure this out themselves.
> 
> Additionally, rename 'node' to 'avc', 'index' to 'pgoff_start', and 'last'
> to 'pgoff_last' to make clear what is being passed.
>

would it be possible to split the pure rename changes out from the
changed function declarations?  It's hard to pick out this as something
that needs to be looked at as more than just a %s/x/y/

> +void anon_vma_interval_tree_insert(struct anon_vma_chain *avc,
> +				   struct anon_vma *anon_vma)
...
> -	__anon_vma_interval_tree_insert(node, root);
> +	__anon_vma_interval_tree_insert(avc, &anon_vma->rb_root);

an annoying request, sorry

~Gregory
