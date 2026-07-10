Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825333B5826
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718223; cv=none; b=Rnux3C5o7TuFFBbXFpmc6Hsm4Pj4KCgGo1rWmQX6HP0lmgBpX/nlDuivRFSRzR8wz8A6r7MOmMOeC+lMxis2coKNNo5xCz/m/qIPeQ6mLqVIg8EhUU6zwLOdlhFC0nceF5r5nQYcRjpPOKpgqOPX9Neb6MFSjJp4zmBLe85es/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718223; c=relaxed/simple;
	bh=5KPNhmwijDAsBGeZ64JTaNX2be8iS/2XlIFbwRyt0OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpJN7zBSBhFcDrum4Cv0Gm8bLcmmzaq7PltMBEzJ6bY9Rd6i18SqgXYvpamtvsvmKFfH5Q06lFqX0WZ77VVzlbcsZodylwiCEWcfkyFDzJ/deXIzrunI1dUtehPWxoOa9O8wGRn5Hnx6uuY4y+xOSPn729lI+NZwKsTvFhbhJ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZD+xd7nJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZD+xd7nJ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e6a434cabso71486385a.1
        for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783718218; x=1784323018; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Izor2xUYDxPFma+uXVb9laI9dziDM9wo4fE46zQgxzc=;
        b=ZD+xd7nJ+lhPLJK2MGLC6laAodd54pYiKGk9wDglrZhYZbNlnIbjuEgsRBQhBae0P3
         ChxzEpHmemUw/k9/fRlbU7GRZjfcROlGyYdRyuFcBlopR5Qe22urenPqH3wMriYy/2oO
         2FeU5ZgiR8elwUk9c55BFTwTOvq/2SrW7E+nj2CvhqmagpauTvut6FwYr6ttgqYugo/L
         87ruMxAeykupvs53AokxASmsvsFSCqrdKV9ebRE55TIb0eyfst+Hc1+sxgw03Ptedtya
         habm/AmtLTP5aYoQRyL5ZIA03rbEHRXYP6eXRR30fFFHsdd2IjvTWuoWalIdvVkEtUo7
         mDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718218; x=1784323018;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Izor2xUYDxPFma+uXVb9laI9dziDM9wo4fE46zQgxzc=;
        b=s4J+xUHxM72XFNiu969kJFoFgBdJZ1IgxP2FkU0XMOP44uxUD48Mb41684bltputCj
         H7QG62cP0Ihjc+PPmU2EgcWhU3T3j8qQG2r7BfvUm6ROsZhLsLf/4HR93ToKUXGrTAns
         irNAodT5DL5NajavH1cL5EY/z/P9kSF3gxiBeibBr095hh5P37XmLick+EFm7xDGe3LV
         5efrxBMf1Eljqn9b9VaOxBsFHZQc7aILp5h57N2Sh8wBrQNQLNfUB8+91+3i/V2BEu5x
         m9xtevfxAJe+y/2yMNmzvSBuufDiDuvjO8bPfJ0JgOnTXXH7OqJDzQ3+WmSn1bbWrPK2
         Fw/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq6NTNuoEsGO4ENBbtwuMu4CIuIx5g+EgDk2Jcx3Fh1gIamRN/81gAQX2awklznvpvHnsPPug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv3UDPq07uYh3Ay6zxnMYMEETva6rjGPX2kSZuRcd/0GoVtBx5
	r3G1CLZbvJPf2+9okY6SiRxZyrsS2Pukcz41imNpY/erxgSr3XnK2GBN6xRJIr8wutY=
X-Gm-Gg: AfdE7cmfQ6K/G97h3FcSIIf8dGXSxLqMZQj2PWhOT1TZxZ7bkX4Tz5XCrxAFq+Vq0qK
	kEP9P7brQ6ugbc1pTemHPUAPZyIDY5oNwBdUe0q0sVwn2q6PiJYHZMJLge6zkhUZAC2MPcVFw+H
	+b7DXXjHxMRfu1HK5WpndpbRjyXba1SsqfWD5U3NkFoblJNXlduiwcMIUTgLiatUHeqJRndcE91
	Ol2VF58MQLWahJ9a/zvMFfzDuDI80NgOiV/socJ5NQNknUOaD/YrHCRuYQ+2Fe/qkwdn5yvMZ+Y
	IhFCqKRz/mNY7Wq4RYDzGVv4T+BA2FdCGCkMiWNs9twgPyT3CIgGlVvLjb1P5Qqv3SUqQ7w0WX6
	qVl1KLs14taQ5KmYXVObQtZhMkhSklJPzytYTW2iF4vpdQYvXFu4+Nl7xC6giv+tTrQx3w7I1/g
	HDd4tWhzavKAYqY3W3HCKm8KDgw1nsGbO2UhOoR5OFl9aeVc90ZUvwlpN3MnCULyBvJzqO
X-Received: by 2002:a05:620a:2691:b0:92e:72a4:f290 with SMTP id af79cd13be357-92ef2b3518cmr83584585a.19.1783718217777;
        Fri, 10 Jul 2026 14:16:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fe218sm49983646d6.33.2026.07.10.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:16:57 -0700 (PDT)
Date: Fri, 10 Jul 2026 17:16:51 -0400
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
	Naoya Horiguchi <nao.horiguchi@gmail.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	iommu@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	kvm@vger.kernel.org, Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 11/33] mm/rmap: rename anon_vma_interval_tree_*() to
 anon_rmap_tree_*()
Message-ID: <alFhQ71-WGGHo1sJ@gourry-fedora-PF4VCD3F>
References: <20260710-b4-pre-scalable-cow-v2-0-2a5aa403d977@kernel.org>
 <20260710-b4-pre-scalable-cow-v2-11-2a5aa403d977@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-b4-pre-scalable-cow-v2-11-2a5aa403d977@kernel.org>

On Fri, Jul 10, 2026 at 09:16:52PM +0100, Lorenzo Stoakes wrote:
> To be consistent with the newly renamed mapping_rmap_tree_*(), rename the
> anon_vma_interval_tree_*() helpers to anon_rmap_tree_*().
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Nice.

Reviewed-by: Gregory Price <gourry@gourry.net>

