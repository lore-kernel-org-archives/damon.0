Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF836728B
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610331; cv=none; b=Ikmft4SgC3mH4U0Q243IbeRrusslNBOvqpHaoKKoboMxOJjevewSYbE4e9MGpTjADQJ4vzOr50RsBWLsSB2oHlyBqy0oerSI6kmJbFPzhTeeAnnLfUxROv1KE0Y1VGjmk7P1Z1Jt4BRFiT7HFnN52mex9p9V8HaHw6m3r9CQsZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610331; c=relaxed/simple;
	bh=EmhDmZEzfDqtz+/wM5OYtSnBNKhNR5z6WmgKAnKqYZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6IRr/hWaJZww+koLV4wsba0EcYhIoGXliS7LHHfdt2Xql6/VHGqPxC2ZkQ6Xq3xQRIxNjCi0ngb1fCcMB08phLiXfTrJ/2Qt8f59T19jRSyjXvMbTkrzdBPxuZxKdj2gS8mbg/yO9Tvpm+ogZeOxyelSslOo1XO4YJDp+711Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uSvqpOMo; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uSvqpOMo"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c01089e8aso12004331cf.2
        for <damon@lists.linux.dev>; Thu, 09 Jul 2026 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610327; x=1784215127; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D66HPeIJnm5ZDnK+VorUOpyiniaZPeUCt2fPIKMnyb4=;
        b=uSvqpOMofbgdRq/a0RhxSezI+9d0hrh4xRP1dXAY+GmKUHW0yjdQild8x4YHHJBm1k
         jVVzNtkz7/htkn6SXgtS/QkgGn/Qny3KsRrx9vdGdiR7MJiEM2E01bnSMwlQ4B6g2HNa
         0YQHPLKgfZ4laBnFG1aZur/Nu6GQL1umPB5E6UoDWXnOFeWx9hH2TU5F+Zp2HsBFikHX
         pePgu9Ggy8eGxN+LWBUAmIb9W7yMR6C9s6YbnTO7Nx+NZg1cg7S/kYolClSngAu3l56E
         +wXxjOdk/K/GJXDLz7VzBMfnZO+d5FmxbN2Biu6UV9SPpEyv5TgIeiZ96Nrbao/ySFM4
         P+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610327; x=1784215127;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D66HPeIJnm5ZDnK+VorUOpyiniaZPeUCt2fPIKMnyb4=;
        b=CsmOGKYL45XPii47B1aADqAWc2wXgrI0L6XrbwypOtSeaJ44PPc8rTgg64szdJyqq+
         MxxnTVHIQxI55hDagCTx0mS76bgwdbnOGjCddMc16cXoER8JJTkBgR6nDyft+n2UkT3w
         HTH/zq9TQjxxaHSbMRnJ4udrkm/EGmbDKCpoU7F2KXI7jNvJxIje/VaJbLoISfPbdhS4
         RV68jvKwwKdCJ86QD6dUGorYNDFSmxnGUbl3qRUjgaHyar7QgAfJ8rhfHITvHNzrTXtN
         tClf3pP99WWVRE8IZqIK11wIujou6pYUbV9iLrT5PhVVM4uYJJDZU7PgFS43/ZLT4Glj
         lT2g==
X-Forwarded-Encrypted: i=1; AHgh+RqT7oGKDfevEyC/SINDXinXAKX/wCqR9vYACpLa6/1FhG4YKPBj0FvRRJu+/NDS5vQhx8DxmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9b37iTE59vYafuAJT2Kf/idDhZ0CFbBFssQoIxZEVE8Znua+r
	esFxpaJa7a6jGK6tY2qlKdBqKfmw+SOpnZ9yjnA4O2xma+2TkWbfts+Qwj8cofkPUms=
X-Gm-Gg: AfdE7cmWF9PBFSMinuKxyrtd/+iEl96t1QCujFBizsVFtSrQBw8xorEt7VPnSrNnCHU
	7/O0jWGwN3+jdzuJkTt1jx9NbSM4Eymko9qvP0Ru1X0OuGm3qwRd2arh8jYbHcTqdKi9x54s0Kz
	Fiomm7Q6Des6pshMd6O8o4UcIDDFafYXIb5gwMx8OFw4ZxOtNSyllDzS3XPbJpiLLGvR2yD04Ws
	ZLHPo4Oatke6TxyR9QEr9iWHAsV4TRgVjZQjxkssW9lq/ksf+jSazYd/7COuDzN9+qc0YO/dIgf
	+dF14YDbXUva2VmigTN1s7H9+KUvw9jD4q+oYtcDJsTlGkabDiwF/Qu07D+/5vzD1f40et0avmI
	bGz4G6H79roUEyATnZe4lfs2ZiPZlE+n+dGreRF4Nz7lY7ewOJzLUrx/BdxzoSRsQbZYnqwk8ul
	ZM7XCkVWwF4h47Xes6YL2dsTVBUv/zS8p1a9SLhRbD2sn5xtYE40sIy0+akfnXc9Tgwo4WUr4LU
	GIMAp4=
X-Received: by 2002:ac8:5cd4:0:b0:51c:1c2c:a8c9 with SMTP id d75a77b69052e-51c8b3e2e32mr79753441cf.43.1783610327278;
        Thu, 09 Jul 2026 08:18:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41db4fb5sm158006781cf.25.2026.07.09.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:18:45 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:18:40 -0400
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
Subject: Re: [PATCH 13/30] mm/vma: refactor vmg_adjust_set_range() for clarity
Message-ID: <ak-70CHGujkI5jJI@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada7972f49ea7f1ff1df6d11e4651f270444f8fd.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:24PM +0100, Lorenzo Stoakes wrote:
> Add comments with ASCII diagrams to describe what we're doing, avoid
> dubious use of PHYS_PFN(), and use vma_start_pgoff().
> 
> The most complicated scenario represented here is vmg->__adjust_next_start
> - when this is set, vmg->[start, end] actually indicate the range to be
> retained, so take special care to describe this accurately.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

> +		/*
> +		 * vmg->start    vmg->end
> +		 * |             |
> +		 * v    merge    v
> +		 * <------------->
> +		 *         delta
> +		 *        <------>
> +		 * |------|----------------|
> +		 * | prev |    middle      |
> +		 * |------|----------------|
> +		 *        ^
> +		 *        |
> +		 *        middle->vm_start
> +		 */

Even with these diagrams, it's a bit difficult to understand what the
actual intent/result of this chunk is (but that may be a limitation of
me not spending enough time reading the surrounding code, not a comment
of your work here).

~Gregory

> +		/*
> +		 *                Originally:
> +		 *
> +		 *            vmg->start   vmg->end
> +		 *            |            |
> +		 *            v    merge   v
> +		 *            <------------>
> +		 *            .            .
> +		 * merge_existing_range() updates to:
> +		 *            .            .
> +		 * vmg->start vmg->end     .
> +		 * |          |            .
> +		 * v  retain  v            .
> +		 * <---------->            .
> +		 *             delta       .
> +		 *            <----->      .
> +		 * |----------------|------|
> +		 * |    middle      | next |
> +		 * |----------------|------|
> +		 *                  ^
> +		 *                  |
> +		 *                  next->vm_start
> +		 */
