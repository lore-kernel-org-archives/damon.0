Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3084C37DE84
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710336; cv=none; b=dc7PdyqC4LkxB7KAF9nVNN98gc9RN3gIHE7xYIZtMXnC6KvKLhpkdB1RB6Sdo3cOPSHNvAmpE1WZY+x1z8sOcXcmjLW+y6huAdP/fU0TIpEHPOnQgifsXSrJIJn+bNbph8rJZAjI2XqzbFE+XZQCVK3m6wcaMHAH9HgzbwV8W1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710336; c=relaxed/simple;
	bh=0O95+yAo6D3yNWuX9lzWEAviyk6KjGyNsi91HXznKL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLo5WKeR2zsiAER0sSLgfS8kvFSXJV84NRpMW5Iz7R4kUP7FzePq81LuRukNRr2X7WyQ2SrIddfVKLi301GuLgc/93t19exQr0LByQGT0tR2EDSf+6DSIzg9QbWAUf3MdGII+/CXdlVodRsHJNDP7Lt++ZPQIWPEH9hKHDM0BqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GxTqMWE0; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GxTqMWE0"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e57a753f9so100196885a.2
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783710333; x=1784315133; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Cb4T8zzpAMOVzwqCT+1eDu/jZ6x8Q2fk7Pyrqw1u7c=;
        b=GxTqMWE09Su8xxtpbgkqunzXi5C75QUhYYefq/HT4TMsLU8UKfDBEPy/lMVfKyKVoj
         h8j/JBL+7bvOIfESliEenCJstxcQLcHfj8YOd3ej12iI5zd31m/tcRCi0JVO/6U1b7Nf
         TerVIxjxZAWRldnNcC7MlRGlfGe5U/MULwGx6B6VuYn2KW8oljZbupaMrM/hLX9J5pGt
         DFCYjxLQKhWvLyE8l3IEwoAHKn67t+9YD7azyNUL32vLKyxtxpZvlBFFHgCo47JpffKY
         RvNq4rKthPZ1DiJPFe77F2qUwkHAxtjWGvrBFkj4ad99j1DbSWwwwRyqIs9T8k5PUvR+
         3m1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710333; x=1784315133;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Cb4T8zzpAMOVzwqCT+1eDu/jZ6x8Q2fk7Pyrqw1u7c=;
        b=iDZWRLHO5vY2F6VeYOUIBIxC4lqCb+NHXuX0CtXQ1/eoaJonZSjCI0XmzbDgf+PkH9
         pcP1QdV1/NDgNbwtZX6zM/vFO7GSd6wPkuYk5f6ewMwzYOA1jPLnGP0IY4Ou9MaLPsJ7
         gsl0QoVk3giVSHcmjF9CE71/IuIT2y09xIIsl/ey1IFyobfTugDHA6dA+dSRC/EiLGkG
         A3YRhzkltGgqmV7+AqbzaX3JCVPJNumoKtMLHtwXpQfzYJSgjHbApIFkbtnxGkkPBGdt
         oFQ6ajRXlu2hgl+RJUl78dfwsG+z1prrPMEz6z8zokRK5bCsfRgT7Sknt2ucWxsBBWlt
         7gog==
X-Forwarded-Encrypted: i=1; AHgh+Rq5pqDKTxe5za/zPwkEX9aWe8Lc7B/jdJiW8DNNtxsBZvG2xAXjL3IqO7JtR8E1EUyFU5c1vw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe6r2BoEMyQKcuwS9UIcdIx4e4tGD9IFwFrEccyBbzz2tSDXjl
	i+nm1lKuohxw0c4huCBzghfQy5AWX9hx8PrwpnAdmP7AG9JdijUsgze8K0KWSMnxVco=
X-Gm-Gg: AfdE7cl1nIySOZL+5zttUOjVqHZZ0KmDDP2dEyaByLIdIXxnLHgaxiFNzXZW38S3Iub
	JNih5VpwXPoE/Lj4gZ0C9vZ0PXHDLplqSasWv3c6lbQyAiCqt/d5p/sD0XpqvZr51H//ldacBfy
	BwTqYUNYG6aNqaUikqXSdb6AHCvvZR7E8NFGQ+FbyOnWvE8QVKnQEHHZBMLb3lWsHjPWSSANtYF
	0Hio24ShjRUGQ9ATEoxi3tNsovnMtIdnRmLBeF+/C8b4QypGse34wWiaUQNrOiJkvz5bUmMqy3S
	YSDAgHF3s7vFb2VCmBrxYVIbKY+V0Tz0pl+mv0K3+MqrruuLz0QSIA7zVZhRUocyozX8p5Imp20
	l02M4v0H34VlV4TTmNHVu54NqxyQpcq9SzlAmEjTm0oe5ik4srSHX5pHVAhJ89hQh/219ZY/q8e
	Rz2iXRhvJJnJjDiTZKCbi5tICesCjK5T2xoTYWOh60L5eoWrZ6MSgtqzt6wKgv3bi1l3Rj
X-Received: by 2002:a05:6214:33c5:b0:8f0:65c7:315d with SMTP id 6a1803df08f44-903ff971194mr4994756d6.24.1783710333250;
        Fri, 10 Jul 2026 12:05:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fe009sm47940576d6.38.2026.07.10.12.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:05:32 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:05:27 -0400
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
Subject: Re: [PATCH 20/30] mm/vma: introduce vma_assert_can_modify()
Message-ID: <alFCd1RtttwxKBLc@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <23c7602c58cacc23ef22618a27af9a2d54addf58.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c7602c58cacc23ef22618a27af9a2d54addf58.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:31PM +0100, Lorenzo Stoakes wrote:
> vma_assert_write_locked() and vma_assert_attached() are useful for their
> own purposes, however VMA code absolutely does allow the modification of
> non-write locked VMAs if they are at that point detached (i.e. unreachable
> from anywhere).
> 

curiosity: I presume this happens mostly during init and/or teardown of
a vma?

> It's therefore useful to be able to assert that a VMA is either
> detached (modification doesn't matter) or write locked (you're explicitly
> locked for modification).
> 
> Therefore introduce vma_assert_can_modify() for this purpose.
> 
> While we're here, make vma_is_attached() available generally - if
> !CONFIG_PER_VMA_LOCKS, then there's no sense in which a VMA is
> detached (vma_mark_detached() is a noop), so have this default to true in
> this case.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

