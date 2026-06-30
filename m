Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF4369D76
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782833463; cv=none; b=uEOu8vBRbs/2ekLDSAqb7/X3r+kCoxscxleSL1sDoG6gYLzi6Ll13gQToQJl+bDWRuoG3ruYaRZ4vi274pCJsNmyQgQL7jzQatbIje/FUBLFQ1BSyUtZ5M/odnefBpdREHKOlmzmc9amyv7NTuu74dqbL9DBGtpYcnFZ0ijMpV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782833463; c=relaxed/simple;
	bh=dsxaVzZxmHO2gtIU2TvsbwgiexrCHtWtBKWF+qAkz/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7D2xgMjasnbOZEV3PmliH3XKheJGXpUez1uh+YBtktqDlA0AydF1a1E7jOW8H7N+c/QtaF8GF8Bw5TJIBg/ATAUhua9QZOPPanb7v78CL4wabmHaR7LVn6vIjyk3rH4Djq/Cvn7bqUbV+YyDomuTvJFwPCTgXcBMoOjTfgMwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=W5kuzWJD; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="W5kuzWJD"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-80e4455b9a3so25122787b3.1
        for <damon@lists.linux.dev>; Tue, 30 Jun 2026 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782833460; x=1783438260; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvVAmqyImW7TQjYTHR7q/vQBEUZYJ1tMtKhaki/MPes=;
        b=W5kuzWJDJHjZrEvR7NLhLKr4vR1LjOrm8JaSr1OXUDxsGp1cNbrN+pFh2T90o0sbvF
         a0JLUdG9JAoEpVNEDtYBaH8TXKHV/YDlYo3IExBn0tA0wDjOs4E1u0LxuLsVKIH+Z0Mh
         yN8fUrRVOtJPAdn2hrPaiUyGb4JYi6d9Lnbqikb1us0N4g0lfioiq/gbfqrrjNVyPFrI
         Oj5gy4IvpTHtIIvJsYfkciMYGa9AKFihzCxez6FFv+Vaf3hCEeWQd49PqsI6SfYY6pPp
         cdKnGMSYTrInZ/QFmPbuaEFPC8eGNvOCEeEYWGKxvsgfX2UY81bhh8QMLjyw4I+s2Hs6
         i0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782833460; x=1783438260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvVAmqyImW7TQjYTHR7q/vQBEUZYJ1tMtKhaki/MPes=;
        b=J1KDPl+gfeX56PgfEukx7X7WYxvE0RTAr9JVRXse++Cbb2y9fU+RvEW0YVQmdAiMit
         wbek9PYWEqjiEXGDGPo1yGnMt635Cj+i0BBHoRgATYsNSV0WS0qqpYpnHbtSf1zerimh
         Ob/0BvW5Cr2Me+hI2hQ86hIE6afYVPNipjOVlZdZJsNxZiROO823rlzCW4/ENWPzrIgE
         ovqQQyEKvcWhslisayJgzdcVSRLGbao9CpjTTV5E9QjArYdwzC3fTjTUVIKx8cmVjU2U
         6dAumEOMCdthmeHl6ynUJ/wpIFeiCms5pZWWKzP8d1XL0o+9rtpafj03egVAeyPYHkoA
         XsrQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBHwZYEoPofx9JqErUbEyAcmkHBKr2FMq7g5AQ8lssbNBbL7xGzosRkti9A7C/YDstJM5B6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YysaAvIwzmoITvWrt7p28GOCWjx1XT+nAVRC2MuDoTAj0WSXr7G
	zvPppgjqn3dzOjrUkWb66BinkLGIWzsTrAlssoKd07MwQqK1v9JsgWuGfpVcQQEd00U=
X-Gm-Gg: AfdE7clKecnuprS/+uZMWExKv1WWYFtU/fiwjE+gMqeC5HMoIhhMrbUBjk5AOINa1nb
	ghnT+HFz2VNxNeiKDzP2uLHvu4v76pcUNl9ezdiac1ANNOOwCa7S/yMEfRm9yqREUz7hJAoDifw
	AbXMP3pTRo5Wl3VK4Cu1mta63gd5+HU+h4ShEOlI4XgW/zftYG68UTISgD+0ib2O2gvimlW/DGM
	RtU0rEHqtuQ4jqk1i4/HmgtGRJy4/7xuleAjTSOM2x3n/r7N3WMkdPPlldfiMWd7Vco3V/duPf9
	YTHq0MYHNBgHsVAdpBiIxFR7FSyRrPbrqImLL/4QEeMu6457ZYuMAEwW0pF3VJvtTBCGLAImsiX
	Rk18z9LP+CD0S1mQi25Fb9ZFyP8PdJPEwo3Sy5fK68pJVRaoLJuNw0hrpDVyGPWJi4eJ5uzeIi7
	ob/2GOov+GlBTvCO/kalPfw1adu9CWA06i1MzrJn4iUcM+wB1gQOK98uCIUwBtPIXBUsBc
X-Received: by 2002:a05:690c:6112:b0:80e:bd63:1780 with SMTP id 00721157ae682-810d7eb0bd6mr46000317b3.2.1782833460437;
        Tue, 30 Jun 2026 08:31:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a783d9d7sm25574106d6.41.2026.06.30.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 08:30:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:30:54 -0400
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
Subject: Re: [PATCH 07/30] mm/rmap: elide unnecessary static inline's in
 interval_tree.c
Message-ID: <akPhLlv66ZqQ-jrw@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <ed5fd5358382217a92f0a6afddcfaa030c933055.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5fd5358382217a92f0a6afddcfaa030c933055.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:18PM +0100, Lorenzo Stoakes wrote:
> It's not necessary to declare these functions static inline as they are
> contained within a single compilation unit.
> 
> This makes the anonymous interval tree code consistent with the newly
> updated file-backed interval tree code.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

