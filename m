Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D936680C
	for <damon@lists.linux.dev>; Thu,  9 Jul 2026 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610454; cv=none; b=roC2ZqOKOlS3zXgnom0urQlZlgMkeeIXFqA2gf/56Gozfu9k59TayQqQ4exK/uMIZo7AxANTrSQjU4d9yN0yskp/BlqV13/qlaBodnekZ5He4fUeTR+QqEypGhjpUy0Ropx1uLBSaqnV7k4NtutIJ0H3AiIOne2GGIkzOX+BqWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610454; c=relaxed/simple;
	bh=bI1J+cBiMa2SCkpHmKrJG+azHdWZ7mPEOFo5aU/4c1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYhRf59H3VjQCpqRO+1Sg17LQxyaFWERD2TACuIEgo4GXDiN6l6U4nNRwuMOP6TlDxyLsrLUGuz5q9wXwlDaKQEuQqnT6VpxFp3cKv89iXPApYzns5EQnDD91OQIIuvtmKJ0JpkTJj4XyFOCvAYbvbMpN+58TxyB3ixE3EjvV4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QoZv94y7; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QoZv94y7"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92ed19f4d60so67130885a.0
        for <damon@lists.linux.dev>; Thu, 09 Jul 2026 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783610452; x=1784215252; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3aG5hxu0JYH7EcM/cq6JX5Yef1RoVI9XARU/q8dKmL4=;
        b=QoZv94y77dZDEK1LHmTl5TBOFaD/R3F9YpP4Zh0FcZAj8RnxXtWW7YCKe1HnZ3Ss7Y
         6NR6bD6mFOTxqooMFHm/e4mHnjsAkvqPwhrpdlszh3th+w/42grdcTD/zwnQGA/MUmWB
         DVpjEVXxRea9UIUwe43FRT7lwH0Z+ruya2nZSWZdZPBlwN9OOr1JEhyGlB6V+mJn1p94
         oGW9iRApa1LL2IEBXtCHgPgvCY2WSOGBuktpWItmmj8V+mV1TUrw/r49lXqVRh3qo57P
         NL4cXF5gtepj71gSODldLfOHIKl1sNMgrjhOKvWvfD97uJ6zEOERub7X0TDEjV0cUhuE
         0Vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783610452; x=1784215252;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aG5hxu0JYH7EcM/cq6JX5Yef1RoVI9XARU/q8dKmL4=;
        b=Ahy0jA1jujo4A/LOdT1xzi5NZhcIFbYcIjsUFdKow4hCRIez925CXC6HvLTZwDyL+8
         lWAAjtHdRPcisi4G12HThR5lRrFpin6OM3x7KMXTLz++UNJKjyJfq4PzmGDZ/8E7QoGc
         8L2xwmswlJD+npMg76HSi6zVxdeWa9etSq2Xqyn7LQo7aj6ZUtbGCEJhNpFptQiTafRb
         PzXTf3Kp/PndVdDIzr3q5QmvbFNvcFcgYTx42qFMt1mbPEPAPC2Q1cN/rCoUR+n8xvUm
         r0TeXo8/G8iXj+6hXLCX/DpnLb3LVUhwoK2dolXrwtPQRN7T4Shf9mwDgEn++UCbl2q/
         NxMg==
X-Forwarded-Encrypted: i=1; AHgh+RrobU+4MidjWdh9a5INIXqMtVgnFzZDN7XHQqTmdrHf2bo+EfWhcavtbJbsW9Q8Ual2HXLvvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNB8Iw3ZhMfDLqApndNbeh8RMTCvbu3tMyRxqXIbIEO40fuBTg
	QAj8Mnrgz7t1vWyhEYYzk4alDMxMS2YhgGPldIoDSW4gYhOb0dMMHLWA2AAZBq/QhxY=
X-Gm-Gg: AfdE7cnyRNfF1E6b8LmaHw2NTRrQ0bs/9G7dnfuSybHqCLAsgQGexY30ImoDZX+QX9h
	JZbpvRiDArBdoWU9RW7YE5q1gjtezVcqJnD3LERXX57oPK53c4kYAkOk7+E2UBsdRpbqzgJPdLf
	pl1xGx25ibhVqlZQWm7SNBqpmUwGioVhcbNjyyT1NfbxC0QGcEmFvSBHsCuy+GLjjMSl1hSVwq/
	6fagKGxlFTCEPb7hJtRX17NR2ZXChM8BkuvA8woRqUOBZ4BJB8/CGIKDiLxNeZb6op91yXiP8a3
	Natr+yO/SnLqClQqD93SvnYAVlOWeyUmxV1V99wgWFiSOwr7dQyTAvxcYIxnl94kFkLattgmsFD
	NOLO7PyhITBpZsiuOnmzrnll3oLUD0M7DqzPNaQPK/zbJuCzH0XTwr2wJIp/rL7L+cWOJDhxHs1
	NiXevCHZ9a3Nb5aSagnNu6xWgg0Y6qUwTY/7HvC0YGJvR+KxktZxJr9wv3jDBnWR2ap/yE
X-Received: by 2002:a05:620a:179e:b0:92a:f74f:904 with SMTP id af79cd13be357-92edab23ef2mr337298385a.1.1783610451142;
        Thu, 09 Jul 2026 08:20:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ca90a5sm1652288685a.32.2026.07.09.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:20:49 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:20:44 -0400
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
Subject: Re: [PATCH 14/30] mm/vma: minor cleanup of expand_[upwards,
 downwards]()
Message-ID: <ak-8TKDC1GBOeMOM@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <b24f70b72f0a9e2a37b904e5b59d80b88bd42e4a.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24f70b72f0a9e2a37b904e5b59d80b88bd42e4a.1782735110.git.ljs@kernel.org>

On Mon, Jun 29, 2026 at 01:23:25PM +0100, Lorenzo Stoakes wrote:
> Adjust the stack expansion functions expand_upwards() and
> expand_downwards() such that they are expressed in terms of named constant
> values, and make use of vma_start_pgoff().
> 
> This clearly documents that we are referencing the page offset of the start
> of the VMA.
> 
> Additionally this cleans up the overflow check in expand_upwards().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Gregory Price <gourry@gourry.net>

