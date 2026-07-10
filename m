Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360942EDD40
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696153; cv=none; b=gPuwxOsnH3EfP5yPeV2cA+GABOATndfGozc2ttT27Kyyw8K8br6QWahgJ5Zv3tf9oOYKw5cu4wL1XeRPCuARqtya8IpPQz+JYebN+70Y1bWov+DgouVCyQAYtVS15b54Wq1lahkNJAYuT24VHJ8SRnJLHorFRS09pa+zdfYhIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696153; c=relaxed/simple;
	bh=EYnEp1we9gIclXQGcrALFhmvzaRn2auF8TgNETsfUuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7CsV2DfF24ELCvK6JwGwwotN2M15y13lwlNQ5gPQVSCtO8rmVlYXuBcECFpWSisiBHcy3gtv9Hc0tW/a6ZL3/uPOPre+MQDE9dntT2MZGhXDzP8dOXg66kyq7A04dynyL9fx81dcFERPlVbjtw6i3zk9DScv5vdoqm3qV1W6QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=thZS8Iq0; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="thZS8Iq0"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e99ef0902so51646885a.2
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783696148; x=1784300948; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfeOD7p/qxHHEIV6dN3ojdA17bZ6I64Gd2Z+QpoWxkg=;
        b=thZS8Iq0ZM6bXuETDaYwbr+PD3Szx1Q3YjpYVZpbHeyWd1ARxDttcmUQrYMRMmMhIl
         Pcffhzei/HLjAUQfnh+/r1K2W0gn9EYz7TX+Jl7MYjaI4vIB1B5BazuJwuQelqjFcWly
         NO54Titj77dmgXJhv5isxyJPITqQHUlx+Y6LoygWV/wu1OCWLinNpgiTtmifVwr/ds6+
         2W29kiDDhHj0sl1PvC+0NWAWkeWxejnFpzBSVE7TXQovXKWAdo6HRmG91MsBbcGQCxO/
         mCLi5rgjicL5gnK1Ith4zBkxZiduq0Hx2arO7yY9qXBnaiYE96MqTRMakPTEXl1lFEo9
         0ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696148; x=1784300948;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfeOD7p/qxHHEIV6dN3ojdA17bZ6I64Gd2Z+QpoWxkg=;
        b=RK0LtGmr19mgSs2E272YODEWRIhT+S9YhklLyfZE58yOMzUc8ogtKKONnpOhc8cP+o
         l+NJBWzQ0U/Jm7YOt0+4JHMv0aIWP0ANerOs0xI264isV7uk2sVr8jrvZgviPcIhxANY
         YPL+MpwJfVyzdBhS/xLWNEjg2cnYPyZrhHpnKFUpXB+pe9EiRGrIaPvNbtWgeSLly20w
         P3YhimpUY4ElmmfPBCtmafxXgR8MO4yA30CjWXCYpX/CyEj08cGKY6/e84nbJSZhMbLq
         zt1hoBp66x7MPyGNMtG5NQeCkj7R8LDMkuxThSoeGZFsvuKvGmH1tsXrvAafuyHhJSKu
         R+YA==
X-Forwarded-Encrypted: i=1; AHgh+RpqbWBn4ExP0+LERTWbgBmiiM7TFmT13uZS9xidlUp8JFHiFS8sj9y4wLC0kNKQsvfi5wIYMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCJBjI/XVDOF8SwHTVOuahW4HygAaeMcLLW83bTq/RcsBcAgf3
	Xf2bXVVsahGRC4AC4ylLIumNUI6DJkoJsL8/ZiC159P+nbOz9ZERkDDA+AiAruNjl/c=
X-Gm-Gg: AfdE7ck4K4Spersb9gag9Hdjt3ophZ2Ia6wV+CbuvbMs+bccrYAFPGrbKuJ1Zof3b4z
	BKm2EnMj52uZlgPQVkTgOA/5jb5csx5xuRPfI23y68pRuFGbno4WPLYqhrkBrrVQ+DB8w4W3CWJ
	6NghqtjCUnRePNhiJ2b72eivmIc+lw44RTX8XlguNVHstxAdV9O6ewvz6qX/28sSRdFvV/r4ABB
	8VBy2hgzikJqQjH65usx79rHYbik7FaJweqeVXa2HqXyDyfpoM3i/XGX8/aZPQCPvxbTzjGV0gW
	XaZcgS7efEEAKhxm9ofgTr3macd9KzPTjQ1QYnjrpayr+oK9ALFEhnvUH0L0jd1kgYAjuiqUb6H
	8yJrhfJ2zTu6NZLh/JYxCKk27fhJ3GjzGfyJZvc7SjGWqkM+0lARx32P+Bfn+Pq74Hc/h89PEYF
	9MUELvcmbrzq10KMSt3YlZX1ojPYjQPnGxlWLJnWMqxt0HxBGVEPwxaxRJ5hTIuOoh8OlF
X-Received: by 2002:a05:620a:4414:b0:92e:7d53:8e8d with SMTP id af79cd13be357-92ecf55964cmr1359477885a.27.1783696148308;
        Fri, 10 Jul 2026 08:09:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d34f76sm213283985a.35.2026.07.10.08.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 08:09:07 -0700 (PDT)
Date: Fri, 10 Jul 2026 11:09:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
	damon@lists.linux.dev, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 17/30] mm: prefer vma_[start,end]_pgoff() to
 vma->vm_pgoff in kernel/
Message-ID: <alELDgm258nhjk3b@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ea87349d63205bf4c26ea79854f179a9bf8cfb0b.1782735110.git.ljs@kernel.org>
 <akZCg73F-oGzDp1a@pedro-suse.lan>
 <akZGqclqQ6gS12Vv@lucifer>
 <ak_C_o2ehS17Q5HV@gourry-fedora-PF4VCD3F>
 <alEHy1raICek7imv@lucifer>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEHy1raICek7imv@lucifer>

On Fri, Jul 10, 2026 at 03:56:33PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 09, 2026 at 11:49:18AM -0400, Gregory Price wrote:
> >
> > Silly question:
> 
> There's no such thing :)
>

All my questions are silly.  That's my secret :]

> >
> >    What's the purpose of retaining tags in a non-address value?
> 
> Well if you want to reconstitute an address from it later then that'd be the
> intent, but I'm being hand wavey here for sure.
> 
> Main thing is to retain stuff under the page mask
> 

Right, which ... 

vvvvvv
> > That sounds like there's fragility just waiting to be broken.

If that's an actual issue, then our relationship with tags is painful :[

~Gregory
