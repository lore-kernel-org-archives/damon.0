Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73A382370
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710128; cv=none; b=QPUN5LXxK0UrTfqMCAYyx2Jz0mZgZ0qgD4OQ7bi+2pO4lgiD3Xxi6DZ+81uA2uXbEftwMOKF22Esah3Bc/VppjDK4OZNK+ezn0ik1lTFOIkK4j/WwOrDn7uMeV5jA2XZHSmVDo5Xtfz9JjUZIL2/WDzPAjnN9nV5Me9ax54TzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710128; c=relaxed/simple;
	bh=47yOZh0uL9PiUmgaP7WAHRIYSRvyXRhMxAEwOuVsgWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJd6Gnl3C8qqE0Kotka4lVfLn6LIObtnmNLXQh3cTxXR2GMeUYuj8KZTHgE4q52NhMGtaOLs1FaYGbv60ZesyvYsbT/rWv8rghcyAOfVzqvx+3CuP/JF6XFmbu+jfZ6cTbMeMNdO+HMrHa6YkC9huK5rQ951yCXK5fuCvmS+hl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qj3hG3K5; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qj3hG3K5"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7387ac7d28cso336341137.1
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710124; x=1784314924; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pC/3U7Ftz6dY/QSNTLtw6DNyhuKVUlnEMcNANT8zsUU=;
        b=qj3hG3K5GJstRdx4P8mI49geBnx1AwKrEXmFU9weImfE+s8EwYAtVGpMhdHjEF6ULC
         OjFldmI/TWaGd6/W3ciKhkslBUhns04lhs8Xr3V/dVqM8TgxVZkNVIsugi1I4kD9y1Yn
         TsE0ZotCu9FjdZ4ljyYy8vXSS/Ft0QWVcvPNZSPELYD118Te5rgAkDAnpEu/weIfq9uD
         Eo02S4mYfywvXXY60z1BnaLFgT6Efj04lKJOAz82AkDRhgMbS0mdZaZXccngwx1pgJs9
         B4CclEhOyx2CgTKTnJaieib4uy3SQGOSRc6LuWwWVAthKPG6Q1WfGDU5Y21OeOZdYjg0
         xJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710124; x=1784314924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pC/3U7Ftz6dY/QSNTLtw6DNyhuKVUlnEMcNANT8zsUU=;
        b=k+BRdTCbFTpMXvCsBIJ38HYBymK6uLHF7+VcJgVeBYyz5n4Hyvg7mJSwiQsFP6RSOm
         +5Jkpe6wpyZ2+Vqh9Nt65zEJ+hd+nrOvdMrnSJhFDr21vbUkSuk5aiYEMz+F8jPK79Uh
         IBOetPHOUkfDKvZQJLTbIahOIE2DT/389WhcJjpQIBicSw7Mnw5Ohpt/AqjWXVhTLNIe
         txTdCPLdCJPJigs7x/D+3mez0PQznUaGEQVG1G3EA/wROHMh9qziXFTxLCidGw9VW4Hk
         b4hCTEPb766B22cEWuFZVaIRUWNVoDDAwMxeornVKGBxuhkuJ3C70GYevmA3kGf4xXgL
         CKgg==
X-Forwarded-Encrypted: i=1; AHgh+RrtfCSUWDQ1MCNJWmObq/32ROyQ74+gBgk50BRHFFn+4ZW2170+yp0pr2U8g61IMshAJFWncA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAzhqEBY6rWCxsZnpMgYTIXXAYxrPBV4IOfZiUFL8yqEuvAaq7
	1SG5kHo45xcfdW1aJey6wI0Qy6Ieq6hNvTKsgmzMROHpRoDSHO4Y3U8+mEsxYqZcMQs=
X-Gm-Gg: AfdE7cmHorTyy0NyThc1ANvJV/pTHtiqUR/CWlbp+AMEzL+dIHSFsJvv5LMqvnKAILW
	AJb8VgqdG04CYRs8gut5Ff1O3SX08btUVyalRXunqHEqp+q+qtKgDTwaNdMiYL4bt31Y9TXz5I6
	wPOgKgTR2Kuu302Lb13hsKJQD+Dg0yLhplyKkavSokUN3SbueMvRQ0yr7e8SnWI8OQPADib/I3N
	exaBP/3EfFZdLWnW/7QQkMd2yuCTIuZHrFdeBbz1PLCZasKL01tv9ZXh8nOgLwUgDYV4VNvA6r1
	Olc5w8kowJ/cJZctHtPZVdetgJag5q1NYky4TL/dyIyRQWdu0Yu3/lAtG5TzP7B23Y85n9TbRm4
	UCgw9u41csSFlIx1VgJV5im2cCpPU1XC+Mm3hW118wcHPJnCf6T5tse9FxJkym/rQjohaOT9C5v
	RObA7NUDgEozq5As10DSIWleOQcwCWMkNmEYmrxTMAsz8SuSA4o/HF59W1AVmS78pIQfJT
X-Received: by 2002:a05:6102:689c:b0:739:5f55:3c3c with SMTP id ada2fe7eead31-74533d66217mr325833137.13.1783710114831;
        Fri, 10 Jul 2026 12:01:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm48074036d6.19.2026.07.10.12.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:01:54 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:01:49 -0400
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
Subject: Re: [PATCH 21/30] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFBnZ8RcRN1hlk5@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <794044881e454fd8ac13e59d5ff5fc86fca08b03.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794044881e454fd8ac13e59d5ff5fc86fca08b03.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:32PM +0100, Lorenzo Stoakes wrote:
> Add helpers for adding or subtracting to a VMA's page offset, exposed
> internally for VMA users within mm in mm/vma.h.
> 
> This is to lay the foundations for tracking anonymous page offset for
> MAP_PRIVATE file-backed mappings, where adding and subtracting from this
> value must be reflected in both the file and anonymous offsets.
> 
> These are used on VMA split and downward stack expansion.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

