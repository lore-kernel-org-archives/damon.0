Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626139903E
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714807; cv=none; b=ILSt+PXx/c8OiJUfdF2FBGYBHA2JnuMfo5P/XxPVwZtF3fCfkQYgFwbQO7dLW2NBdAeAJHPghmSKBmLraRQwhrOXC4NzPGDOvEnnf/wyOWPI/9/ObpAlX4I93nmfKmImGGcdKwis8X24prKulv5h8J/kFp/1aS1PADvO6gDbnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714807; c=relaxed/simple;
	bh=hY0ihDWAncS8x5azfJXUc95BFne8Ovg7UFiz7I6gZN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPeEbTlCkBNvaymGVvKrNja44hG5cshG6pUtW6fo6zfNMxf36EYile2+xUj2s2KMcxnU+3QjHppHrud9zlvkRj7SmxgOf2PzwI9m9G0SQo0djgEmHIOlfwgrMHooZPIyoL5vDI93pt9JlWmapn73I2mOAnD+oQYog2tzsBTn8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YvFYRSz7; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YvFYRSz7"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c1d487f2cso13811051cf.1
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783714804; x=1784319604; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Atx/vDG1sDwzZEMAHR3NGh72ccSeLTTbFrhohwZH8Yk=;
        b=YvFYRSz7e1S1aqF6ZHMduHaR4P5lJCeuGDNGC1DdNYVE5Hnu31v4c8/NKusQLpq4B5
         vkp51KFkN2sHIcyEJ+6aO6GknHhn2hJzc94FE4nhIQiH523PO02ZSI5id9R3TvqjDAy8
         T+6VP8btAn1cILAR6BiGH15WEt4KGGFrOKJLzKrG9IgxeiRSlWsRE/JFb1A93DezOxaz
         ehftFg+x+IFdtUEjmp2/LZj20w1nrkNcrjWHEpLvonvn69kxDoO+Dh21ek7IltYnNOC8
         KtHQ/cMUFNIchq0VFORB4DKRdAbsuShld50X2vYeEgdtdDxqUdQyBPEq5ziVcJP2GKAS
         WL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714804; x=1784319604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Atx/vDG1sDwzZEMAHR3NGh72ccSeLTTbFrhohwZH8Yk=;
        b=kvE4wcurhVOPexk+iRtEPT/H71mvlTxdk9lghkmlFf1Ezz3CnpHhjrwrK0vlPYjkHA
         pfGgoxKdNhrBFtcBMq9QsnCaQsy1bxvpYmiHqIXtQ4n2uIS6IS71b4Gf25VnC/sB65w3
         rLBdkjh0suQb49qVHmsNM74kDPA7dqvIcVdTnZp1+GAVE2mgmUEC2kMLX4d7LqLOelAE
         J4KE/HUyr8JERXmBzLMUvOeD+O4n+yqTgJpERc5E9f711NJcep9Q87qnTXsRGEbZeAAs
         le3dhdv3CN1t/XRTOjFWFp8XLR2palZ8lr/lk1YLad8WmVJWbn1yqrjri9iVV95/NNc8
         eUQw==
X-Forwarded-Encrypted: i=1; AHgh+RrW5yMm29pTcrHXIgbzjpGtDFd8dIrzCnUfN58K/NAoa1h0/wGbEXdo+f9CuTARCWwwFMDOGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVr+aGvFlb1POBTiZmcIFXXO1J0umJxjlH1hI48ZzZCjkllk8Z
	Rucb0RhQ1qtS92LDjYqXBv6rB7/rH3hP5A2b3soSbGObJpHEP5eOzOVwYwiEs133iD8=
X-Gm-Gg: AfdE7ckam59jKv/SHyWLR3RbA2v2Tle0HzwJ8l88HqtdPdtxgP13i905T+ysgQzkCOD
	kpiaWdYFaccaw+8DopqMfLTkkPJQD07/wV8Qi6j+Eios8f1DlQJsKPgz2nfKKiF9mf5E7nKVS9u
	yprHeSRdH2ffkvwGSIHCQ0ERASKULk5vIS8AI2ubvyqdpOCgG2Nr/sYjTN5i80qM2/CIIwkXhv1
	WSeZAje7VvsZxvlxBKAL20wG6u+muTXidRRy0uZv9s3gR/Od6pc1HnP9g7VC45QhK0hCU22VT+p
	Uc4uDSlEmH0Yk3HPTvGCVvnU5PjWtmRMXUIZP5VtXnOrFfC+Ewx2TWDlSycDSZHmttiHgAOcDo1
	MXx2qXBtYfhWb2U1oLVXt6c77uAjkSpZ2wElf64URc6jYkorRCF73rfXylSzI3+XikZBdMgub//
	uLaQMRzicWPWr8sfbBmK660rzcBorSwpWiuMV3kCVPA3OfC5V3NOMtxFzt+LgcU9ouOrNO
X-Received: by 2002:ac8:7c56:0:b0:51c:1291:911c with SMTP id d75a77b69052e-51cbf0e0649mr5096251cf.14.1783714804352;
        Fri, 10 Jul 2026 13:20:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd50e10f4sm49427896d6.1.2026.07.10.13.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 13:20:03 -0700 (PDT)
Date: Fri, 10 Jul 2026 16:19:58 -0400
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
Subject: Re: [PATCH 29/30] tools/testing/vma: default VMA flag bits to 64-bit
Message-ID: <alFT7lx8F04rN01D@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <27cd07f6dd862d92410cf9db03f7c11e5f66854d.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27cd07f6dd862d92410cf9db03f7c11e5f66854d.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:40PM +0100, Lorenzo Stoakes wrote:
> With all of the sanitisers turned on, setting the VMA flag bits depth to
> 128 by default results in overly long build times.
> 
> Reduce this to 64 - we can always manipulate these later for testing of
> larger bitmaps as needed.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Seems like this causes instrumented inlining to go crazy.

static inline void bitmap_or(...) {
	if (small_const_nbits(nbits))
		*dst = *src1 | *src2;
	else
		__bitmap_or(dst, src1, src2, nbits);
	        ^^^^ this branch is being hit ^^^^
}

tl;dr: __bitmap_or() gets emitted and then the sanitizers have to
instrument a ton of inlined functions instead of the compiler simply
injecting a couple 'or' instructions.

if you wanted to keep the coverage you could do something like

# These can be varied to test different sizes.
NUM_VMA_FLAG_BITS ?= 64
NUM_MM_FLAG_BITS  ?= 64
CFLAGS += -DNUM_VMA_FLAG_BITS=$(NUM_VMA_FLAG_BITS) -DNUM_MM_FLAG_BITS=$(NUM_MM_FLAG_BITS)

w/ 

make NUM_VMA_FLAG_BITS=128

would let you still test the branch but not by default.

anyway:

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
