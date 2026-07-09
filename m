Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5763A36827E
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610577; cv=none; b=G/wx62ZyjgM1lZ1jgqF2LiYL8VDEd2THEmiw5tLnHdWFmPMgtECjh6gVPv4bhtzn5MLjZTWLS2cKE+U9bAc9jMY21go3oIQZNRnh3TTCaYlSFBoUeSX9luTijQEXlcL7PT9XlgMUoh4a6zN6t8Soyh5/9W7ImoSKb9brGxvPe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610577; c=relaxed/simple;
	bh=WZm0pCIlMCZnYkWqHCv0Ceyplb5Du4QgkvAdE7k9ZdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnBAlqI1vShhb10f4sYkBqxNDGujMTWcFKVtL6twgCy/JAKoJgnn3vTIuFtEtu41qqTu9ojMggksCh7+vSPWcj7ndTnAKrKRMspFT2Hdpmz3YYSM4c3o+WWICxthsj26QIyVY8QTz+EIru3V/rP0CNzCYDljk600afSV41ude+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=oYxht2HI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="oYxht2HI"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5d50b0dbso122004085a.1
        for <damon@lists.linux.dev>; Thu, 09 Jul 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610574; x=1784215374; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8MCYdDNt+ln4FYDiI3hqZQpolLcmikZ66uE9gEYE70E=;
        b=oYxht2HICKu4TpvcAFuVPgHA68VHrPB7RnGrN3uTOtUDeraXIA6tYZENdWauT4IuWi
         CjLG62HmXTbfhWA9VU41kD/fL6KJ4kXYCjoNOOVAqs8Xrf4PVuQ1MGqQ+0hNjTgmXvxV
         jpvNiELF1Q76+By2wuW9052sBadINXJPojKqlKjVd7uzb1cSrEnz8Cz00m48NzSif7Dr
         s2/6lKjm9u9tWgDZQbtxaVPH2c65kd0LpStALAIOJbfntQ7Qh5O7GNUVJfs33fXKP/uP
         /wV7I8zBiIQQ6QCTUl+WX9UCGyLBGU0irIyGvlZXYycxJ7jdwZThCBFFrZb0YneiRWbW
         a9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610574; x=1784215374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MCYdDNt+ln4FYDiI3hqZQpolLcmikZ66uE9gEYE70E=;
        b=lb7a9VAj9Ufqi4zTnPJA6S03/PXcoAVl0MRkcZTUcK30U97uDJzkjN5hpnGayldE6o
         UZskr4bGtV0h2ztUY1dN0vMinvgqg13VBrjp5sEXNeNxOzLTgtKoBIiosLh6TIGVXWdW
         JTP83wU9Os8xip+A69yU5FDr8CYtNrd8Vmx8uP6ZiOeG3obM5D4DltqXYI7xhFk+jXM6
         1LIlrlt/rD9VV27Ql5jm3QJv1NeTTw7ZDVheLiKcAhez1kNOjNll7BhOBJNDmKXODTCc
         Hpq4sR04De4FOGPDFoaj4B77UECvrxFGH810vBXayq+W1EGi6/j9mlVQIoSGvkw4xGTz
         xZSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr65oLXlKZx6mrRQv9Uh0VlU1wXewSfkzB/lEOpT1MxRUp15fahS02xP2vSW31v0zBLb2fuvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzn4DnitVt74w0dcGoEPMBwoGb6p8+NUNYmYGC4AUL7T/gXYR31
	ckUxYntG400FON6FS6fEbvD/io8mWrNfiasAXIW5OmBSq9LbdXR/vU8s+TnqpIpRvQI=
X-Gm-Gg: AfdE7cmaVYe4f/Mc/08qoFo5AFLsGKcJZro4MntgtpfIrleKLoJUJSve1eDXF7OJ8ki
	kT0+r8InrujnV1eRhq/45uoeC7AsTCStIv4oj1ZEPY1joHhuJjcjVA85lDBPa+HWPeudAg+UPtf
	9vx/akjdNlYXJ7DQRjGsaHq577N1i8MdvnFOsyl6DRecN5hK1RLtn1piNvMq5kVZE7/3Gl+m/Oz
	5lzkkr2n90I5YMwp25ea2P00d0w25cVXceWL9gbFVDXvYWeo4gOeMcxnLwP7zaeHfBZVTE+JYcf
	2EnlZXQmRhHVXu/m+ljoFFab7HYZoSaWRgziRi+72/ZPZkjrg2lw+Vtd3K7zP3bDjnmyk/v106F
	JdxZtUHJhNLE5UlGKQhn/EACzdBGkXHLkcrzHl/UEcaPBu22bc+4kK3DhAPtC68fFclRHce33rQ
	iNBoLZIu04tAJkgwlvlEflXEHIezE+vLJg0NrrkPoX4P2hqBDaQCgkFWInwjVtewiKJXfw
X-Received: by 2002:a05:620a:28cf:b0:92e:68be:1c5 with SMTP id af79cd13be357-92ecf6165e4mr847751685a.21.1783610574232;
        Thu, 09 Jul 2026 08:22:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b7fc3asm1638936985a.9.2026.07.09.08.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:22:52 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:22:47 -0400
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
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
Message-ID: <ak-8x3TWsuhGzKlJ@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:26PM +0100, Lorenzo Stoakes wrote:
> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
> 
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
> 
> Add comments to describe both linear_page_delta() and linear_page_index().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

