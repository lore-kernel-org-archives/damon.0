Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658BC3E6DC5
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747079; cv=none; b=oW8cxmfye5KrPE9kV51dqn84wtYz9FsHQhugrQf1gistyZpSu+b4Gm4JsLxg9FxYkjN7suNV8CtmMfUZkLQWLj1sPnZVHezcYLIm/6SzaVKqFA0VqBb/7hHcfMRQ6c+EROw0YjuHObFJKHRFVu1sIc6doa45PSPimHf+4rK3SRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747079; c=relaxed/simple;
	bh=eSLebA2K6K0JqwA20gSpIaLBxceDZU1DyvE+HEyhHoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWpnJPy3whFOtKkyaiYBQStLngnLWUD1VlyUwEbGWz4IzRgHmoTNBK+S5jJLSRQhy5nuIhRyq0tHMHUJamc1ZbrbW3R+Q2Nb1le6bkJjAor8krPUhDf/FCoppZbRgRuSNRw85vjdq6teA2tg0L8OVHry4cZ0zAeAFhxRm1u+yEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ixk/6iiM; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ixk/6iiM"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69de16f5f79so1731159eaf.0
        for <damon@lists.linux.dev>; Mon, 29 Jun 2026 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782747077; x=1783351877; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtnRVAeDbe2jCD/DHkmGFKsvQqrt7nLFRBhYCay7qN4=;
        b=ixk/6iiMBqEtYZ1TFLxzipN2MI1SDz5m+sdkHlRgPpGJSNl/NKtFPtNjRJUFWOy9vE
         3Emx16WDSvd+Eqe9/xGpPUfpGrmpPFMkPM863hEKBrsTHFmkHrYf+UZ2MVQqF7PGoLeB
         549LflqTcyZAu/qLFbmCYzCftSvnLSlqPILlpCfkTqz5Nb5tB1PbDCenBOHJ1lTdWoC4
         modxbuMzK2o1L7CwDVJM3F7dQ05XYMZaQe011BMwVYF7Yfap62N+uU/bZOX7SA3kjQCI
         hHnZ9B89RuKjdEzVvyPxlbXM3Z7NZaMdyYN0SBX82HaqcAzxRBkAUkIbm3/QrB9zkN33
         FlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747077; x=1783351877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtnRVAeDbe2jCD/DHkmGFKsvQqrt7nLFRBhYCay7qN4=;
        b=StFv/BB5QDPJsRZK8z0MfAdeFspjKNCzAsoPFjvAjqNvx6viW/Vy4wnA0KF5h5IgNV
         tkUa/ClXxHKCzEdJCGwcGa4CaRRJIFCNgRL1nAf4TPGCl3VOZaMn5LusMxOIlNdrwPCx
         24ZXHFAkxnKw78KqpoZQ5YqLKfEKbz+WPXG99Xc3BqdT8rjWEbMyoGOjBL+QlXspVq07
         5JIj4ZOowESBqM8swDiAmRa+z3836SOVU8XvT26uKKnca2Wphq1P7sHNMOAWaL0c0ICW
         8brBErTN0qmo9PwN/qx5JOhMEE3gLYkM44gM61wjyB9oH6JtRY543HP8Nmt4VbJDs/Zx
         FSxw==
X-Forwarded-Encrypted: i=1; AFNElJ+2yFl+WlQPk8BE5uMg+EfD6wEeWQ/7XYjoo7jk41MeY9Or7Dd7Q3h3zb83EOonYj1WcCvLPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUEknsl2gpfp5mlOVq1sY/hVMjHmjnCYO6bAcGUzq9ZYa1HQSE
	1roIxVDGo8d47byMqCGpz89zYT+dXixZ8Wtm3aCqh63EXzKI+N1JkJz7+j9OTJB6x0c=
X-Gm-Gg: AfdE7clrAYxBvLwgTO0y3tryF5YdJucnk59TPSKoGbz+L/TQMazggDqdw1zbBoiKA/+
	sMBjw+uwi3jCzkHZT+FrfcCcMbtUlCbD/E3vf9vXLEgx0/h5jYPnyxwrM+KOpBUk0bLodmy/WQP
	E0SSt1tHfT3fE2O0yoQBcXvmrnLEm6DLRA5i58tPOBX2GOoV5ciYrp82T2Qn4Nh6qA4Lhcq+y2N
	u0xU0QGgA3EhWJsDIU7hujcO9tji6RXH5YaBy70O0sQHndssJ1w/yqtLGZ/Ggi2MNocSFaF/nlB
	88strD+yS3ybv+CLeYeEsogwbqzDWZzdzeARmul6PAbQrlWXoDdt6GBS6dzm+RfUfC7PnIX6TIa
	d5TAOnMt396PswpQ5hGbVL02RdCimqeGBfZzwqTTjky+T7W9341F0dcjSQFC9CXPKTEzJ5EX7KQ
	Ug3Qc4zMVBuV/Ezzz4eaDIrmWSk7pUkN7lQFCJKxqqgIC6mBH+Q8K3Fwyxzzh7ioq8mhTS+pbYV
	ninPYE=
X-Received: by 2002:a4a:e914:0:b0:6a1:524b:1f5 with SMTP id 006d021491bc7-6a1891b6f09mr98038eaf.42.1782747077395;
        Mon, 29 Jun 2026 08:31:17 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6213b95esm9184285a.5.2026.06.29.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 08:31:16 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:31:11 -0400
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
Subject: Re: [PATCH 02/30] mm: add kdoc comments for vma_start/last_pgoff()
Message-ID: <akKPvwYs-4TwYwKO@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <8c618dfd7de419e3b797b8bd1cd921d4c5b8878b.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c618dfd7de419e3b797b8bd1cd921d4c5b8878b.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:13PM +0100, Lorenzo Stoakes wrote:
> Describe what vma_start_pgoff() and vma_last_pgoff() actually provide in
> detail.
> 
> This is in order that we can differentiate this between functions that will
> be added in a subsequent patch which provide a different page offset.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

