Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A815E97
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555568; cv=pass; b=FY0sVjfoMmAifyVU//IcYJtdsdxk6xP2ZjcooN85LBbBSgJwKWJ0iLA+i8I8eab8RfPVYzUR6muuyEcTi8fqcC1iUHCWoDzFBzCDCrZgP6cCYJyo4KagjC8/FUwTVFSf9JukxJebtPmce6T3cVdtWIdjQHb15ktXtET7fm7MRNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555568; c=relaxed/simple;
	bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr8I7gO+FBZwTiL8OSr00MP+2+VWZooOFx912C0lL86rIGo2mBSyp540K2GSgFj8qb3BhxqLjFM0s/A8e5kA9Mu+WIO4IgR5FbHTESxTpmY0WZu3Evb69KzgQiwJ7rjJN+fIHul5UObb8eal5IhQe27HjmpuYpdAmm6PauxsI6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhJVIkM4; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhJVIkM4"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso722541a12.1
        for <damon@lists.linux.dev>; Wed, 08 Jul 2026 17:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555565; cv=none;
        d=google.com; s=arc-20260327;
        b=K51F1owu1/s1E9iPsZHScXenbSaB/p52ccMOFyEhtmIEV3Iud8OgrLDXg9CbYnn5Vg
         84OckPJk3fh0b3r/NkUXciki2PN0V6WnDzWdoyQmXA4rZuhLLTCoHq9i7LxvA3qTZ4ac
         ItHSWf8HI0P1/EYet0iNcEdHicCy0a9RxSOghAWQ6cRt3e67txBGdtcL4wivqm7nPUex
         nBaftsl2NtUiddH+HLT2B8KSNObq0jDr/7um+lCpIvODgVU8iVdcgm0iLo0Gf1jCzY5a
         eZf8U/Gb/4VgsXc/jtp6j6RpzJHIi8Py1ltQC5tEocbB0rwHEs+ku3ZVE3qIACvppOL1
         A2XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        fh=nh3hbzX2rKbdqLDBWQTVzvPBNUfAPVXzVgxOcmV3uEg=;
        b=aMyULikrg1uiyxpFJzYcrlTrF45oN+sAq2dx+JqqsIOFqiTkN6qDugyoY5SV8fcLsx
         gDap2OV9W3MQ7kLNKYKJuq8HwT9hq21Mh0EUXi+La2v7jMKH8Ak6X2tTnxvs0q1QKKC4
         /khCnj2NAdMml1E4ZJRy+fzgnSdWbscMYKJhDAI4KdtBS05I7aEtFckh+QZCXsxh3GvT
         dgyuALiaXORr9L/Z/nOxVJC7+zFbOrYCbqpqmLSjrP27rZ3e4qP+P5HVxwn5ik0PJVcm
         oUGvt4evLquDsRR2SPYz1llzSXsZcvjksyfDW0RZseuwqxEzkZw4zKXtDZRImDsgKnxy
         9E0w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783555565; x=1784160365; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=mhJVIkM45OUDuijRQhJCGxMcU4BVaSp09AqI2hnS8Ki6Y6RNFNMGZ4/s5R5c1f5k7g
         ziB/d0CifLhaaoJPcgMNTX2C4Y5sePITm80rllyzjo18F1N2XBSAFdelBGxCML25Dr+H
         i/IOXVXIVf4nt32cpdS6iwjJ9QA/wGCnpVxulS7vrXczeqHIgpKYKq7NRz8vrh98O7KN
         EUt7H5pa/xxqvKGKFJcdpcFeD/+SbVJVYdZwcEFNbf2iwKW/Kn2h13I/J4BZ13eC0LT4
         DRrg1nj9suGX18iFVRUHlOkjYa0e75X9oxIKH+8iJ8QKKqjLU0//McufwrR9QMK1tg7x
         /CXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555565; x=1784160365;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=i451JdLa3Chr+Q6lfTZURXF8Hj+Nv9qcK0wtN8g0F3CZidHtNR4W4RNEAsfu9b36by
         qXZb5SkxysYsKKDNYj/nAsoR0UiQvPtQD0+1mtzxaURr94irw8ob+2X2Erv6OTV3WLxR
         QtyC94GRvpY1RfINGwC/CxgqpUUGxUSpIiR7rEq0YjFA8iWwzIutHI5HE25vTu9Fa2zE
         DybWEuOaAGPv5Y29X64B/C0+3s/MzCun/ylW6a1Jny+Yp/VfXP8BFQdAtbbQk9TuceVd
         VvAWfcpYVhJacSWXyKXLV6r5R7k0EhsUVBmQJhYu71K9EKA2J5JIdFgLUB4JW1TGFubz
         GQ+g==
X-Forwarded-Encrypted: i=1; AHgh+Rr+CFu2NiCHkaiTs4rBAhP9HmHmcjrHst5a+nzNO4eOuBC5DYZpc/69q6wxlAudarLmi70HlA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOXTrEgSBxLN6hOwYf4+/a0DrNeldaO5JWfBgy7QIWJYYcctIh
	4nNhMoWFGRV9d4EAxDV/2Miuth7iuLSSQ8QGFZnHVmIvGk082MulR3lgig/HrztbKge2TT6eotw
	0KsTuROTNER+LdJlipVFR9KCR30uTjy9kgKfqOu6+
X-Gm-Gg: AfdE7clGOjjsPICUp3iVmAdcg8ZgnuIBs55Hkoq6VSv+/6Q6wpZdRYulf6Ixzf5EJSj
	wD41bVbdlL+uiUMdVF6XIU5rtvrUbhzLZQrBIGXdH05YDbjb9jI6oBUnNhP7udItorhcqAWmY3n
	o0r/9ZkuZ1gqcweeQUXJtjjtHBX+dI5vM3FGF4Z9tY2iNML7cqSKbYP755waV4Dtv2edyLiDQGQ
	b+H7rz/tzjDATJ3Txv88fKUYCMW3lIyBoirTBNL8c/fJyC3AQ1u5RGsEEAb63s2ipxhM/Ja7uoi
	z/eDtyX5DtTPi5112jpdmSVlyB7OzDLoWSWX/Reg6qB1O6pqndKrQ32E5fqoWfCqMecwSA==
X-Received: by 2002:a05:6a21:7482:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3c0bcbc1353mr5760887637.37.1783555564841; Wed, 08 Jul 2026
 17:06:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org> <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:03 -0700
X-Gm-Features: AVVi8Ceg-PSWltTScKU18ZF0mdbBsNHDv0s-VKhIaqzjwQ-q80D6zfZMKk_VWII
Message-ID: <CAEvNRgE-JJAzC0jp+bY8+e1+gYSH+MjT6JqX_DfCcpaxOM-Dtw@mail.gmail.com>
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Lorenzo Stoakes <ljs@kernel.org> writes:

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

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
