Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A43B5302
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 21:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718276; cv=none; b=UK6y1S5hMtllVOOOPjP+QFJQ3hLgEc08CrLD2G1E4JReL7D1XWQzP3HPSxyJIkLAjC0ZdbsBvy+ruVWOpBeAET460NS6ntM4bCxmbQpMJQBcOay5zJpFh8jYVBUeNaqvfillN2ITfayeTeA105EPGpfUoZygqhsgOHJLytRL/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718276; c=relaxed/simple;
	bh=SIhLOUaxsH6uNqg5w5fr4DNuZv6zf1h5UML6naETP3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwt4qT2Ek8RHHgsfs+c2L+rEObT5W3Qhwzgt7DWLZJJwuj480SyRDlLmQshh9+azWDj0f/Crux7tENETh54OcxLewF97Q/orlZVyyruQGw8REAUF5JZPLLpK4NbgYlE2XMBsRfAl+1tnKe2GRWseGkQDfXgyaKLN0xt7z8lNXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Y1nEYFey; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Y1nEYFey"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e57a753f9so109509785a.2
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718273; x=1784323073; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
        b=Y1nEYFey/kqyULPg9At9aiXklXR4uGDGtcqndq97XEb0Td4ntzB8Q5XyCETMcjtrK5
         aH6zd+cyue7jsUkORDXZCYmBgHGu1+xuyrp8uipWqpLnWleSI/FgertbNbNWmblJ/fw0
         MbTbH1cRTONZ8q6L1dKhtpSepFvol3AZraHxaDnR3p1EP8Q1MoamyHhK3oW0YacfgQj8
         rGOEDPUFnVKrpdfPOGpoBoU8LCcW2eXtgkRH+T5V2Hy/cKLVCXj5D0HR8ExuAaIHTLrl
         D4mnkdtbUifk0A5+HCHVMN43Z44gh8iPCXuhpPx8N9Axcmp1vLE8nnZ2L0iID8KogdLL
         SjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718273; x=1784323073;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ZedB0VQ1AWAm53tDDWxHLVghH418fWVIB0lX7U1LiE=;
        b=pqhtG/djxeOACz2/KzM05CNxkRafwpn7jG5PL+fiY4rRFUWDJZOfNOThkEpn/NRXqQ
         aTcoZO/NY9lA00e0lR3bPGZ/doEVpiWOoiJEiG3UwQa0bb5rjwgDT5vtsBi5gh48E9Jo
         8OyYSFzyOp47ZxznL2XLhSFaMRW6I5N91JmikOLII8QNM5nzTU0lyY3bLN/i3nQo+eBW
         AuhQxY2GRwf+F/xaLIx237vRNgTJoEWQD6vfkbErv9k3TcJTsvfvB9wMRszAqQHPa59W
         jG15KO7MqvrAlxCCglbKvzUFlUR3EwoX9aYjbxjRh+YuYIlTnQIN/ur4tR1WvVtnMZHt
         /8Ew==
X-Forwarded-Encrypted: i=1; AHgh+RocLp2bFHylDhJIqH/56HRuWeF6iWiC+DEgNZAE/74ATkQLrZl0fEdd1Tz5fy3C5E1xVyM07w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzC9ptUZhJXbtXiTBk+rPHa4TmDm3+5FUGzbKIFc0q+3tRnAXbX
	GzoE/imbFlQg4efhbcpJI1ouMXrAdbRa3N3MucMJqDqV5L3uDWwHAnY43ZGYlFSSHPs=
X-Gm-Gg: AfdE7cnZlEIDQGB1J0q9TNYKtx6kQ2lDafoDnsKjWSQN3DVqVbgrGR9/1BDOadQ5SAO
	KSxC4D7vgqpzXw2xvqVwSVnY79HkUSvI8t/cRKLG2kwVl9/8cAhpvj5Yg2EEdQwPWiE3ax+m56w
	bS7T4LkahOG3uyFZyNIPtJOqn7/VcJkfWvETlNlshdbeJ6pgQ/9UKKJdhHIP/C44Cr4nK3vkWGN
	Rb+7+XAV+UrkZW4rRb/D7CQQ/p6Dkj9l3CwVe1ElY07lBENaWh352Gzfg5/M16g/KlhBKQTWpD9
	UxLFoHsIodIQBZP2/A/uWEsuT4syjv2jCutNazt4iszBlcKLFdugnV6gRsJc5QJI2Payfo8Uri7
	2rP0z8BDVkb1Bs+ybEF7E8BsYrJwieRgxLhqs8g4vegsRtz/NEv8RW2aSP9LLBc05lONg9XgQDD
	Q8AczJA+7XnRLem148+ke05B3DTGjkBp8EefryvQ95T4gZ5HapQyBKUS9BEMua+aUCISRuAKYiv
	4qDJ0w=
X-Received: by 2002:a05:620a:40d3:b0:92e:7afc:93ed with SMTP id af79cd13be357-92ef2d03c09mr108964985a.71.1783718273295;
        Fri, 10 Jul 2026 14:17:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b1bbsm292932185a.2.2026.07.10.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:17:51 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:17:45 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>,
	Lance Yang <lance.yang@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
	Russell King <linux@armlinux.org.uk>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Simon Schuster <schuster.simon@siemens-energy.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>, SJ Park <sj@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 23/33] mm/vma: add and use vma_[add/sub]_pgoff()
Message-ID: <alFheaAGWCIAjom-@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-23-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:17:04PM +0100, Lorenzo Stoakes wrote:
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
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Carrying over from v1

Reviewed-by: Gregory Price <gourry@gourry.net>
