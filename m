Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575537FF63
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709754; cv=none; b=f28/4HV+BWHR44PPmlhLpCslbAR08OE1oeOtECIredRAT1kZ4b8i5fi79JrKP97/o5/ptSzcCK5SJ2xB1Rf9zF1VPHjYZTF8ipVJeAItLOYmXFNCE+4ZjP1wvORDiXm0SyO85LWCTrdRUSKxv87jFL2/C0wJGIw/Qo+QUI3CdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709754; c=relaxed/simple;
	bh=q8904xmXb7eGsUOPUyRn/bldwzD5EC9W3Q3lWVe9IXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knAcEgwUKl4j88q1YkqeVC08wYEir6t1Uctl4v3SSChfCIdCt/FmG+nQsGCDbUGv4aqEnBF+nlPBS2RwTUHsEY2tQAeRU2lFy3OdWlOjp1koY1m/oe1r+eJmb7YSiaOmfZZ6FCKXjbpHVAhf2zH93/hBdKgc8vLeajILY/b9ms4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Keptb9vs; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Keptb9vs"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51bfb91795eso8305571cf.1
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 11:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783709751; x=1784314551; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=35hzoYcsWEd72Qin3ApbTs4xBItRwQ29eotWM9K9y9M=;
        b=Keptb9vsCXdhhFTQhJhT33ohVbOJox1NhScoAhCPQduwA0K6Wx2nsZ2RGeW1hWKZM5
         J0rcp70YOLIvLlA2bpoXPyIQAu8ZrDN9Nl1czzD3hCx8Qtop5DhEnXsSX7mxLWRIkQOw
         2jrrKZ3EOfuL2z72Ip+DiIlKtDQQ2Ys5aLPPoNtHTr/fqXVxq2ueC/AaZDI2NSM5ljBT
         CxN4bD4oGMMJmGYzQsHHvIe4TX+3EbHjulZ3Zq/xpJMS7BX0ga+K/KWvR6bV6ozpsIlD
         4naBCOvDPpJWF8D6wWemDgHeHTdX30zpvyacAso1Pf13MVcma21gAeiiHoQ5qG5dttTF
         doDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709751; x=1784314551;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35hzoYcsWEd72Qin3ApbTs4xBItRwQ29eotWM9K9y9M=;
        b=p0mO7jrpPAolp3akAEWrpRoLyyL7+KVmU1Hk0P75AlY32kpzecWiGWAJ8j+5tkbpfB
         26mA+PzCMQKfae9zWNrBJ9sGm1Mwz5cSRZqr+3GuAbESZFULui+VKe6cz7g75Eei5JRB
         OCtVur1Ro6Hj52jLQ2h5Fm2P2n+x4PBqXccpfFEhRRYcsto9bR8grD0xBH/d1+CDAAEw
         7+trJcPUzyUzOov1D5ufc8d6+LaOXkGSpOSWsdS/6SDnK9EW2SEwpABPdHD68xW+CdpH
         WCXs8kk12B7h0bFUoLtlsE/MohLkDacy+8snE5SCo8WhEicMc5Op1lCY27KrXav1U3k1
         uqvQ==
X-Forwarded-Encrypted: i=1; AHgh+RqekfEMOp+iiH5GcT9s5I5fv03EQNHydGfUd9p1/KsqI9uewPfumf5IP6wFE3GjCCjN5zLlxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzachgerRN4PLN78jO31+7dqChYjOhsqcb4nL/RaNYZZVnrSPIp
	xUBJITqLWoUWETtlBthaehRSGCMFPUDKie9RFPrrZqLGdsu7HZOomGEROmelP1DXOlA=
X-Gm-Gg: AfdE7cmkHH7jHEd99mZaBAmt7N5huyb5subpigYMLC2frEFohhav8iZI3B09ynhBMv3
	aBO9x9nkk9Z9j7NPAqxqRGqblmyvmmNd+LZRBZF5q+s+R/Q6FY2buZTFtdH2y1OsYtso6oW1iZc
	guS5argDJERMZgnlYPeC8HAJ+cBihegLc3g8aw1wGzPKiHEQ/h0NNHWdDAQKx+QcEI7RKIIAtO4
	jPXcZWgugdN4Bap8aGRA1RHYqYjS1CyXz/4X8nzMGXeLoOInXH4j8k0iXvNdDNuQAe7MaLeeIYa
	STzwVLnF/QNnQSnDC+4x0bZQP9X8ZDWnoM0bq58pPx/2v2VSh/GfD8RFMFKeVVRfxJu9fAy5B7v
	cjPbsgx/neEYqj9piOr0yctwKUR591eRz7kjx/41T+9lamJOI71yJOQkNOmlxSOjhFlNgAU1p7C
	9hHNttJVBsRCqPMEGUhFgqyORILDFCYg7hoeLvAEQlX/bUHxDOdcn2fhp+PnzI7lrMCl3W
X-Received: by 2002:ac8:6112:0:b0:51a:f94e:ce51 with SMTP id d75a77b69052e-51cbf1fb386mr1548881cf.50.1783709750657;
        Fri, 10 Jul 2026 11:55:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caace31a4sm22925021cf.12.2026.07.10.11.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:55:50 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:55:45 -0400
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
Subject: Re: [PATCH 06/30] mm/rmap: parameterise vma_interval_tree_*() by
 address_space
Message-ID: <alFAMZNiJvxNpzGF@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <43050b10b53cdfc3627440e6b14ae2a9730b2a5c.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43050b10b53cdfc3627440e6b14ae2a9730b2a5c.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:17PM +0100, Lorenzo Stoakes wrote:
> The file-backed mapping interval tree functions vma_interval_tree_*()
> accept a raw rb_root_cached pointer to determine the tree in which they are
> operating.
> 
> However, in each case, this is always associated with an address_space data
> type.
> 
> So simply pass a pointer to that instead to simplify the code, and more
> clearly differentiate between these operations and those concerning
> anonymous mappings.
> 
> While we're here, make the generated interval tree functions static as they
> do not need to be used externally (any previously existing external users
> have now been removed).
> 
> We also rename VMA parameters from 'node' to 'vma' as calling this a node
> is simply confusing, update the input index types to pgoff_t since they
> reference page offsets and rename the parameters to pgoff_start and
> pgoff_last.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

nice

Reviewed-by: Gregory Price <gourry@gourry.net>

