Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A13637B409
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710521; cv=none; b=at1Htvfku1TWjxgW5sr5BrdyGgoQEiMrahmrlv0UU+Rz8U2jIaJPvqyc7GDGbSMDXWX/VMh8NqdGyXz8WAE5Fcy3TZw0icOEfGtK7DRnLQDVq+uMarzqEBxqGRP74ccei/4JELQWg1bG5EBZpEdB1LTY8p4TYEG973iY5mK5UkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710521; c=relaxed/simple;
	bh=HnhvpODSykZGd0gC/qYJbWWYfTQ/iP5eixsH8/fLwto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjiEZOmcinjItykH7YN3ZnngF4bf8IC0dUkK8fXQwPlv7ojTn82v3chUZfZaeL3lf49DahVke1xl/kE50J1iK0dg5DFW5Q5O+L2LolNQOk9IigULZnDNO6Ar0kgsURfwJx5a0/nRvXduoOpI8xZ/bcLJekXijJYSbn5CXS6EFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U7Y+WUUw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U7Y+WUUw"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c45c580so8697351cf.0
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710517; x=1784315317; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iFtVuusRSG4YUFzvnh+nyLwKm1T7E76ZywXpwPdPfD8=;
        b=U7Y+WUUwcUXj0Ho7v8eb35AK58hWiJ3+WbygjnMIk666WQuKqtV8piYsecYIuPgqis
         LYBXORmjiQzFuqw4akrBICh1LNlB7xtOClSJiYk6jKNOjLbBjS9/1cuAhKmP+1xgzoxs
         jLRW3Ay2PezWyC9kZRaiXepYU8SaFbDNElkekaX2AfHeWQgq0YBkAzxVr4gN1T0IVBKL
         IiMVceKqOOORuNaV7MhQy5oHmmOmKL8VMEAJ+btY3tDh7wrY/tbBHhvHeZlCwTnku7T2
         qKsffvOenkQ8zH4DR5ZpBDC4CIprVe2hHzJu7WUdPbP10Vx5tu/aJoc7hrfuKHPS3c/X
         pksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710517; x=1784315317;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iFtVuusRSG4YUFzvnh+nyLwKm1T7E76ZywXpwPdPfD8=;
        b=OH0smxHQecitB2sAQUYFhpquoYGLY0pEoNmPBGLjEUJO+etnJJFcSqqLgpCPHBvoI4
         1sAnqJpFSKlLsU58R3/CKbCUfLkvAIxst2wXPyz1wHB66OSzF7GwVfz0WUXiOIFhmC3o
         /xzaSYQhN1Cn9BR31rZlDep4bNYhDzu2GFKKvRIy9vfM59SiRLMK71ccEw45DxVOStl4
         69I5t8qt5cFhuRPBgw3fjz8X9RxAamciSygydd8EgArA0R8H1V3dH+nud0AcdHrKvAio
         zOko/ZpdnOqVgMC6mnFsH52Dt4g6AOei/HpitBeCtQ8y6+5BKIYvgg5knurVZKGeldb5
         QQMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrhg09tA6YWV+VsQ3x/604+YFevB9NpCW6NK6xP13VdTAiPIUJuE5RUPdFelHuW/Wk1k+s4Sg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm9bwVnP1N8puqrFwoE5HzLUg88DXlcm8xli5MNFMJVYUUCqTH
	ulBPP4tMPu1KNQRBa6m8s+et+ZmpavPIs6MNsJHYsoCWLtHoEZUM/Qrqge1fs19atNA=
X-Gm-Gg: AfdE7cnhUQMpmC43LrHsOAJbIoSfXWoEVHw7XFm1ltULw7O0aiaIzVztvvAizMARlxn
	TxrjtKoKqUvMwL/8NFvL404QmCASXsn5bZOlVCLkQ6Hd6cCEQ5ElS1EDyVnjS7WXjZVSC1mQk7L
	wklFGVir3njhh1jWd8cZEK/BWAPrxKvN8fvfvoW4Sw9aq0Pdbw+6gMEok7VwCcoKtvWjglWFVq4
	pjE7Q+S+5mzlTGDyGUAlGjOfV477Myf9RvWX6YBh+pLL5N6kUNp35mQUAqz3jwHKRxBBgi80GyK
	lron76BVg+zUWuQBVZBOvqXzCfHCBRCCm2bHNcVh6ckbMBh+rZSXwliGpSuWlymxNt1RmKYU6AA
	bMtb85gzDhTnnkJ6f1Qv6o3Oq4I85HCgzb6CgJyeigl4gkU574k15mykdwIOTechSFaLp83+lsG
	op+WGSsjHiaREcNOUUkmGHUPPMxPyTlqKKU5HzOfBy4NrRZGoRNVwronOVLCmphgLOgvZT
X-Received: by 2002:a05:622a:1818:b0:51c:b900:513d with SMTP id d75a77b69052e-51cbf280a8amr2226311cf.53.1783710517321;
        Fri, 10 Jul 2026 12:08:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1da1bsm47847566d6.30.2026.07.10.12.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:08:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:08:31 -0400
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
Subject: Re: [PATCH 22/30] mm/vma: move __install_special_mapping() to vma.c
Message-ID: <alFDLz9_oSSvHTuJ@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b3254231831037ca3e9757e3e05c90072e04a6aa.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3254231831037ca3e9757e3e05c90072e04a6aa.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:33PM +0100, Lorenzo Stoakes wrote:
> This function is operating on VMAs and rightly belongs in vma.c, where it
> can be subject to VMA userland testing and allows us to isolate it from the
> rest of mm.
> 
> The _install_special_mapping() function will remain in mmap.c as a wrapper,
> since this is used by architecture-specific code.
> 
> Doing so allows us to isolate more functions in vma.c for the same reasons.
> 
> This forms part of work to allow for tracking MAP_PRIVATE file-backed
> mappings by their anonymous virtual page offset, as doing so allows us to
> isolate and keep code that interacts with this together.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>
