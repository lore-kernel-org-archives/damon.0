Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26D146E94
	for <damon@lists.linux.dev>; Fri, 23 Feb 2024 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730697; cv=none; b=F7xbcuQ/2U+5zQ7skKuTJavJ1wQEtehfzfsZ9YV6IVAZgYLJVkuui45Y/h16Ro8E0afxB8dAKbNaWpPMVjyQGvTy3hSHGwInrXeAZdWJ3WL1UugO4OpoDiN8JUbwE3UBPBiIHjwFFOLTIt3e8B+PjSM9nPAJKLE0pPRc0oT04ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730697; c=relaxed/simple;
	bh=7f1As03aJZ5G17xzI++8v4NQZu0uPOxyJM1g1JxaXKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbf+tvePQetUy/Q4QAImZA6Wto4hDwbht3q/Vo/FUG68Cecj6zqjh1EoDIV+ZqukUbwheFabwrVRjvd+v6kJ2635wvu+Zy2+1p8x40QkZddpURdGML0OI1uRr/hwKWWImSEz9isTJQX6ZP2cny/al28lX26yQUg+QDVSPL73UMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ola/3Cb1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ola/3Cb1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so12210825ad.1
        for <damon@lists.linux.dev>; Fri, 23 Feb 2024 15:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708730695; x=1709335495; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ao7UMHUlsZajZ+LBDOR+Sl5HBzayPn+Qg7pOB0l5nmg=;
        b=Ola/3Cb1Yj1BRSNdsILsyGaibRmp+BzXvH5FJnUwhwqmYy+qOUPK7l3jBEnzUberGd
         dzWpn0yOTAxUoH49jXKMxNs052Vvuof+GHynJeMzZAJVqNppVmgdWAU0lrhulpK6PG+u
         rW8Y2HJ6epKxVupC1Mg48bnoaZBZsInfUSvIEFBTIdfWDloNmsTNT8iyN3MR6GXBPlC9
         ROE5FGOKGdUvu8o2x7McJLl/AUJjLdqCaX9WrikTjPFD/3CCrRrJcabr6MmW3kPzI6Im
         3+5XWmDLNOZHH2t9PjSW0mmVLp/09fEPQYWNA0u/ZxZBSbTlVa15SiMXGQdWeS6dtNyh
         dO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708730695; x=1709335495;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ao7UMHUlsZajZ+LBDOR+Sl5HBzayPn+Qg7pOB0l5nmg=;
        b=iyH7onSz1SH2Uksjp0lrZMSOM6jSZ0uhmUFBKJLRYbWM2M1JNoxaF5gfG1XVf0ioOg
         HPS5XDSz7eXPtNg1f6nULhOlU7pra+FZWMxTufy+wKvJp1NdqiQZ6VhPt+oA1BrcotuE
         rKt67Rx5YFOhjegNUv44ToxPXnvbT5xdF0Xo1YfBcC+yRzSSr6IU1UQJuzrFgJ+qb620
         rqBGb2aFmQXYyscKU8wMMGHtQQBAHgzQhcFJ8yRbna1u3OK3l+O/JRem5tx5FvNrAK7/
         lxdC0bSRYQnFaN+VXVXMqLEKHO5M+9DXJgvsqkX2dNg7hkIHYdG12WF/sykViJQ0CYE8
         s2Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUTEqse0SY1q3FxsBuzBMVpgQDFtF1Qw/XoJzw4k2wAUhgB6SRYeHOmzDf0V0cfqHz+dKZyhRDLdpIwFGQJakhpdkpzjw4=
X-Gm-Message-State: AOJu0YwZGRhjvAZZT9fRLEpZaeza4gQbd55tq1gC9oAw7HHh5kzZKK68
	w1FMLDHxLNOqtUh2u+gAPVBv3v6STcCMCN44vTJgXaYTP9/v9ehm
X-Google-Smtp-Source: AGHT+IHoAtezr2Ke3U6LkITmDjk/2zVtt1gxQW74Hm0HM8ZpA1E7A/r7XcYhs/My3eSzHIgtDMirow==
X-Received: by 2002:a17:902:ea05:b0:1dc:6073:a3a4 with SMTP id s5-20020a170902ea0500b001dc6073a3a4mr1367734plg.3.1708730695517;
        Fri, 23 Feb 2024 15:24:55 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:e92a:5e0b:c881:39b6])
        by smtp.gmail.com with ESMTPSA id w19-20020a170902c79300b001d8f251c8b2sm12212042pla.221.2024.02.23.15.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 15:24:54 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Fri, 23 Feb 2024 15:24:53 -0800
From: Minchan Kim <minchan@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
	hannes@cmpxchg.org, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
Message-ID: <ZdkpRavkakwCnoIg@google.com>
References: <20240223041550.77157-1-21cnbao@gmail.com>
 <ZdkXpcAB6xWj2geh@google.com>
 <CAGsJ_4zPVNcP-7YQ8wkxmZu0xLkaQ-hyh98Ot0+RpyXm9o1krQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zPVNcP-7YQ8wkxmZu0xLkaQ-hyh98Ot0+RpyXm9o1krQ@mail.gmail.com>

On Sat, Feb 24, 2024 at 11:20:36AM +1300, Barry Song wrote:
> On Sat, Feb 24, 2024 at 11:09 AM Minchan Kim <minchan@kernel.org> wrote:
> >
> > Hi Barry,
> >
> > On Fri, Feb 23, 2024 at 05:15:50PM +1300, Barry Song wrote:
> > > From: Barry Song <v-songbaohua@oppo.com>
> > >
> > > While doing MADV_PAGEOUT, the current code will clear PTE young
> > > so that vmscan won't read young flags to allow the reclamation
> > > of madvised folios to go ahead.
> >
> > Isn't it good to accelerate reclaiming? vmscan checks whether the
> > page was accessed recenlty by the young bit from pte and if it is,
> > it doesn't reclaim the page. Since we have cleared the young bit
> > in pte in madvise_pageout, vmscan is likely to reclaim the page
> > since it wouldn't see the ferencecd_ptes from folio_check_references.
> 
> right, but the proposal is asking vmscan to skip the folio_check_references
> if this is a PAGEOUT. so we remove both pte_clear_young and rmap
> of folio_check_references.
> 
> >
> > Could you clarify if I miss something here?
> 
> guest you missed we are skipping folio_check_references now.
> we remove both, thus, make MADV_PAGEOUT 6% faster.

This makes sense to me.

Only concern was race with mlock during the reclaim but the race was already
there for normal page reclaming. Thus, mlock would already handle it.

Thanks.
