Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D83955FE
	for <damon@lists.linux.dev>; Thu,  6 Aug 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035906; cv=none; b=Uqlqm79P0s6pWzn3kGtKKnjkpPD54Q9ZoaPWVJpkrHJQg0yZ1spu4mw+sWPP6/w8q1J2hBZExZi976LpIkPbpHmeK6TpX92yBLhhDetxob0bEk7G2g9K9UUEkbDsd2SvQ3TsAlwTx9SMWcliejxFUnl8oKQCUGpdgbNmFrlMitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035906; c=relaxed/simple;
	bh=Wdzpk95fdOcY+VI0+hEgyFYrIlHomqFb8WojEF8+Va8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4CMHPQKEY3bfMfbXAUI8yInMCJ2KRGAnk51ZU0zQekZqNn5a5CXiIlsQ0dMszApeVauLZ157qGWkC+9wDU4v3RwsdL2/M0HMD9WbUGlw8MnubHUO39hxEHcBQIgVBNHoJHBj+i8CQWu6G9itnNvk48tqvb1nWIXE3bI0OZ7ET0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=j6IIrrR2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="j6IIrrR2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so1144725a91.0
        for <damon@lists.linux.dev>; Thu, 06 Aug 2026 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786035905; x=1786640705; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QCUoY6bnepNP4266+8oc2addLFvwX3SEU5YCqHIwv2I=;
        b=j6IIrrR2ctJfKNL2HxPF9iWSO/ZAjjLoWAhoKjhmtK9Al/l49/jv6IoXSESzSDbJ+f
         V7yVkkh+QkeBmtuibzGElIE3ALtWpUYKT7vrUOEID/nV2tzbgq2J5HQDuNgmqkIaitZ1
         wYKoswC6wYeSPFn5ulru8Gn2we46BckyYX5iFTWx9LS0JFYw0sl34rEL37+xl6vVUp5A
         koZh11mzeU5ERul+NnOgJdNerJrnSFnIxfL9HJe2yB83vW/jS1XYsCFH7SVz8/ChEAQk
         NbXWXToVdjstqQ8mfVJX5Rb4MxgCZIRcNOWozQ0D5Ovs7LXWXovEX8XJWd3orm8rlIdB
         MRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035905; x=1786640705;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCUoY6bnepNP4266+8oc2addLFvwX3SEU5YCqHIwv2I=;
        b=VURieCJF7KT9VMyEW4mj0hnd28P3/+/HVS9VErkKqbDVdw0uhHN88FYOrbi2SIjnrO
         tMCesygqaixt8dZWqEWIKIpLxsz8NuXDtMhqCbFtNPMV/r+WiMwN6oycP44+z4aR+1al
         H0iIXKKDXdfIT0NeWB+WtZau7vOhEOvNUpQYBFS2h8Us9QNoqy/haOLRFw6KPpz26FQi
         XrX1/y5yT3OO8EJnhVy3LjKiy234ia/HC8en3IUZy7K//xANRFM9dgNYvjJzpk/J2vG2
         EdbvE9oCSluW5hQ26tvQK8bNovNXwijTh1i9ygykBLiqN+WhZJgCxVcZYa8kZ1O+Lshp
         W3pw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1pOIko9H2Ip+zKY4ME2/WdqoYTcNiRpe1bZiF0aPa/Wm02+wcQNnsMkBefF/CJn+6PM54NA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzNXeMiKyjANYDSDMOZNOYLSkNK7ubv8rDqR2d8fjXfRHEevsw
	hi9fhemCBrw2WaUZ4zapc4ubjE1q6RVgvAs7XcmFvVT6zPZCt93d9S2n8oAEMcuS6NQ=
X-Gm-Gg: AR+sD10ZUTVpTZ+DT+Vfl8YQ2g2TmNWfQOUe7mwGSrIDYgMlpU9ARHXsECcSoK5w7uY
	1IEZK+P5el+igh8XFOknYV171B47J0P1+IkJAZD+3Hl6pMPLj8Nc1zolAzGEn78VfyIFj/z+15A
	QtriDO9pMlrQxt+rBCZDLCD1UVnJP3+f2Avpr15n6+5EvNjQu3xWw34jdBWbjgnTLrzVwiea16G
	lunGuQWGOaNMZu4XxRTeOzA6PGQCGnLE/vYMABbUmUT/3/ypQ2Kf+GJaaMfjWZ//wNkq6m7pkwB
	ZG2ZsXu6wqdicyMiAGymWTynpzIXafgh9s5m/f9XOausoJ/WvpilApIseqLmZDtwgwFL5a3aXR7
	5LeeVP55gBqznKwETkaDcchDYepKLGDvJ6LVMfHng4fb64d0eUjIop4mHet0Ui4pcpmwAyJg3DW
	OMZacSxpqw9SbbtIFrp3qDevjfroujp6F5hwGjb61uXkUAen8AB2M7a35zglGQ1ZVK
X-Received: by 2002:a17:90b:224c:b0:38d:eaed:4adb with SMTP id 98e67ed59e1d1-39083b4ef8amr4108525a91.20.1786035904633;
        Thu, 06 Aug 2026 10:05:04 -0700 (PDT)
Received: from fedora ([2607:fb91:201f:cebc:3a68:390a:144e:1b87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca50acddsm27805225c88.3.2026.08.06.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:05:04 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:05:00 -0500
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sj@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	usama.arif@linux.dev, vbabka@kernel.org, jannh@google.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in
 damon_get_folio()
Message-ID: <anS-vK1MaC8sWoMK@fedora>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-2-gourry@gourry.net>
 <anSOKjTerc97fCGx@lucifer>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anSOKjTerc97fCGx@lucifer>

On Thu, Aug 06, 2026 at 02:37:59PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Jul 28, 2026 at 03:47:11PM -0400, Gregory Price wrote:
> > All DAMON physical- and virtual-address operations obtain their folios
> > through damon_get_folio(). That helper already excludes ZONE_DEVICE
> > memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> > this is inconsistent with other callers in mm/ which test explicitly.
> >
> > Add an explicit folio_is_zone_device() rejection in damon_get_folio()
> > so the guarantee lives in one place and covers every caller uniformly,
> > consistent with other mm walkers that reject zone device folios.
> >
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> Thanks, nice to make it explicit!
> 
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>

SJ Asked me to drop it, so I most likely will, but yeah - this exact
patch is a good example of how many footguns zone device gives us.

~Gregory
