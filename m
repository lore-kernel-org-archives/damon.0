Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218633AA4E2
	for <damon@lists.linux.dev>; Thu,  6 Aug 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035809; cv=none; b=oRhCWfXud2F1OvaY+NNF8yNB6jnSWlG4K0owtQM9LGLVzwZvfyTjZQRgB6eMoIR18VG/uW9J2Q9e8ccAL3me0wKrqP3v8QE1i/UKVRaKIuQxDJAZMGLMKR48hWn+PWFlOcoEFUX3lOYAlQZySy/wrFlgr3J3FdiYqQ+dZzntngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035809; c=relaxed/simple;
	bh=wH2Z/7SStNPXHVKuBAna047dlnh8OKumWppmtohqDBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsJXKgd8Jt/YyuobpmRtwN1+h5u5hLoyrMHDlsBjyz/cie8A4OrpfEddUA+KsV5f+PfwaPVMMUoEqepwe0q15mdENTIeBjBermKAh2x+wQimiPuqb6Kyx2e6/z3l9h+nxWvwEtaOqcbeKYP6SXj+f1REjWrMLAUNUf1hZiXBuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KgCqquDk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KgCqquDk"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2904803b3a.3
        for <damon@lists.linux.dev>; Thu, 06 Aug 2026 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786035806; x=1786640606; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jTcIYdDJrbFYM8SM/eR5/FInV0ODp6bCP4uR1qvvuCk=;
        b=KgCqquDkFS/gHuVUbH04nhKrXULuYz/9iX48nbpaOeFq5wQOJy99z1VWz335o6O+5y
         Gaxo5qx+WfymwdBukzfsnxT2t9a3q1e12Vl+apxOOtenukH7SpaErfFCSwZEnjqr8jF+
         KhwhBWhmJCaNiquotBH/gJKoGuhoFmAXzA6VDokTSHu2xZqBY/n3lb6PfAcq3/Y5a6CQ
         FPhP3+np023OpKGiV+nXaeGlPfWbXdbRBUHgXFJHi8k1e2V1Qy7B00eBpRbIyTQDkeeK
         wojuvdBPIhUb1yByJELRaUjIx1znjbnTW6mha6rqGDduUsmWJYh9fK+mDmYq7G6qsssa
         Hrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035806; x=1786640606;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTcIYdDJrbFYM8SM/eR5/FInV0ODp6bCP4uR1qvvuCk=;
        b=V2PIef8LUWUVDu2VDrkThNFs70OHRqh+SKcFsPdOHW5hC1eMGaIZiMLuFUrYKzh3kX
         6OY8HriQ4bTBJ375dtBY537ZBrFggk/dgUZa3lonrY9ch6/jwdHChWxLoOJVmbBUe0sp
         B34x6GASioF93lN3f4YfHHF4lAso9cGE3IDowNg30jFbxS12ifblBWw4r5bouDiag1q8
         rRYYw5XEHrb0/O2cuM59Ky47ZB/Gtx6Q2Nhu6nKBIBB+TQBCjBB6NU0MaL5abh0tbYqd
         D+sm9Im/2ak4FaikI+7dayMBGZfGeRAhTgjqwhwFUdrccQV7x2o16N+qUmj6JgJLAKpQ
         UwKw==
X-Forwarded-Encrypted: i=1; AHgh+RrE4j9ochjLyR6x+jYUQ8t7o128lfXtku4THjWNFH1hSuSwG4GdTJ7JCHI6jDPHJEshX+ySGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyn2N63BGiUux0sPBgl3gZzjF2S7bPs/e8vo13hApSED5k3ZPAB
	YpAJ3AkycQYUhyiJ33aDDzfnyWU7+Eoe7pUm2xEAUug3c+qp33C40FD8DJXfZXmuKho=
X-Gm-Gg: AR+sD13xogJUjNk5bqyV6oSvA9WUFTYpeRZocLQu2O4CrAUCxWsrRdW6gzoW7KWPDcp
	YbDvQw8srLGWXnj58Nh3YSDUpryiOVmssMM6pq0JOY4yDOo3PyB4Bk7lZ27ghx1rD8vh1vjkFDP
	mAncyZAsSIw54/dzaCXLVHcNYM0wq7afa7W5uv2R+ZBJVHmL4uERU+wMjb72mfCuzf40y5CsxB7
	oRHKn2IV0x4ZnIGcznT9Dd8PvyUwEU1Xqm7UwOeMWIT1J0JxyDlqoI8gzNSo4z6Ytlkfp0rbjMa
	L5g6NwGVBaYHZCDSEXm23z9JP+UG4/APnB3+5qwgrMP0/y3zFgzBh+Jg5LjqJvFXSIxXsl3q2Yw
	oGG/c1qoMoOO1APDl7wSzSLDmkrYQO0XBPLX2k/N4nUj0GhoEyCsGm0uS1UEZWXejOvJPz0LSKp
	0EdMbLDNKdR9XD9vGZc7W7c1QEveVPiNkmtaImRvyrC8I6t3B4p3CY9d3etHM2bE8c
X-Received: by 2002:a05:6a00:2ea8:b0:848:4c0c:9482 with SMTP id d2e1a72fcca58-84f2e0cc746mr17400031b3a.35.1786035804907;
        Thu, 06 Aug 2026 10:03:24 -0700 (PDT)
Received: from fedora ([2607:fb91:201f:cebc:3a68:390a:144e:1b87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453bb24csm1745790b3a.24.2026.08.06.10.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:03:24 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:03:19 -0500
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sj@kernel.org, akpm@linux-foundation.org,
	david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
	liam@infradead.org, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	usama.arif@linux.dev, vbabka@kernel.org, jannh@google.com,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/huge_memory: skip zone device folios in
 madvise_free_huge_pmd()
Message-ID: <anS-V-k61246FkkS@fedora>
References: <20260728194714.3713735-1-gourry@gourry.net>
 <20260728194714.3713735-3-gourry@gourry.net>
 <anSOvqN1_Hs190xi@lucifer>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anSOvqN1_Hs190xi@lucifer>

On Thu, Aug 06, 2026 at 02:59:22PM +0100, Lorenzo Stoakes (ARM) wrote:
> I kinda wish he had some generalised folio handler like:
> 
> 	struct folio_ops {
> 		int (*handle_empty_entry)(void *priv);
> 		int (*handle_normal_folio)(void *priv, struct folio *folio);
> 		int (*handle_softleaf_pte_entry)(void *priv, const pte_t *ptep);
> 		int (*handle_zone_folio)(void *priv, struct folio *folio);
> 		...
> 	};
> 
> Or I don't know an equivalent type of thing, as we keep having these same
> patterns emerge in mm that are duplicated in a million places with slight
> variations... :)
> 
> I wonder if C is expressive enough to get us to something sane though.
> 

This is functionally folio->pgmap except it's not generalized and it
causes us pain :[

I briefly took a forray into moving pgmap to be node-scope, and that
works decently, but first i'm just trying to clena up what i can for
zone device.

Anyway, i get what you're getting at here, and that would be nice.

> > Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> 
> Anyway LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>

many thanks :]
