Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52623EA83
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290468; cv=none; b=UqY8b5duymAubdeSdoSiFqoHW4bqhT7qI7/OIiep6tY4IXR0QPiIjm/+BqNPqQucyg+vNHYhWQG8Zv0sAFxbmzA1I+vxWY/ppnGy6iUu/Hikusaam9G1ttRbj86+zsRH8jZWgbb1FnNkKHHcUCei/oMgSTM90yV9IIvijs7vovo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290468; c=relaxed/simple;
	bh=eNPkjAeTFFEup4r8l+z42pBVWDiPic/9ozk1yJMmQE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1+36eCl5h1zsUvuI0K5d/0PE7NG3vqbetBgoCQnVGTwY423V0lhrau5iBF2RTmc802iYDVaqyqDpD5OaBAlCz5geXn2LV0bPlOAxuw3I7jwTSx1hSC9k7BqQyJhiLI+290ChmufI0rzeC/FbP7u9U04JZCIWJI3koEvQK7hetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FFl7tMUo; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FFl7tMUo"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92f0b5ed131so41031085a.3
        for <damon@lists.linux.dev>; Tue, 28 Jul 2026 19:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785290465; x=1785895265; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Og/k718MfI34g9XwAhuwuQilIeorUnfQgYxJimga5lA=;
        b=FFl7tMUoOlHsY1jZ1mytm2N/MSpwDYlJRQL7y6RaAVLGYqJbJGoD9nGaBArG7F4kaM
         tbtMNB7WBrtgjLC8z1YLCfYF0oz981gQFaxYLaBNYMmXlIoC5P5cp6mqUEGPrAgn2SJJ
         0UsALuYJ5eYMjIKUORQconT74vZqFcJT4IYFUwO7L+6sbXr8RNbcXBZbYbFms28vhc4F
         T5iPHf0YSCgLJRwEMGvKGmUeRWrr9vG/cAddZI0K0TNScxTslZ1e2oS3a10cIwOs6J6k
         FGqXOM86VwL4Q2fWJ00Dcqqu0wtuNXihzddJmF3wBnGjWYP4Y29sXFhcoZn0+sm7RY04
         hedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785290465; x=1785895265;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Og/k718MfI34g9XwAhuwuQilIeorUnfQgYxJimga5lA=;
        b=kgO98g8WE3yKikLIgDaHyKJ1WeMmzQvl7FqKvMuWNVZra+ETo7f97PEeXuo2Zfk9Cr
         ZkeD0prptQqPvB5rAnhPE5crITDHVxKG7CMbLkCBuLTgcKlOmubUj0A9V2mI9+ENDRGq
         TW+MG398z14SKA39roBHbXa5r+CVR5HLvCYT+jPuNQ3nUv0SsC+IZNXqiVB5ignqFt3P
         xakt5lNpEW5DePc2ak/etSpIyrCAe1UcPPn2H2ctFLi3IWLMjU7bGBm33+zVbX8q73QE
         Hh/DZoy6G++PKu27LL0sIQ+Zgxzzw9TpIZfNf3kwIBYTE73U+zaUWA4S96EO/esQqDe2
         QCCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr2WKaalUCXHP9JKZoxl0yOiwwXkBv8id7eSGdZqq/6W5yVUvUhqeDrsiXDaZ6TLhiGvxuGRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU1wn4JjsgU/92A12OSaYizVmDv4qMV+6aujiSOx5qIs011mJq
	MKnKx04AnG/4H0Vx4k32q9PsX2wyi1jGzkFMv5xfEOl3o5VbP7QUFK3j9PFjYEz5frQ=
X-Gm-Gg: AR+sD10TWPa8s1uyISZVrAvJeo+KRaP3kLR07+emOF76iexrN6gH8vVnPtwZcbvnW02
	x2PLT8ahrMDsYm7h1vQawCl0Y2HY6B9+tVEdJu2t2xQhlfyvxXmwlVhlgHwZF05O2SCyZ5qeoX2
	r7+grbBv96RyUdy0W4eweV+BYWKsujV02pBXt+wytHvYrPEgIMBGmaG6t+Z+nHHV4/gOzLAnV1r
	QR1vXaGWrasWnbmy38gE0U6U9S4uSCTYhsXCXjykfGEkoggLDTru8PYafUoJaCtFpRk7QPOSQf8
	scuOuYl2D4TdXvUHIyc2OAVCKLelTdWFDhJR5l8B98SBS9PKoDPynYN4dZG1yVii0UUE52/Hphh
	L5FwdpMpt/kHTndbEEnWURBFbxsVL7uSiI6xqoFKv8FA0JdZ8SRM+Aq2Cdw6P5aFHUkzgSrbvWv
	qOKwy9jWf6goHzdm3FYqG9As5ee3MdkqoqbAuyg/Zqh4W1STEUkxW14CjEK4QuFwLK3ZlxE6n8t
	BIBWpul22g03J/nlEadk1j6tRMKohSO7Swl4z4Bvo/nAbJtytTinyGT
X-Received: by 2002:a05:620a:170d:b0:92e:c118:18b2 with SMTP id af79cd13be357-933027293f1mr509740785a.81.1785290465281;
        Tue, 28 Jul 2026 19:01:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221ac2sm67571885a.3.2026.07.28.19.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 19:01:04 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:01:01 -0400
From: Gregory Price <gourry@gourry.net>
To: SJ Park <sj@kernel.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, akpm@linux-foundation.org, 
	david@kernel.org, ljs@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev, vbabka@kernel.org, 
	jannh@google.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in
 damon_get_folio()
Message-ID: <amlZ_6pnt2AC-Ppl@gourry-fedora-PF4VCD3F>
References: <20260728194714.3713735-2-gourry@gourry.net>
 <20260729005036.98063-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729005036.98063-1-sj@kernel.org>

On Tue, Jul 28, 2026 at 05:50:36PM -0700, SJ Park wrote:
> Hi Gregory,
> 
> 
> On Tue, 28 Jul 2026 15:47:11 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > All DAMON physical- and virtual-address operations obtain their folios
> > through damon_get_folio(). That helper already excludes ZONE_DEVICE
> > memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> > this is inconsistent with other callers in mm/ which test explicitly.
> > 
> > Add an explicit folio_is_zone_device() rejection in damon_get_folio()
> > so the guarantee lives in one place and covers every caller uniformly,
> > consistent with other mm walkers that reject zone device folios.
> 
> Thank you for checking this and sharing this nice patch!
> 
> However, I'm not very sure adding a call that not really required for only
> making it looks consistent with others is the right choice.  I'm especially
> concerned if this will confuse future readers including myself.
> 
> If this is a hardening purpose, we have CONFIG_DAMON_DEBUG_SANITY for the
> purpose.  What about using it with a good comment explaining why we doing that?
> 

It's actually two fold:

  1) make zone_device more consistently handled across mm/
  2) make these checks possible to abstract out later

In the private node work - every location that we'd need to filter
folios based on private node membership is a zone_device check.

Where zone device checks are missing (like here) there's some other
implicit reason (specific to zone device) that allows it to be avoided.

I pointed out in the sashiko feedback that DAMON depends on a check
for folio->pgmap in the hotplug code.  This is all quite fragile, and
we can see that at least one patch in this series fixes an actual bug.

It seemed warranted to go audit every service and add the zone_device
checks to make it clear there's a zone device interaction - even if
presently unreachable - should some silent, implicit filter change.

The goal is to come back around and replace these with something like:

    bool folio_allows_mm_op(struct folio *folio,
                            enum node_states feature)
    {
        if (folio_is_zone_device(folio) ||
            !node_state(folio_nid(folio), feature));
    }

    - if (folio_is_zone_device(folio))
    + if (folio_allows_mm_op(folio, N_MEMORY_DAMON))

If we ever get to folios having memdesc flags beyond page flags,
this also gives us a single mm-wide location for these kinds of
checks in the future.

~Gregory
