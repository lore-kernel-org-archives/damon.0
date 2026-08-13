Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5682D3733
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 02:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786587974; cv=none; b=EEyhV64i5BQrXawIFQ5u7IUPbjyW20pxS14cd7IbPWF1Rv3nGw8Zj6D8K2eDTm20EIi8NjvBFmMnbiQTlAomMmWN0hLR5XdAgGIMJV1cpS3m6VW7mtP72ZIKFJ6HRMu4oLzc9uZvwxpisWiRYT7z6BGGAeJvihb17PfmFCkmcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786587974; c=relaxed/simple;
	bh=71TxTTwtQU0IL4fWyqvp5x+fJcMe1YkgaD0uLI9gfUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abvWcg92x8SjuM/y7dGa8IbtH9kwMeJBCMeaHq1mbDq5gNWycPIChQ4aUvVqRX4ylMm5kJ745J62KFzo5WpnQyyhKI9pfJRVby9lZ8sZ6m/lHBpH+whAkMADi4JAL4O1GA0X0nxnyLR0uvxnxt79Qn5mO340mdGY/aI+qLf3EGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LJiVtVQC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LJiVtVQC"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c1372f84dso13005361cf.2
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 19:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786587971; x=1787192771; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rJyuBNA61ADLE8D7qWrS7xw4VQ7YCE+rGhhYCzYs91I=;
        b=LJiVtVQCRjqzaQeZwwVGwJREulDWqSw7VwKyPQQQWSbe0c/axF4tGd8UBszo1+CDvh
         V/8QbQ3zA1zOguhVJ/9fc4fgIVad6ofXAUyYZSxk4hjIZcnkwfGuFAnS3q+4SP0sv/cu
         TiKAwYfxNi9hBRmOre77L6GAPIYtCXcWkqy7FE3sPBBA196fLCofVUdwCZcDc/jn/eMN
         dA4NiBl+DArhPq6xVX0DmHyqoTf195njQ+VNMTM9h+6dXSrvzsNmKhUp9uIB8ZTQE8bZ
         VzSiO3B2YC0AWMMLnLeDnhtCX7oLfEDCoU8Ngtl3VcfAUwjN+RI6Wykh5GRlabrQYSvy
         q49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786587971; x=1787192771;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJyuBNA61ADLE8D7qWrS7xw4VQ7YCE+rGhhYCzYs91I=;
        b=HuU1JmB6dO40ED/K22orVof+b3apr/VsoGcR58zxH6R733v/n0lPHM+uHmw+kGH8iW
         KgmD6trzhu/1U7o5hAOeZkfeEmXqUAtlTVl9Tt09NORmTlGaCZ5y9WnwpPROLgWzkV+n
         HKoFY7wvAdgWjVQ4/3Gha8nHbDm7I2Iy5RaIGrqY6KDIFbxUrFk/E4xAt93FLYA6cFsA
         fG/rarAfxGdPoXU7Dru+OY9ufLKGCnoi+ns0UD8TEds9og/pbxDFU5qMf0kx4mrhynV4
         AnwshHcxhCVZ0mT8c+98nv68HM18kGKiOYxFWDnFf5p9XhbuSBZotyTjmocX1METi0fq
         trTA==
X-Forwarded-Encrypted: i=1; AHgh+RpLRkb4fzSRlfN4IgQghKMkef20K2HGOrA7fYZiUJNo4saMLs3flxVRoVnf21J2t4chka7Fdw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyjxpvuxir0Hzs5OaGEiPyuKF6Gt4A8THUTSq8a4FgdMCvAxSBQ
	RfMHzY5ht5Z3GR+di1qgSQcz3PiYFkmtx5I8vof7D/2wYnCvMWj18ql5Jbayi/gWUQw=
X-Gm-Gg: AR+sD11ccfT4cBKgX7ZxF4K15HJMMz+zL1n8ulIy69jQJ17dtedFNLnjnv/QZI6tVs1
	st0Ol7Tge20KQSbJc1jPWPevHcL11LEblJcqkB2mFl9EvUMvYc39GBgg7uI92ghGAqiLzRJf+kI
	zDJCMMoAID16OKOgXTTp5KvgN8mD1Hjd5vJBudjqIRmQAkGQ7VRq/dOu6+7SeqCZyqe5MWrzicO
	BNeJ6Y23MGf3XussOaf2sLhXojiPdjwjcjrLHBNure3HsHiPXt8sB8X5BrmGzxIwlqWwCDNlL96
	qz2h2pUkljloQwNWsvo72NVurqGNMmwcKbGniS+0SzFp74UKVDYLApKYIpqa6JYQ0pWA2FX9ZN2
	NIM/kZ76hGh6QITF6n/clJdsQapsjXHLB/sg4eHDmJnpYuB9Kv3bhGqxpukkR57YKe3bZtoG0Kc
	DSrDuemPTd2WfApa6IXUIlgSg0mktYTPrRpkYJwh8OkJ23iA==
X-Received: by 2002:ac8:5892:0:b0:528:f72:a986 with SMTP id d75a77b69052e-52d73e973efmr27058371cf.44.1786587971243;
        Wed, 12 Aug 2026 19:26:11 -0700 (PDT)
Received: from fedora ([2601:19e:8500:d3c0::28fe])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d7400299esm7355661cf.26.2026.08.12.19.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:26:10 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:26:08 -0400
From: Gregory Price <gourry@gourry.net>
To: SJ Park <sj@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, linux-mm@kvack.org,
	damon@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, usama.arif@linux.dev,
	vbabka@kernel.org, jannh@google.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com
Subject: Re: [PATCH 1/4] mm/damon: defensively skip zone device folios in
 damon_get_folio()
Message-ID: <an0rQM7ZwWnB0nVD@fedora>
References: <anS-vK1MaC8sWoMK@fedora>
 <20260807000938.79851-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807000938.79851-1-sj@kernel.org>

On Thu, Aug 06, 2026 at 05:09:37PM -0700, SJ Park wrote:
> On Thu, 6 Aug 2026 12:05:00 -0500 Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Aug 06, 2026 at 02:37:59PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Tue, Jul 28, 2026 at 03:47:11PM -0400, Gregory Price wrote:
> > > > All DAMON physical- and virtual-address operations obtain their folios
> > > > through damon_get_folio(). That helper already excludes ZONE_DEVICE
> > > > memory implicitly via pfn_to_online_page() and folio_test_lru(), but
> > > > this is inconsistent with other callers in mm/ which test explicitly.
> > > >
> > > > Add an explicit folio_is_zone_device() rejection in damon_get_folio()
> > > > so the guarantee lives in one place and covers every caller uniformly,
> > > > consistent with other mm walkers that reject zone device folios.
> > > >
> > > > Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> > > 
> > > Thanks, nice to make it explicit!
> > > 
> > > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > >
> > 
> > SJ Asked me to drop it,
> 
> I didn't asked you to drop this.  I asked your thought about revisioning this
> for my concern.  And you replied [1] you can drop this.
>

Sorry I didn't mean to imply you pushed for one side or another, just
that the feedback you gave about not wanting dead code is reason enough
to drop it.

I will probably just go ahead and drop it unless Lorenzo thinks the
patch is worth keeping.  In my next private node iteration, it ends up
back in anyway - so we get a two for one without the intermediate patch.

~Gregory
