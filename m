Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D693142983F
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612201; cv=none; b=DY2NUycVipVqOZQ1sZ1oyOYMJuy8UDTcybF1ctg8A4j6qvzC8hLZ3Q59WQ3GooVx5ShrwbKLr+18ngMRf2BmJbWKKNgL2iuNqnvA1d8bEyVwZXrOH46gT+jkUBuRoPiqcEoM4f9DYZPPrWdH0sc3eRotsKwQxrr+Yt3X3lXaG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612201; c=relaxed/simple;
	bh=tF3dU5J3cOP7ny9iegybsK7rP7FD7pAbvMcJDVORdjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFgOTkf9x9NYt3DulMbGw9q16EWNHnpFi+33O6l82w4KLalL2kpk31olISsgPnnaZXSj6Jl3qrDdKgwPyVvdudRH2Hb6rny3LiFeg2B7dyhSUbDw7JMfF4388N9kq6KaF8ms9geKa6aagMlcG9EkqvoHM48iRidSheQm1luCMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gHwvGVWl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gHwvGVWl"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8efbafa1bacso213376d6.1
        for <damon@lists.linux.dev>; Thu, 09 Jul 2026 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783612198; x=1784216998; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jHzvbYEg0XlBnUnrRe2UmAXaT3jquo9NtkCgPzQ6hGk=;
        b=gHwvGVWl//XJgnb9QOs84D/+w1IcUYL5AqVKWxjqq2v2WTFhgXPUlRqT0YSOsvp+nh
         ErA3+1CiVO+A52YNMAwLOIyuDQptgan8kBBhMtuxQ656OWyGZL9PyEZsk4OM5B/H6J1+
         4juc9lIrg/Ix0Tj2pV44tfRXuwaCuDVZnII71ZXZIUTpQ8pRQKIN5nAGn9tYk30IdfgG
         YZXowSTP8oMsZU43Gr+76m1Kkbs6tACu53TxxDIRdN0mf6NpAbn3+XMAM1L9MwWD6xRe
         DwoWPG/gGZE7ZbonrHy3NdksrkiGcfxSUnfayIW4YUCIH88DK22s+O+pgMTr9kHBKGAz
         8ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612198; x=1784216998;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jHzvbYEg0XlBnUnrRe2UmAXaT3jquo9NtkCgPzQ6hGk=;
        b=P2NFrLcV2wNttKfzziWco1sn+Qm0jsAa8afNdc9CQHIMDrgl/qCMcZLR4myIS5obyt
         zhpC7XNE0jnJywQpwG90OsLgvd0NPV5CFTfz5LVwzyTNtovcjqkfxn6u3wCaQCqcYMHz
         Rl+5p4YqyDPfc4ReD7MWdpBKo6HzDh2f2V8WmbIwsqaIs2Ng+LcqfJNyPfKlD/fjetlq
         RG5OoXnZEiK/4/vWC1XU15Xz2B0utSZll++/Rb3EGBS1YL35QUV+bhUXxx83+UBWh3av
         Sl5S+M21VxDVS6vpKKuREP2WwQ18bUJPauCbG3UArkRKrxvQ684fKLrC9D4n47W9Ho1+
         fC4A==
X-Forwarded-Encrypted: i=1; AHgh+RpIqNaSDeaj/2stMcUv6SmnssH7BGf7pG1r4UnbcvrWaLm4Way2BJide79/eP0vTU2Ap3RShg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeORs0GCOgGWZDDOc0lexIZOM3md/QC0cvgJfrF7MqwAgChsWT
	MS/4hRhfGFPnZwsiZt9GjbvpVzfwxnx9+LdPMLW/X83iv9mEigdAY6GFcZj8DDULFUQ=
X-Gm-Gg: AfdE7cn0TO2uDyHFuyGtY0D4rjfpHTshqHTzdg1Nlm8W49puRGgDsJMvYwzE6R6hSdj
	LBeGxPCp0GbFy4ix/5sD1t/qG1o1uGgwHjK4JUIcgUCQde4LDVbELvWksvLvEAPCm9Laez3iRFU
	+5RBlaJr8uh7LPBxsWicOMS0KI7mHlaygqMe3gHlo8ZtZMX96YHMNCac2aNtKxHm5RKLTXdIXag
	Zboo0hPRqRpCR8sIEu0zoIZkgKu/9/BnO7aEVJ0VOQZOkotNwx2/1ITtAh4f+TBzJ9N/9UCL+1L
	MTHHhEGu7md2i7+IXBO6C/ajTVwTfvpEZK0yBlezy07XvLM7PLyYdNNsRGCU0GcJMeTOE3msZac
	XurSiZ3guRv5WYWfvU9ULfCYqKtePEc1+kwza/qoQRD12Zzw1uRq1lnIecFYNOFo121blf8R9E3
	u6rRk+Sq4Hn3x+y+uyBS9xFGZUBiWHIubuVaLoWbtOcKM4QrSozcBhKTxI/MiwledpvTYx
X-Received: by 2002:a05:620a:8017:b0:92e:c116:bf0d with SMTP id af79cd13be357-92ecf95dd8dmr807949685a.86.1783612198042;
        Thu, 09 Jul 2026 08:49:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbe3e2sm1689967885a.35.2026.07.09.08.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:49:56 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:49:51 -0400
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
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <ak_DHzxSA73zWkGN@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:28PM +0100, Lorenzo Stoakes wrote:
> Be consistent in using vma_start_pgoff() and vma_end_pgoff(), which clearly
> indicates which part of the VMA the page offset refers to and aids
> greppability.
> 
> This is part of a broader series laying the ground to provide a virtual
> page offset for MAP_PRIVATE-file backed anon folios.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

