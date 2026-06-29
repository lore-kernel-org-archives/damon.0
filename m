Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE743E9C6
	for <damon@lists.linux.dev>; Mon, 29 Jun 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748870; cv=none; b=NWnXF5VZh+7AsxxiyZN4J60hXKf0Pwb3czj+xRuif4R5VQ2PB3feg7oF3J1XYtryri5rfE6iNk9a0Y2nXc8TtjcSEFoOlRfG6ot+fABnP1lcvwfuJ9uQOL5CCS+GEIRuMlR2fo3emt+C99a225kbhiN58Jp4Y6vy9qyjMjE4wuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748870; c=relaxed/simple;
	bh=z4dmX8dXcX6a8GqR+YBU+JEoYI0/LpvWh746yKHnt/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU+Qqty2jbO041WCOU9soXuii6bojkhUgx5rUArxz0GUQPOc7yHCAqM289ifeOTHEsimSTeoRjqSgrxO+Jvzi+czLx6tjvM9dpT895wgWC+tuseSdP9kjBN/w5kzJhhmJbY7MIfD90+Bks41BwlE4VHPV2VKSvW07/wJIRSy8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ie1cm6V9; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ie1cm6V9"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664c6304683so1600419d50.2
        for <damon@lists.linux.dev>; Mon, 29 Jun 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782748868; x=1783353668; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iCXvcvVpnsYDr5kbvWXbUhbyvnE3mHOMHboZJmxShw=;
        b=Ie1cm6V9kh//i8i/M5/thLew53lRrmLlqwW2MjLivpulJ6p5cFT8mBRkf+iMpjMUfb
         54So9HZqyEfzgHPKvAU01XyXhB61mJ/qOBWdci99/9s1qTq+ENG7yeUqJ0GYMnDWw0Yu
         b+gQm+SDU899nBGK118x6P0wiH4XzKRI2EHWN1L38A1wBLrDxJvhxb3QX6OgTgCXgsfL
         nTow8e91NcEcWnnRh+ifzTpV2ch8wFA+9S4ZV1hs+1gA4aKqnERLIfzQSHubSeDyStDa
         335vBkEBkXvkLccXYumhPcSkovU3Qx/kBi5b+mZTQxcOJB36r/oa1jiXpcsGFgF7c2JQ
         SDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748868; x=1783353668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iCXvcvVpnsYDr5kbvWXbUhbyvnE3mHOMHboZJmxShw=;
        b=ftZjdE/fEbVedV4GtwdhlSnCi/TtDNZd1OaVVOMo90trv/LgqytMwBJno9e6bj3U54
         KP96y9SuputDJLnmF1m7y6osKiMHYkgp5S7fOnSjLHRi+/hn/Etp6vyCKAk3ZCUmfF16
         ojjEsXRCNy2bEGB1+parzkclSBYJy3firoHhT8qnJPn8bNRY3H95Jv7QOEQTJPuU7Bka
         CshxSeMMRD9Wm7y5H+1eKnf+3LtIl00sY9WmbDeyyw2JsD4tQqz4Q7meMPYjruMucs1h
         kpjZTqNEBbMIzK2A62bXR4IjDZEHpyPxhVlE2C4MStATc1nPG0tXP7MePW4Ct9bz9er2
         B7Sg==
X-Forwarded-Encrypted: i=1; AHgh+RrLAU1rQPE9R/zWBAk3b1UG7oI20YftuEcA5hQtu2A4sQr9+julyxxfvUfHe7EjLJpWJ86Gcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDhGJfHHVQ2Q0lxxnZphi1zfrsyYqedGGJtlOk5TKhb3Dw0m/z
	rQ5g3tpjIuLS3wiNGyqPnicwNOtjZKKTbPwfFqk4mnK0lq6zPQH0z4q3wB3U+siDN/c=
X-Gm-Gg: AfdE7cng/cBXsDEnY0lbHNii6w5nXS+qTMKFXaOLHBONC21iD4gAwXc5fD03sZicXJZ
	qvXYQFcSecLnfIShkV/ek/gvJxjIEoFjzLtjauus8GhVveWJYczIgwQyvX3gW8YS0z3RWzCsJU2
	Gh1yRRQcIRZ6Zp7iAHNdBQ2JhMsvVqEped7O2CxHLAqzwMYAElmpdJkZ/9fjOSJNedabrDZzDZr
	2akABD7UR0qCI4siCnZ6pIHSxyMLww711I0LaVmJAlKQYAdYULyV+U1TCfIgurJrJppfn+M2zm0
	4crQJZbVsKuen+u5AwI4jUbN0elS/VSUsqInGOQhuBM/WkaWxahCfnOFuWfaB2dDG96dS5RpfLX
	cqQ2wJ/6gQhJXJWDimz/lq2NDYjI0e0Z/aKgv61H9/eL3eN/R+fK3BU5HCMrg4/wTjX269/uq2d
	sMlg4m228hdRwu7P0xdR9IeyHmo5kByR4TWveLgmXz9LAwnXorw6hQ0JE1gyNYhUHruC+xGf1vt
	kB7r2c=
X-Received: by 2002:a05:690e:d8c:b0:664:e66e:f965 with SMTP id 956f58d0204a3-664f974638cmr245066d50.7.1782748868214;
        Mon, 29 Jun 2026 09:01:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a717edc7sm1112836d6.36.2026.06.29.09.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:01:07 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:01:02 -0400
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
Subject: Re: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Message-ID: <akKWvnU2Ua-8ceSb@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:16PM +0100, Lorenzo Stoakes wrote:
> Update the file comment to clarify that both file-backed and anonymous
> interval trees are provided, referencing the relevant data types for
> clarity.
>

Isn't this self-evident by nature of the function definitions?
(one takes a vm_area_struct, the other takes an anon_vma_chain)

> -	VM_BUG_ON_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
> +	VM_WARN_ON_ONCE_VMA(vma_start_pgoff(node) != vma_start_pgoff(prev), node);
>  

For my own edification - I know not to add new BUG(), should I be
converting BUG->WARN/something when i find them in areas i happen to be
working in?

~Gregory
